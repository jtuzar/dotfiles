#!/bin/bash

# Generate clipse theme files from catppuccin palette
PALETTE_JSON="$HOME/dotfiles/catppuccin_palette.json"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function to get color from palette
get_color() {
    local variant="$1"
    local color_name="$2"
    jq -r ".${variant}.colors.${color_name}.hex" "$PALETTE_JSON"
}

# Generate Mocha (dark) theme
cat > "$SCRIPT_DIR/catppuccin_mocha.json" << EOF
{
    "useCustomTheme": true,
    "TitleFore": "$(get_color mocha text)",
    "TitleBack": "$(get_color mocha base)",
    "TitleInfo": "$(get_color mocha blue)",
    "NormalTitle": "$(get_color mocha text)",
    "DimmedTitle": "$(get_color mocha overlay0)",
    "SelectedTitle": "$(get_color mocha yellow)",
    "NormalDesc": "$(get_color mocha subtext0)",
    "DimmedDesc": "$(get_color mocha overlay0)",
    "SelectedDesc": "$(get_color mocha yellow)",
    "StatusMsg": "$(get_color mocha green)",
    "PinIndicatorColor": "$(get_color mocha yellow)",
    "SelectedBorder": "$(get_color mocha yellow)",
    "SelectedDescBorder": "$(get_color mocha yellow)",
    "FilteredMatch": "$(get_color mocha text)",
    "FilterPrompt": "$(get_color mocha green)",
    "FilterInfo": "$(get_color mocha blue)",
    "FilterText": "$(get_color mocha text)",
    "FilterCursor": "$(get_color mocha yellow)",
    "HelpKey": "$(get_color mocha overlay1)",
    "HelpDesc": "$(get_color mocha overlay0)",
    "PageActiveDot": "$(get_color mocha yellow)",
    "PageInactiveDot": "$(get_color mocha overlay0)",
    "DividerDot": "$(get_color mocha blue)",
    "PreviewedText": "$(get_color mocha text)",
    "PreviewBorder": "$(get_color mocha yellow)"
}
EOF

# Generate Latte (light) theme
cat > "$SCRIPT_DIR/catppuccin_latte.json" << EOF
{
    "useCustomTheme": true,
    "TitleFore": "$(get_color latte text)",
    "TitleBack": "$(get_color latte base)",
    "TitleInfo": "$(get_color latte blue)",
    "NormalTitle": "$(get_color latte text)",
    "DimmedTitle": "$(get_color latte overlay0)",
    "SelectedTitle": "$(get_color latte yellow)",
    "NormalDesc": "$(get_color latte subtext0)",
    "DimmedDesc": "$(get_color latte overlay0)",
    "SelectedDesc": "$(get_color latte yellow)",
    "StatusMsg": "$(get_color latte green)",
    "PinIndicatorColor": "$(get_color latte yellow)",
    "SelectedBorder": "$(get_color latte yellow)",
    "SelectedDescBorder": "$(get_color latte yellow)",
    "FilteredMatch": "$(get_color latte text)",
    "FilterPrompt": "$(get_color latte green)",
    "FilterInfo": "$(get_color latte blue)",
    "FilterText": "$(get_color latte text)",
    "FilterCursor": "$(get_color latte yellow)",
    "HelpKey": "$(get_color latte overlay1)",
    "HelpDesc": "$(get_color latte overlay0)",
    "PageActiveDot": "$(get_color latte yellow)",
    "PageInactiveDot": "$(get_color latte overlay0)",
    "DividerDot": "$(get_color latte blue)",
    "PreviewedText": "$(get_color latte text)",
    "PreviewBorder": "$(get_color latte yellow)"
}
EOF

echo "Generated clipse themes from catppuccin palette"