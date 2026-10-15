#!/usr/bin/env bash
# ==============================================================================
# Script: clone_gitea_repos.sh
# Description: Clones all repositories accessible to the user from a Gitea instance
#              into source_repos/ with the directory prefix "gitea-<repo_name>".
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_BASE_DIR="${SCRIPT_DIR}/source_repos"
PREFIX="gitea-"

# Colors for terminal output
BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RED="\033[0;31m"
NC="\033[0m" # No Color

echo -e "${BOLD}${BLUE}=== Gitea Repository Cloner ===${NC}"
echo "Target directory: ${TARGET_BASE_DIR}"
echo "Prefix:           ${PREFIX}"
echo ""

# 1. Ensure target directory exists
mkdir -p "${TARGET_BASE_DIR}"

# 2. Collect Gitea Base URL
if [[ -z "${GITEA_URL:-}" ]]; then
    read -rp "Enter Gitea URL (e.g., https://git.example.com or http://localhost:3000): " GITEA_URL
fi
# Strip trailing slash
GITEA_URL="${GITEA_URL%/}"

# 3. Collect Gitea Personal Access Token
if [[ -z "${GITEA_TOKEN:-}" ]]; then
    echo -e "${YELLOW}Tip: In Gitea, navigate to Settings -> Applications -> Generate New Token${NC}"
    read -rsp "Enter Gitea Personal Access Token: " GITEA_TOKEN
    echo ""
fi

if [[ -z "${GITEA_TOKEN}" ]]; then
    echo -e "${RED}Error: Gitea token is required to fetch repositories.${NC}" >&2
    exit 1
fi

# 4. Preferred clone protocol
if [[ -z "${CLONE_PROTOCOL:-}" ]]; then
    read -rp "Clone via HTTPS or SSH? [HTTPS/ssh]: " CLONE_PROTOCOL
    CLONE_PROTOCOL="${CLONE_PROTOCOL:-HTTPS}"
fi
CLONE_PROTOCOL="$(echo "${CLONE_PROTOCOL}" | tr '[:lower:]' '[:upper:]')"

# 5. Verify authentication
echo -e "\n${BLUE}Verifying credentials...${NC}"
USER_RESP=$(curl -s -w "\n%{http_code}" -H "Authorization: token ${GITEA_TOKEN}" "${GITEA_URL}/api/v1/user")
HTTP_CODE=$(echo "${USER_RESP}" | tail -n1)
USER_JSON=$(echo "${USER_RESP}" | sed '$d')

if [[ "${HTTP_CODE}" -ne 200 ]]; then
    echo -e "${RED}Failed to authenticate with Gitea (HTTP ${HTTP_CODE}).${NC}"
    echo "Response: ${USER_JSON}"
    exit 1
fi

USERNAME=$(echo "${USER_JSON}" | jq -r '.login // empty')
echo -e "${GREEN}✓ Authenticated successfully as: ${BOLD}${USERNAME}${NC}\n"

# 6. Fetch and clone repositories
PAGE=1
PER_PAGE=50
TOTAL_CLONED=0
TOTAL_UPDATED=0

echo -e "${BLUE}Fetching repository list...${NC}"

while true; do
    API_URL="${GITEA_URL}/api/v1/user/repos?page=${PAGE}&limit=${PER_PAGE}"
    REPOS_JSON=$(curl -s -H "Authorization: token ${GITEA_TOKEN}" "${API_URL}")

    # Check for empty or error response
    COUNT=$(echo "${REPOS_JSON}" | jq '. | length' 2>/dev/null || echo "0")
    if [[ "${COUNT}" -eq 0 || "${REPOS_JSON}" == "[]" ]]; then
        break
    fi

    # Iterate through repositories
    for row in $(echo "${REPOS_JSON}" | jq -r '.[] | @base64'); do
        _jq() {
            echo "${row}" | base64 --decode | jq -r "${1}"
        }

        REPO_NAME=$(_jq '.name')
        REPO_FULL_NAME=$(_jq '.full_name')
        HTTPS_URL=$(_jq '.clone_url')
        SSH_URL=$(_jq '.ssh_url')

        DEST_DIR="${TARGET_BASE_DIR}/${PREFIX}${REPO_NAME}"

        # Choose clone URL
        if [[ "${CLONE_PROTOCOL}" == "SSH" && -n "${SSH_URL}" && "${SSH_URL}" != "null" ]]; then
            TARGET_CLONE_URL="${SSH_URL}"
        else
            # Inject token into HTTPS clone URL for seamless authentication
            # Format: https://token@domain/owner/repo.git
            TARGET_CLONE_URL=$(echo "${HTTPS_URL}" | sed -E "s#(https?://)#\1oauth2:${GITEA_TOKEN}@#")
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

    PAGE=$((PAGE + 1))
done

echo -e "${BOLD}${GREEN}=== Done! ===${NC}"
echo -e "New clones: ${TOTAL_CLONED}"
echo -e "Updated:    ${TOTAL_UPDATED}"
echo -e "Repositories stored in: ${TARGET_BASE_DIR}"
