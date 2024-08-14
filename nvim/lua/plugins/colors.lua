return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function ()
            require("catppuccin").setup {
                custom_highlights = function (colors)
                    return {
                        Normal = { bg = colors.none},
                        TelescopePromptNormal = { bg = colors.surface0 },
                        TelescopeNormal = { bg = colors.base },
                        TelescopeBorder = { fg = colors.blue, bg = colors.base },
                        NormalNC = { bg = colors.none },
                    }
                end,
                integrations = {
                    cmp = true,
                    treesitter = true,
                    telescope = {
                        enabled = true
                    },
                    harpoon = true,
                    lsp_trouble = true
                }
            }
        end
    }}
