#!/bin/bash

# Usage: focus_or_launch.sh <process_name> <window_class> <launch_command>
# Example: focus_or_launch.sh ghostty com.mitchellh.ghostty ghostty

PROCESS_NAME="$1"
WINDOW_CLASS="$2"
LAUNCH_CMD="$3"

# Check if process is running
if ! pgrep "$PROCESS_NAME" > /dev/null; then
    # Process not running, launch it
    exec $LAUNCH_CMD
    exit
fi

# Get current workspace number
CURRENT_WORKSPACE=$(hyprctl activewindow | grep "workspace:" | awk '{print $2}')

# Find window address on current workspace
WINDOW_ON_CURRENT=$(hyprctl clients -j | jq -r ".[] | select(.class == \"$WINDOW_CLASS\" and .workspace.id == $CURRENT_WORKSPACE) | .address" | head -1)

if [ -n "$WINDOW_ON_CURRENT" ] && [ "$WINDOW_ON_CURRENT" != "null" ]; then
    # Found window on current workspace, focus it by address
    hyprctl dispatch focuswindow "address:$WINDOW_ON_CURRENT"
else
    # No window on current workspace, check if any exists on other workspaces
    WINDOW_EXISTS=$(hyprctl clients -j | jq -r ".[] | select(.class == \"$WINDOW_CLASS\") | .address" | head -1)
    
    if [ -n "$WINDOW_EXISTS" ] && [ "$WINDOW_EXISTS" != "null" ]; then
        # Window exists on another workspace, focus it (will switch workspace)
        hyprctl dispatch focuswindow "address:$WINDOW_EXISTS"
    else
        # No window exists, launch new one
        exec $LAUNCH_CMD
    fi
fi