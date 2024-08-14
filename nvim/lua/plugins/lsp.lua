return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
			"rshkarin/mason-nvim-lint",
			"mfussenegger/nvim-lint",
		},
		config = function()
			require("fidget").setup({})
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"tsserver",
					"angularls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
								},
							},
						})
					end,
					["angularls"] = function()
						local util = require("lspconfig.util")
						local lspconfig = require("lspconfig")
						lspconfig.angularls.setup({
							root_dir = util.root_pattern("angular.json", "project.json"),
						})
					end,
				},
			})
			require("mason-nvim-lint").setup()

			vim.diagnostic.config({
				update_on_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end,
	},
}
