return { -- Autoformat
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },
	keys = {
		{
			'<leader>f',
			function()
				require('conform').format { async = true, lsp_format = 'fallback' }
			end,
			mode = '',
			desc = '[F]ormat buffer',
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = {}
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return nil
			else
				return {
					timeout_ms = 500,
					lsp_format = 'fallback',
				}
			end
		end,
		formatters_by_ft = {
			lua = { 'stylua' },
			eruby = { 'erb_format' },
			yaml = { 'yamlfmt' },
			typescript = { 'eslint_d', 'prettier' },
			javascript = { 'eslint_d', 'prettier' },
			typescriptreact = { 'eslint_d', 'prettier' },
			javascriptreact = { 'eslint_d', 'prettier' },
			html = { 'prettier' },
			json = { 'prettier' },
			css = { 'prettier' },
			astro = { 'prettier' },
			mjs = { 'prettier' },
			svelte = { 'eslint_d', 'prettier' },
			cmake = { 'cmake_format' },
			cpp = { 'clang_format' },
			c = { 'clang_format' },
		},
	},
}
