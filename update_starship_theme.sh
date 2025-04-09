#!/bin/zsh

if defaults read -g AppleInterfaceStyle &> /dev/null; then
    echo "Detected macOS dark mode"
    # Dark mode
    sed -i '' 's/palette = "catppuccin_latte"/palette = "catppuccin_mocha"/' ~/.config/starship.toml
else
    echo "Detected macOS light mode"
    # Light mode
    sed -i '' 's/palette = "catppuccin_mocha"/palette = "catppuccin_latte"/' ~/.config/starship.toml
fi

# Reload Starship configuration
source ~/.zshrc

