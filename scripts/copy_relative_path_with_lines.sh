#!/usr/bin/env bash
# Copy relative file path with line number(s) to clipboard

set -euo pipefail

FILE="${1:-.}"
LINE_START="${2:-1}"
LINE_END="${3:-$LINE_START}"

# Get relative path from git root if in a git repo
if git rev-parse --show-toplevel >/dev/null 2>&1; then
    GIT_ROOT=$(git rev-parse --show-toplevel)
    RELATIVE_PATH=$(realpath --relative-to="$GIT_ROOT" "$FILE")
else
    # If not in git repo, use path relative to current directory
    RELATIVE_PATH=$(realpath --relative-to="$(pwd)" "$FILE")
fi

# Format: path:line or path:start-end
if [ "$LINE_START" = "$LINE_END" ]; then
    RESULT="${RELATIVE_PATH}:${LINE_START}"
else
    RESULT="${RELATIVE_PATH}:${LINE_START}-${LINE_END}"
fi

# Copy to clipboard (works with xclip, xsel, or wl-copy)
if command -v xclip >/dev/null 2>&1; then
    echo -n "$RESULT" | xclip -selection clipboard
elif command -v xsel >/dev/null 2>&1; then
    echo -n "$RESULT" | xsel --clipboard
elif command -v wl-copy >/dev/null 2>&1; then
    echo -n "$RESULT" | wl-copy
else
    echo "Error: No clipboard utility found (xclip, xsel, or wl-copy)"
    exit 1
fi

echo "Copied: $RESULT"
