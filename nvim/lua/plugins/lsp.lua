return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
			"mfussenegger/nvim-lint",
			"roobert/tailwindcss-colorizer-cmp.nvim",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("fidget").setup({})
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local lspkind_format = require("lspkind").cmp_format()

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
				formatting = {
					format = function(entry, item)
						lspkind_format(entry, item)
						return require("tailwindcss-colorizer-cmp").formatter(entry, item)
					end,
				},
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Capabilities required for the visualstudio lsps (css, html, etc)
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"gopls",
					"tailwindcss",
					"html",
					"denols",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({ capabilities = capabilities })
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
					["denols"] = function()
						local nvim_lsp = require("lspconfig")
						nvim_lsp.denols.setup({
							root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
						})
					end,
					["ts_ls"] = function()
						local nvim_lsp = require("lspconfig")
						nvim_lsp.ts_ls.setup({
							root_dir = nvim_lsp.util.root_pattern("package.json"),
							single_file_support = false,
						})
					end,
				},
			})

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
