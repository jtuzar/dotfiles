return {
	"stevearc/oil.nvim",
	opts = {},
	lazy = false,
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			use_default_keymaps = false,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["sh"] = "actions.select_vsplit",
				["sv"] = "actions.select_split",
				["st"] = "actions.select_tab",
				["op"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["or"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
			view_options = {
				show_hidden = true,
			},
		})
	end,
	keys = {
		{ "<leader>pv", "<cmd>Oil<cr>", mode = "n", desc = "Open Filesystem" },
	},
}
