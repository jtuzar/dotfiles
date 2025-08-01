#!/bin/bash

# Set Hyprland border colors based on current darkman theme
# This script is meant to be run with exec-once in hyprland.conf

# Get current theme from darkman
current_theme=$(darkman get)

if [ "$current_theme" = "dark" ]; then
    # Catppuccin Mocha colors - yellow active, overlay1 inactive
    hyprctl keyword general:col.active_border "rgb(f9e2af)"
    hyprctl keyword general:col.inactive_border "rgb(7f849c)"
else
    # Catppuccin Latte colors - yellow active, overlay1 inactive
    hyprctl keyword general:col.active_border "rgb(df8e1d)"
    hyprctl keyword general:col.inactive_border "rgb(8c8fa1)"
fi