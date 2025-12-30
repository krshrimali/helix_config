#!/bin/bash

# GitHub Permalink Wrapper for Helix
# This script attempts to get the current file and line information from Helix
# and generate a GitHub permalink

# Helix doesn't easily provide file context to shell commands,
# so we use multiple fallback methods:
# 1. Check for a temp file with file info (if Helix wrote it)
# 2. Try to find the current Helix buffer using process inspection
# 3. Prompt the user for file path and line number

TEMP_FILE="${TMPDIR:-/tmp}/helix_file_info.txt"

get_helix_current_file() {
    # Try to find the currently open file in Helix using process inspection
    # This is a best-effort approach and may not always work

    # On macOS, we can use lsof to find files opened by hx process
    if command -v lsof &> /dev/null; then
        HX_PID=$(pgrep -n hx)
        if [ -n "$HX_PID" ]; then
            # Get the most recently accessed file by the hx process
            CURRENT_FILE=$(lsof -p "$HX_PID" 2>/dev/null | grep -E '\.rs$|\.py$|\.go$|\.js$|\.ts$|\.java$|\.cpp$|\.c$|\.h$|\.toml$|\.md$' | tail -1 | awk '{print $NF}')
            if [ -n "$CURRENT_FILE" ] && [ -f "$CURRENT_FILE" ]; then
                echo "$CURRENT_FILE"
                return 0
            fi
        fi
    fi

    return 1
}

# Method 1: Check for temp file
if [ -f "$TEMP_FILE" ]; then
    read -r FILE_PATH START_LINE END_LINE < "$TEMP_FILE"
    if [ -n "$FILE_PATH" ] && [ -n "$START_LINE" ]; then
        ~/.config/helix/scripts/github_permalink.sh "$FILE_PATH" "$START_LINE" "$END_LINE"
        rm -f "$TEMP_FILE"
        exit 0
    fi
fi

# Method 2: Try to auto-detect current file
CURRENT_FILE=$(get_helix_current_file)
if [ -n "$CURRENT_FILE" ]; then
    # Default to line 1 if we can't determine the current line
    START_LINE=1
    END_LINE=1

    echo "Auto-detected file: $CURRENT_FILE"
    echo "Using line 1 (couldn't detect current line - you may want to edit the URL)"
    ~/.config/helix/scripts/github_permalink.sh "$CURRENT_FILE" "$START_LINE" "$END_LINE"
    exit 0
fi

# Method 3: Interactive prompt
echo "Could not auto-detect file information."
echo "Please enter the file path (or press Ctrl+C to cancel):"
read -r FILE_PATH

if [ -z "$FILE_PATH" ]; then
    echo "No file path provided. Exiting."
    exit 1
fi

echo "Enter start line number:"
read -r START_LINE

echo "Enter end line number (press Enter to use same as start):"
read -r END_LINE

if [ -z "$END_LINE" ]; then
    END_LINE="$START_LINE"
fi

~/.config/helix/scripts/github_permalink.sh "$FILE_PATH" "$START_LINE" "$END_LINE"
