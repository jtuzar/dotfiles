return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "rust", "lua", "vim", "vimdoc", "typescript", "javascript", "html" },
          sync_install = false,
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
 }
