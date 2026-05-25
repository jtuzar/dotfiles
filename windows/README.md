# Windows-specific dotfiles

Place Windows-only stow-style packages in this directory.

The bootstrap script links:
- shared Neovim config from `shared/nvim` into `%LOCALAPPDATA%\\nvim`
- PowerShell profile into `%USERPROFILE%\\Documents\\PowerShell`
- WezTerm config (`windows/wezterm/.wezterm.lua`) into `%USERPROFILE%\\.wezterm.lua`
