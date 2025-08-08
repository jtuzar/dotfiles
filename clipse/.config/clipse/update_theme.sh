#!/bin/bash

# Update clipse theme reference based on dark/light mode
# Usage: ./update_theme.sh [dark|light]

THEME="$1"
CLIPSE_CONFIG="$HOME/.config/clipse/config.json"

if [ "$THEME" = "dark" ]; then
    sed -i 's/"themeFile": ".*"/"themeFile": "catppuccin_mocha.json"/' "$CLIPSE_CONFIG"
else
    sed -i 's/"themeFile": ".*"/"themeFile": "catppuccin_latte.json"/' "$CLIPSE_CONFIG"
fi