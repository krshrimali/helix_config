#!/usr/bin/env bash
# Copy absolute file path to clipboard

set -euo pipefail

FILE="${1:-.}"

# Get absolute path
ABSOLUTE_PATH=$(realpath "$FILE")

# Copy to clipboard (works with xclip, xsel, or wl-copy)
if command -v xclip >/dev/null 2>&1; then
    echo -n "$ABSOLUTE_PATH" | xclip -selection clipboard
elif command -v xsel >/dev/null 2>&1; then
    echo -n "$ABSOLUTE_PATH" | xsel --clipboard
elif command -v wl-copy >/dev/null 2>&1; then
    echo -n "$ABSOLUTE_PATH" | wl-copy
else
    echo "Error: No clipboard utility found (xclip, xsel, or wl-copy)"
    exit 1
fi

echo "Copied absolute path: $ABSOLUTE_PATH"
