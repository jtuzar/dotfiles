# Windows-specific dotfiles

Place Windows-only stow-style packages in this directory.

The bootstrap script links:
- shared Neovim config from `shared/nvim` into `%LOCALAPPDATA%\\nvim`
- shared IdeaVim config from `shared/jetbrains/.ideavimrc` into `%USERPROFILE%\\.ideavimrc`
- PowerShell profile into `%USERPROFILE%\\Documents\\PowerShell`
- WezTerm config (`windows/wezterm/.wezterm.lua`) into `%USERPROFILE%\\.wezterm.lua`
- GlazeWM config (`windows/glazewm/config.yaml`) into `%USERPROFILE%\\.glzr\\glazewm\\config.yaml`
- WezTerm PowerShell and WSL shortcuts into the Start Menu
- WezTerm PowerShell starts with the MSVC x64 environment when Visual Studio C++ tools are installed
- WezTerm Plain PowerShell shortcut into the Start Menu when Visual Studio C++ tools are installed

Use `WezTerm PowerShell` or `WezTerm MSVC x64 PowerShell` for builds that require the native x64 MSVC environment, such as Odin's `build.bat release`.
