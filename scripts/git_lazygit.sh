#!/bin/bash

# Lazygit wrapper for Helix
# Opens lazygit in the current git repository

# Find the git root directory
GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

if [ -z "$GIT_ROOT" ]; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Open lazygit in a new terminal window
# On macOS, use Terminal.app or iTerm2
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Try iTerm2 first
    if [ -d "/Applications/iTerm.app" ]; then
        osascript <<EOF
tell application "iTerm"
    activate
    tell current window
        create tab with default profile
        tell current session
            write text "cd '$GIT_ROOT' && lazygit"
        end tell
    end tell
end tell
EOF
    else
        # Fallback to Terminal.app
        osascript <<EOF
tell application "Terminal"
    activate
    do script "cd '$GIT_ROOT' && lazygit"
end tell
EOF
    fi
else
    # On Linux, try various terminal emulators
    if command -v alacritty &> /dev/null; then
        alacritty -e bash -c "cd '$GIT_ROOT' && lazygit" &
    elif command -v kitty &> /dev/null; then
        kitty bash -c "cd '$GIT_ROOT' && lazygit" &
    elif command -v gnome-terminal &> /dev/null; then
        gnome-terminal -- bash -c "cd '$GIT_ROOT' && lazygit" &
    else
        # Fallback: run lazygit in the current terminal (blocking)
        cd "$GIT_ROOT" && lazygit
    fi
fi
