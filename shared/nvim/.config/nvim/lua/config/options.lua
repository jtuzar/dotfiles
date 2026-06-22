-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = true

vim.filetype.add({
  extension = {
    hlsl  = "hlsl",
    hlsli = "hlsl",
  },
  pattern = {
    [".*%.vert%.hlsl"] = "hlsl",
    [".*%.frag%.hlsl"] = "hlsl",
    [".*%.comp%.hlsl"] = "hlsl",
  },
})

vim.g.root_spec = { { ".git" }, "lsp", "cwd" }
