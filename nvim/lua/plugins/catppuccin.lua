return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			vim.cmd.colorscheme("catppuccin")
			require("catppuccin").setup({
				flavour = "auto",
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				custom_highlights = function(colors)
					return {
						Normal = { bg = colors.none },
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
						enabled = true,
					},
					harpoon = true,
					lsp_trouble = true,
					noice = true,
					mason = true,
				},
			})
		end,
	},
}
