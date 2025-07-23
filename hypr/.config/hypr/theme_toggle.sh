#!/bin/bash

# Theme toggle script for Hyprland
# Toggles between dark and light themes using darkman
# Ensures proper portal integration for GTK apps

DARK_THEME="Catppuccin-Teal-Dark"
LIGHT_THEME="Catppuccin-Teal-Light"

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
    if [ -f "$starship_config" ]; then
        if [ "$is_dark" = "true" ]; then
            sed -i "s/palette = 'catppuccin_latte'/palette = 'catppuccin_mocha'/" "$starship_config"
        else
            sed -i "s/palette = 'catppuccin_mocha'/palette = 'catppuccin_latte'/" "$starship_config"
        fi
    fi
}

# Function to update Hyprland border colors
update_hyprland_borders() {
    local is_dark="$1"
    
    if [ "$is_dark" = "true" ]; then
        # Mocha (dark) colors - peach active, yellow inactive
        hyprctl keyword general:col.active_border "rgb(fab387)"
        hyprctl keyword general:col.inactive_border "rgb(f9e2af)"
    else
        # Latte (light) colors - peach active, yellow inactive  
        hyprctl keyword general:col.active_border "rgb(fe640b)"
        hyprctl keyword general:col.inactive_border "rgb(df8e1d)"
    fi
}

# Function to update dunst theme
update_dunst_theme() {
    local is_dark="$1"

    if [ "$is_dark" = "true" ]; then
        # Mocha (dark) colors
        sed -i '/# THEME_FRAME_COLOR/,+1 s/frame_color = .*/frame_color = "#89b4fa"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_LOW_BG/,+1 s/background = .*/background = "#1e1e2e"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_LOW_FG/,+1 s/foreground = .*/foreground = "#cdd6f4"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_NORMAL_BG/,+1 s/background = .*/background = "#1e1e2e"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_NORMAL_FG/,+1 s/foreground = .*/foreground = "#cdd6f4"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_CRITICAL_BG/,+1 s/background = .*/background = "#1e1e2e"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_CRITICAL_FG/,+1 s/foreground = .*/foreground = "#cdd6f4"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_CRITICAL_FRAME/,+1 s/frame_color = .*/frame_color = "#fab387"/' "$HOME/.config/dunst/dunstrc"
    else
        # Latte (light) colors
        sed -i '/# THEME_FRAME_COLOR/,+1 s/frame_color = .*/frame_color = "#1e66f5"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_LOW_BG/,+1 s/background = .*/background = "#eff1f5"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_LOW_FG/,+1 s/foreground = .*/foreground = "#4c4f69"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_NORMAL_BG/,+1 s/background = .*/background = "#eff1f5"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_NORMAL_FG/,+1 s/foreground = .*/foreground = "#4c4f69"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_CRITICAL_BG/,+1 s/background = .*/background = "#eff1f5"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_CRITICAL_FG/,+1 s/foreground = .*/foreground = "#4c4f69"/' "$HOME/.config/dunst/dunstrc"
        sed -i '/# THEME_URGENCY_CRITICAL_FRAME/,+1 s/frame_color = .*/frame_color = "#fe640b"/' "$HOME/.config/dunst/dunstrc"
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
