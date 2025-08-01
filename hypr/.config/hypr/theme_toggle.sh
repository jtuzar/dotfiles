#!/bin/bash

# Theme toggle script for Hyprland
# Toggles between dark and light themes using darkman
# Ensures proper portal integration for GTK apps

DARK_THEME="Catppuccin-Yellow-Dark"
LIGHT_THEME="Catppuccin-Yellow-Light"

# Function to update GTK configurations
update_gtk_configs() {
    local theme="$1"
    local prefer_dark="$2"

    # Update gsettings
    gsettings set org.gnome.desktop.interface gtk-theme "$theme"
    gsettings set org.gnome.desktop.interface color-scheme "$prefer_dark"

    # Update GTK3 and GTK4 configs
    for gtk_version in gtk-3.0 gtk-4.0; do
        config_file="$HOME/.config/$gtk_version/settings.ini"
        if [ "$prefer_dark" = "prefer-dark" ]; then
            sed -i 's/gtk-application-prefer-dark-theme=0/gtk-application-prefer-dark-theme=1/' "$config_file"
        else
            sed -i 's/gtk-application-prefer-dark-theme=1/gtk-application-prefer-dark-theme=0/' "$config_file"
        fi
        sed -i "s/gtk-theme-name=.*/gtk-theme-name=$theme/" "$config_file"
    done

    # Update nwg-look config to prevent conflicts
    if [ -f "$HOME/.local/share/nwg-look/gsettings" ]; then
        sed -i "s/gtk-theme=.*/gtk-theme=$theme/" "$HOME/.local/share/nwg-look/gsettings"
        if [ "$prefer_dark" = "prefer-dark" ]; then
            sed -i 's/color-scheme=prefer-light/color-scheme=prefer-dark/' "$HOME/.local/share/nwg-look/gsettings"
        else
            sed -i 's/color-scheme=prefer-dark/color-scheme=prefer-light/' "$HOME/.local/share/nwg-look/gsettings"
        fi
    fi
}

# Function to update starship theme
update_starship_theme() {
    local is_dark="$1"
    local starship_config="$HOME/dotfiles/starship/.config/starship/starship.toml"
    
    if [ "$is_dark" = "true" ]; then
        # Use catppuccin_mocha for dark theme
        sed -i "s/^palette = .*/palette = 'catppuccin_mocha'/" "$starship_config"
    else
        # Use catppuccin_latte for light theme
        sed -i "s/^palette = .*/palette = 'catppuccin_latte'/" "$starship_config"
    fi
}

# Function to update Hyprland border colors
update_hyprland_borders() {
    local is_dark="$1"
    
    if [ "$is_dark" = "true" ]; then
        # Catppuccin Mocha colors - yellow active, overlay1 inactive
        hyprctl keyword general:col.active_border "rgb(f9e2af)"
        hyprctl keyword general:col.inactive_border "rgb(7f849c)"
    else
        # Catppuccin Latte colors - yellow active, overlay1 inactive  
        hyprctl keyword general:col.active_border "rgb(df8e1d)"
        hyprctl keyword general:col.inactive_border "rgb(8c8fa1)"
    fi
}

# Function to update dunst theme
update_dunst_theme() {
    local is_dark="$1"

    if [ "$is_dark" = "true" ]; then
        # Mocha (dark) colors
        sed -i 's/background = "#eff1f5"/background = "#1e1e2e"/g' "$HOME/.config/dunst/dunstrc"
        sed -i 's/foreground = "#4c4f69"/foreground = "#cdd6f4"/g' "$HOME/.config/dunst/dunstrc"
        # Update all frame colors except critical
        sed -i 's/frame_color = "#[^"]*"/frame_color = "#f9e2af"/g' "$HOME/.config/dunst/dunstrc"
        # Set critical frame color to peach
        sed -i '/\[urgency_critical\]/,/^\[/ s/frame_color = "#[^"]*"/frame_color = "#fab387"/' "$HOME/.config/dunst/dunstrc"
    else
        # Latte (light) colors
        sed -i 's/background = "#1e1e2e"/background = "#eff1f5"/g' "$HOME/.config/dunst/dunstrc"
        sed -i 's/foreground = "#cdd6f4"/foreground = "#4c4f69"/g' "$HOME/.config/dunst/dunstrc"
        # Update all frame colors except critical
        sed -i 's/frame_color = "#[^"]*"/frame_color = "#df8e1d"/g' "$HOME/.config/dunst/dunstrc"
        # Set critical frame color to peach
        sed -i '/\[urgency_critical\]/,/^\[/ s/frame_color = "#[^"]*"/frame_color = "#fe640b"/' "$HOME/.config/dunst/dunstrc"
    fi

    killall dunst 2>/dev/null || true
}

# Function to set dark theme
set_dark_theme() {
    echo "Setting dark theme..."

    update_gtk_configs "$DARK_THEME" "prefer-dark"
    update_starship_theme "true"
    update_dunst_theme "true"
    update_hyprland_borders "true"
    darkman set dark

    if command -v notify-send >/dev/null 2>&1; then
        notify-send "Theme Toggle" "Switched to dark theme" -t 2000
    fi
}

# Function to set light theme
set_light_theme() {
    echo "Setting light theme..."

    update_gtk_configs "$LIGHT_THEME" "prefer-light"
    update_starship_theme "false"
    update_dunst_theme "false"
    update_hyprland_borders "false"
    darkman set light

    if command -v notify-send >/dev/null 2>&1; then
        notify-send "Theme Toggle" "Switched to light theme" -t 2000
    fi
}

# Get current state from darkman instead of state file
current_state=$(darkman get)

if [ "$current_state" = "dark" ]; then
    set_light_theme
else
    set_dark_theme
fi

echo "Theme toggle complete. New state: $(darkman get)"
