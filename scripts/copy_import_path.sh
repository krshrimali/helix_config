#!/usr/bin/env bash
# Copy Python import path to clipboard

set -euo pipefail

FILE="${1:-.}"

# Get relative path from git root if in a git repo
if git rev-parse --show-toplevel >/dev/null 2>&1; then
    GIT_ROOT=$(git rev-parse --show-toplevel)
    RELATIVE_PATH=$(realpath --relative-to="$GIT_ROOT" "$FILE")
else
    # If not in git repo, use path relative to current directory
    RELATIVE_PATH=$(realpath --relative-to="$(pwd)" "$FILE")
fi

# Convert to Python import path:
# 1. Remove .py extension
# 2. Replace / with .
# 3. Handle __init__.py by removing it
IMPORT_PATH="$RELATIVE_PATH"

# Remove .py extension
IMPORT_PATH="${IMPORT_PATH%.py}"

# If it ends with __init__, remove it
IMPORT_PATH="${IMPORT_PATH%/__init__}"

# Replace / with .
IMPORT_PATH="${IMPORT_PATH//\//.}"

# Copy to clipboard (works with xclip, xsel, or wl-copy)
if command -v xclip >/dev/null 2>&1; then
    echo -n "$IMPORT_PATH" | xclip -selection clipboard
elif command -v xsel >/dev/null 2>&1; then
    echo -n "$IMPORT_PATH" | xsel --clipboard
elif command -v wl-copy >/dev/null 2>&1; then
    echo -n "$IMPORT_PATH" | wl-copy
else
    echo "Error: No clipboard utility found (xclip, xsel, or wl-copy)"
    exit 1
fi

echo "Copied import path: $IMPORT_PATH"
