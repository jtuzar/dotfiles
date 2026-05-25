local M = {}

local uname = vim.uv.os_uname()
M.is_windows = uname.sysname == "Windows_NT"
M.is_linux = uname.sysname == "Linux"

vim.g.dotfiles_is_windows = M.is_windows
vim.g.dotfiles_is_linux = M.is_linux

local target = M.is_windows and "config.os.windows" or "config.os.linux"
pcall(require, target)

return M
