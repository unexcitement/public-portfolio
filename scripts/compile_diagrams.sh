#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# Ephemeral Docker Diagram Compiler (Mermaid CLI - Dark Mode Parallel)
# Compiles all .mmd diagrams across projects into standalone dark mode SVG vectors
# without installing any global NPM or Node dependencies on the host OS.
# ==============================================================================

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

IMAGE="minlag/mermaid-cli:12.0.0"
CONFIG_FILE="/data/scripts/mermaid-config.json"
BG_COLOR="#0d1117"
PARALLEL_JOBS="${PARALLEL_JOBS:-4}"

echo "=== Ephemeral Docker Diagram Compilation (Dark Mode) ==="
echo "Target Image: $IMAGE"
echo "Root Directory: $ROOT_DIR"
echo "Background Color: $BG_COLOR"
echo "Parallel Workers: $PARALLEL_JOBS"
echo ""

# Verify docker is accessible
if ! command -v docker >/dev/null 2>&1; then
    echo "ERROR: Docker is required to run ephemeral diagram compilation." >&2
    exit 1
fi

export ROOT_DIR IMAGE CONFIG_FILE BG_COLOR

compile_single() {
    local mmd_file="$1"
    local rel_path="${mmd_file#$ROOT_DIR/}"
    local svg_file="${mmd_file%.mmd}.svg"
    local rel_svg="${svg_file#$ROOT_DIR/}"
    
    echo "Compiling: $rel_path -> $rel_svg"
    
    docker run --rm \
        -u "$(id -u):$(id -g)" \
        -v "$ROOT_DIR:/data" \
        "$IMAGE" \
        -i "/data/$rel_path" \
        -o "/data/$rel_svg" \
        -c "$CONFIG_FILE" \
        -b "$BG_COLOR"
}

export -f compile_single

find "$ROOT_DIR/projects" -type f -name "*.mmd" -print0 | \
    xargs -0 -n 1 -P "$PARALLEL_JOBS" -I {} bash -c 'compile_single "$@"' _ {}

echo ""
echo "=== Compilation Complete ==="
echo "All diagrams have been successfully compiled into dark mode SVG."
