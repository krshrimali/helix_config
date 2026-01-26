#!/usr/bin/env bash
# Copy absolute file path with line number(s) to clipboard

set -euo pipefail

FILE="${1:-.}"
LINE_START="${2:-1}"
LINE_END="${3:-$LINE_START}"

# Get absolute path
ABSOLUTE_PATH=$(realpath "$FILE")

# Format: path:line or path:start-end
if [ "$LINE_START" = "$LINE_END" ]; then
    RESULT="${ABSOLUTE_PATH}:${LINE_START}"
else
    RESULT="${ABSOLUTE_PATH}:${LINE_START}-${LINE_END}"
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
