#!/usr/bin/env bash
# Copy relative file path to clipboard

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

# Copy to clipboard (works with xclip, xsel, or wl-copy)
if command -v xclip >/dev/null 2>&1; then
    echo -n "$RELATIVE_PATH" | xclip -selection clipboard
elif command -v xsel >/dev/null 2>&1; then
    echo -n "$RELATIVE_PATH" | xsel --clipboard
elif command -v wl-copy >/dev/null 2>&1; then
    echo -n "$RELATIVE_PATH" | wl-copy
else
    echo "Error: No clipboard utility found (xclip, xsel, or wl-copy)"
    exit 1
fi

echo "Copied relative path: $RELATIVE_PATH"
