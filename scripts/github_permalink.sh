#!/bin/bash

# GitHub Permalink Generator for Helix
# This script generates a GitHub permalink for the current file and line selection
# Usage: github_permalink.sh <file_path> <start_line> [end_line]

FILE_PATH="$1"
START_LINE="$2"
END_LINE="${3:-$START_LINE}"

if [ -z "$FILE_PATH" ] || [ -z "$START_LINE" ]; then
    echo "Usage: $0 <file_path> <start_line> [end_line]"
    exit 1
fi

# Get the git root directory
GIT_ROOT=$(cd "$(dirname "$FILE_PATH")" && git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$GIT_ROOT" ]; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Get the relative path from git root
RELATIVE_PATH=$(realpath --relative-to="$GIT_ROOT" "$FILE_PATH" 2>/dev/null || python3 -c "import os.path; print(os.path.relpath('$FILE_PATH', '$GIT_ROOT'))")

# Get the current commit SHA
COMMIT_SHA=$(cd "$GIT_ROOT" && git rev-parse HEAD)

# Get the remote URL and convert it to GitHub URL
REMOTE_URL=$(cd "$GIT_ROOT" && git config --get remote.origin.url)

# Convert SSH URL to HTTPS if needed
if [[ $REMOTE_URL == git@github.com:* ]]; then
    REMOTE_URL=$(echo "$REMOTE_URL" | sed 's/git@github.com:/https:\/\/github.com\//' | sed 's/\.git$//')
elif [[ $REMOTE_URL == https://github.com/* ]]; then
    REMOTE_URL=$(echo "$REMOTE_URL" | sed 's/\.git$//')
fi

# Construct the permalink
if [ "$START_LINE" = "$END_LINE" ]; then
    PERMALINK="${REMOTE_URL}/blob/${COMMIT_SHA}/${RELATIVE_PATH}#L${START_LINE}"
else
    PERMALINK="${REMOTE_URL}/blob/${COMMIT_SHA}/${RELATIVE_PATH}#L${START_LINE}-L${END_LINE}"
fi

# Copy to clipboard (works on macOS, Linux with xclip, and Linux with wl-clipboard)
if command -v pbcopy &> /dev/null; then
    echo -n "$PERMALINK" | pbcopy
    echo "GitHub permalink copied to clipboard:"
elif command -v xclip &> /dev/null; then
    echo -n "$PERMALINK" | xclip -selection clipboard
    echo "GitHub permalink copied to clipboard:"
elif command -v wl-copy &> /dev/null; then
    echo -n "$PERMALINK" | wl-copy
    echo "GitHub permalink copied to clipboard:"
else
    echo "No clipboard tool found. Permalink:"
fi

echo "$PERMALINK"
