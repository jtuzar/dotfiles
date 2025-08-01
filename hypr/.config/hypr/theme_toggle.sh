#!/bin/bash

# Theme toggle script for Hyprland
# Toggles between dark and light themes using darkman
# Ensures proper portal integration for GTK apps

DARK_THEME="Catppuccin-Yellow-Dark"
LIGHT_THEME="Catppuccin-Yellow-Light"

# Path to catppuccin palette JSON
PALETTE_JSON="$HOME/dotfiles/hypr/.config/hypr/catppuccin_palette.json"

# Function to get color from palette JSON
get_color() {
    local theme="$1"
    local color_name="$2"
    
    if [ "$theme" = "dark" ]; then
        jq -r ".mocha.colors.$color_name.hex" "$PALETTE_JSON"
    else
        jq -r ".latte.colors.$color_name.hex" "$PALETTE_JSON"
    fi
}

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

    # Update GTK4 symlinks
    if [ -d "$HOME/.themes/$theme/gtk-4.0" ]; then
        cd "$HOME/.config/gtk-4.0"
        rm -f assets gtk.css gtk-dark.css 2>/dev/null
        ln -sf "$HOME/.themes/$theme/gtk-4.0/assets" assets
        ln -sf "$HOME/.themes/$theme/gtk-4.0/gtk.css" gtk.css  
        ln -sf "$HOME/.themes/$theme/gtk-4.0/gtk-dark.css" gtk-dark.css
    fi

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
    local theme="$1"
    local starship_config="$HOME/dotfiles/starship/.config/starship/starship.toml"
    
    if [ "$theme" = "dark" ]; then
        # Use catppuccin_mocha for dark theme
        sed -i "s/^palette = .*/palette = 'catppuccin_mocha'/" "$starship_config"
    else
        # Use catppuccin_latte for light theme
        sed -i "s/^palette = .*/palette = 'catppuccin_latte'/" "$starship_config"
    fi
}

# Function to update Hyprland border colors
update_hyprland_borders() {
    local theme="$1"
    local yellow_color=$(get_color "$theme" "yellow" | sed 's/#//')
    local overlay1_color=$(get_color "$theme" "overlay1" | sed 's/#//')
    
    # Yellow active, overlay1 inactive
    hyprctl keyword general:col.active_border "rgb($yellow_color)"
    hyprctl keyword general:col.inactive_border "rgb($overlay1_color)"
}

# Function to update dunst theme
update_dunst_theme() {
    local theme="$1"
    local base_color=$(get_color "$theme" "base")
    local text_color=$(get_color "$theme" "text")
    local yellow_color=$(get_color "$theme" "yellow")
    local peach_color=$(get_color "$theme" "peach")

    # Get opposite theme colors for replacement
    if [ "$theme" = "dark" ]; then
        local old_base_color=$(get_color "light" "base")
        local old_text_color=$(get_color "light" "text")
    else
        local old_base_color=$(get_color "dark" "base")
        local old_text_color=$(get_color "dark" "text")
    fi

    # Update background and foreground colors
    sed -i "s/background = \"$old_base_color\"/background = \"$base_color\"/g" "$HOME/.config/dunst/dunstrc"
    sed -i "s/foreground = \"$old_text_color\"/foreground = \"$text_color\"/g" "$HOME/.config/dunst/dunstrc"
    
    # Update all frame colors except critical
    sed -i "s/frame_color = \"#[^\"]*\"/frame_color = \"$yellow_color\"/g" "$HOME/.config/dunst/dunstrc"
    
    # Set critical frame color to peach
    sed -i "/\\[urgency_critical\\]/,/^\\[/ s/frame_color = \"#[^\"]*\"/frame_color = \"$peach_color\"/" "$HOME/.config/dunst/dunstrc"

    killall dunst 2>/dev/null || true
}

# Function to update waybar theme
update_waybar_theme() {
    local theme="$1"
    local waybar_style="$HOME/.config/waybar/style.css"
    
    if [ "$theme" = "dark" ]; then
        # Use catppuccin-mocha for dark theme
        sed -i 's|@import "./themes/catppuccin.*\.css";|@import "./themes/catppuccin-mocha.css";|' "$waybar_style"
    else
        # Use catppuccin-latte for light theme
        sed -i 's|@import "./themes/catppuccin.*\.css";|@import "./themes/catppuccin-latte.css";|' "$waybar_style"
    fi
    
    # Restart waybar to apply changes
    pkill waybar 2>/dev/null || true
    sleep 0.2
    waybar &
}

# Function to update bottom theme
update_bottom_theme() {
    local theme="$1"
    local bottom_config="$HOME/.config/bottom/bottom.toml"
    local themes_dir="$HOME/.config/bottom/themes"
    
    if [ "$theme" = "dark" ]; then
        if [ -f "$themes_dir/mocha.toml" ]; then
            cp "$themes_dir/mocha.toml" "$bottom_config"
        fi
    else
        if [ -f "$themes_dir/latte.toml" ]; then
            cp "$themes_dir/latte.toml" "$bottom_config"
        fi
    fi
    
    # Kill the ghostty terminal running btm
    pkill -f "ghostty.*btm" 2>/dev/null || true
    sleep 0.5
    # Restart btm in the magic workspace
    ~/.config/hypr/launch_btm.sh &
}

# Function to apply all theme updates
apply_theme() {
    local target_theme="$1"
    
    echo "Setting $target_theme theme..."
    
    if [ "$target_theme" = "dark" ]; then
        update_gtk_configs "$DARK_THEME" "prefer-dark"
    else
        update_gtk_configs "$LIGHT_THEME" "prefer-light"
    fi
    
    update_starship_theme "$target_theme"
    update_dunst_theme "$target_theme"
    update_hyprland_borders "$target_theme"
    update_waybar_theme "$target_theme"
    update_bottom_theme "$target_theme"
    darkman set "$target_theme"

    if command -v notify-send >/dev/null 2>&1; then
        notify-send "Theme Toggle" "Switched to $target_theme theme" -t 2000
    fi
}

# Get current state from darkman and toggle
current_theme=$(darkman get)

if [ "$current_theme" = "dark" ]; then
    apply_theme "light"
else
    apply_theme "dark"
fi

echo "Theme toggle complete. New state: $(darkman get)"
