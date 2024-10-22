return {
	"sbdchd/neoformat",
	config = function()
		vim.api.nvim_set_keymap("n", "<leader>f", ":Neoformat<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("v", "<leader>f", ":Neoformat<CR>", { noremap = true, silent = true })
		vim.g.neoformat_try_node_exe = 1
		vim.g.neoformat_enabled_javascript = { "prettier" }
		vim.g.neoformat_enabled_typescript = { "prettier" }
		vim.g.neoformat_enabled_json = { "prettier" }
		vim.g.neoformat_enabled_yaml = { "prettier" }
		vim.g.neoformat_enabled_markdown = { "prettier" }
		vim.g.neoformat_enabled_css = { "prettier" }
		vim.g.neoformat_enabled_scss = { "prettier" }
		vim.g.neoformat_enabled_html = { "prettier" }
		vim.g.neoformat_enabled_javascriptreact = { "prettier" }
		vim.g.neoformat_enabled_typescriptreact = { "prettier" }
		vim.g.neoformat_enabled_vue = { "prettier" }
		vim.g.neoformat_enabled_lua = { "stylua" }
		vim.g.neoformat_enabled_templ = { "templ_fmt" }
	end,
}
