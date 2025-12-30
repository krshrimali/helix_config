#!/bin/bash

# Helix GitHub Permalink Helper
# This script reads the current file path and line number from a temp file
# created by Helix and generates a GitHub permalink
#
# Usage in Helix: Create a command that writes file info to temp file,
# then calls this script

TEMP_FILE="${TMPDIR:-/tmp}/helix_file_info.txt"

if [ ! -f "$TEMP_FILE" ]; then
    echo "Error: No file info found. Make sure Helix wrote to $TEMP_FILE"
    exit 1
fi

# Read file path and line numbers from temp file
read -r FILE_PATH START_LINE END_LINE < "$TEMP_FILE"

if [ -z "$FILE_PATH" ] || [ -z "$START_LINE" ]; then
    echo "Error: Invalid file info in $TEMP_FILE"
    exit 1
fi

# Call the main permalink script
~/.config/helix/scripts/github_permalink.sh "$FILE_PATH" "$START_LINE" "$END_LINE"

# Clean up
rm -f "$TEMP_FILE"
