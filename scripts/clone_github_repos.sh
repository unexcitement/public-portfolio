#!/usr/bin/env bash
# ==============================================================================
# Script: clone_github_repos.sh
# Description: Clones all repositories accessible to the user from GitHub
#              into source_repos/ with directory prefix "github-<repo_name>".
#              Preserves duplicates across accounts/orgs without collision.
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_BASE_DIR="${SCRIPT_DIR}/source_repos"
PREFIX="github-"

# Colors for terminal output
BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RED="\033[0;31m"
NC="\033[0m" # No Color

echo -e "${BOLD}${BLUE}=== GitHub Repository Cloner ===${NC}"
echo "Target directory: ${TARGET_BASE_DIR}"
echo "Prefix:           ${PREFIX}"
echo ""

# 1. Ensure target directory exists
mkdir -p "${TARGET_BASE_DIR}"

# 2. Collect GitHub Personal Access Token
if [[ -z "${GITHUB_TOKEN:-}" ]]; then
    echo -e "${YELLOW}Tip: Create a token at https://github.com/settings/tokens (Classic with 'repo' scope or Fine-grained with 'Contents: Read-only')${NC}"
    read -rsp "Enter GitHub Personal Access Token: " GITHUB_TOKEN
    echo ""
fi

if [[ -z "${GITHUB_TOKEN}" ]]; then
    echo -e "${RED}Error: GitHub token is required to list and clone repositories.${NC}" >&2
    exit 1
fi

# 3. Preferred clone protocol
if [[ -z "${CLONE_PROTOCOL:-}" ]]; then
    read -rp "Clone via HTTPS or SSH? [HTTPS/ssh]: " CLONE_PROTOCOL
    CLONE_PROTOCOL="${CLONE_PROTOCOL:-HTTPS}"
fi
CLONE_PROTOCOL="$(echo "${CLONE_PROTOCOL}" | tr '[:lower:]' '[:upper:]')"

# 4. Verify authentication
echo -e "\n${BLUE}Verifying GitHub token...${NC}"
USER_RESP=$(curl -s -w "\n%{http_code}" \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/user")

HTTP_CODE=$(echo "${USER_RESP}" | tail -n1)
USER_JSON=$(echo "${USER_RESP}" | sed '$d')

if [[ "${HTTP_CODE}" -ne 200 ]]; then
    echo -e "${RED}Failed to authenticate with GitHub (HTTP ${HTTP_CODE}).${NC}"
    echo "Response: ${USER_JSON}"
    exit 1
fi

USERNAME=$(echo "${USER_JSON}" | jq -r '.login // empty')
echo -e "${GREEN}✓ Authenticated successfully as: ${BOLD}${USERNAME}${NC}\n"

# 5. Fetch and clone repositories
PAGE=1
PER_PAGE=100
TOTAL_CLONED=0
TOTAL_UPDATED=0

echo -e "${BLUE}Fetching repository list from GitHub...${NC}"

while true; do
    API_URL="https://api.github.com/user/repos?per_page=${PER_PAGE}&page=${PAGE}&affiliation=owner,collaborator,organization_member"
    REPOS_JSON=$(curl -s \
        -H "Authorization: Bearer ${GITHUB_TOKEN}" \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "${API_URL}")

    # Check for empty array or errors
    COUNT=$(echo "${REPOS_JSON}" | jq '. | length' 2>/dev/null || echo "0")
    if [[ "${COUNT}" -eq 0 || "${REPOS_JSON}" == "[]" ]]; then
        break
    fi

    # Check for API error response object
    API_ERROR=$(echo "${REPOS_JSON}" | jq -r '.message // empty' 2>/dev/null || true)
    if [[ -n "${API_ERROR}" ]]; then
        echo -e "${RED}GitHub API Error: ${API_ERROR}${NC}"
        break
    fi

    for row in $(echo "${REPOS_JSON}" | jq -r '.[] | @base64'); do
        _jq() {
            echo "${row}" | base64 --decode | jq -r "${1}"
        }

        REPO_NAME=$(_jq '.name')
        REPO_FULL_NAME=$(_jq '.full_name')
        OWNER_LOGIN=$(_jq '.owner.login')
        HTTPS_URL=$(_jq '.clone_url')
        SSH_URL=$(_jq '.ssh_url')

        # Determine target directory: default to github-<repo_name>
        DEST_DIR="${TARGET_BASE_DIR}/${PREFIX}${REPO_NAME}"

        # If destination directory already exists, check if it's the exact same repo or a duplicate name
        if [[ -d "${DEST_DIR}/.git" ]]; then
            EXISTING_ORIGIN=$(git -C "${DEST_DIR}" config --get remote.origin.url || true)
            # If the remote origin does not match this repo, avoid collision by appending owner: github-<owner>-<repo>
            if [[ -n "${EXISTING_ORIGIN}" && "${EXISTING_ORIGIN}" != *"${REPO_FULL_NAME}"* ]]; then
                echo -e "    ${YELLOW}Duplicate repository name detected for '${REPO_NAME}' (different remote).${NC}"
                DEST_DIR="${TARGET_BASE_DIR}/${PREFIX}${OWNER_LOGIN}-${REPO_NAME}"
            fi
        fi

        # Choose clone URL
        if [[ "${CLONE_PROTOCOL}" == "SSH" && -n "${SSH_URL}" && "${SSH_URL}" != "null" ]]; then
            TARGET_CLONE_URL="${SSH_URL}"
        else
            # Inject token for automated authentication to private repos
            TARGET_CLONE_URL=$(echo "${HTTPS_URL}" | sed -E "s#(https?://)#\1x-access-token:${GITHUB_TOKEN}@#")
        fi

        echo -e "${BOLD}--> [${REPO_FULL_NAME}]${NC}"
        echo -e "    Destination: ${DEST_DIR}"

        if [[ -d "${DEST_DIR}/.git" ]]; then
            echo -e "    ${YELLOW}Directory exists. Updating via git fetch & pull...${NC}"
            git -C "${DEST_DIR}" fetch --all --prune
            git -C "${DEST_DIR}" pull --ff-only || echo -e "    ${YELLOW}Could not fast-forward pull. Left intact.${NC}"
            TOTAL_UPDATED=$((TOTAL_UPDATED + 1))
        else
            echo -e "    ${GREEN}Cloning...${NC}"
            git clone "${TARGET_CLONE_URL}" "${DEST_DIR}"
            TOTAL_CLONED=$((TOTAL_CLONED + 1))
        fi
        echo ""
    done

    # If count is less than per_page, we've reached the last page
    if [[ "${COUNT}" -lt "${PER_PAGE}" ]]; then
        break
    fi

    PAGE=$((PAGE + 1))
done

echo -e "${BOLD}${GREEN}=== Done! ===${NC}"
echo -e "New clones: ${TOTAL_CLONED}"
echo -e "Updated:    ${TOTAL_UPDATED}"
echo -e "Repositories stored in: ${TARGET_BASE_DIR}"
