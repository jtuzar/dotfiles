return {
	"f-person/git-blame.nvim",
	config = function()
		require("gitblame").setup({
			enabled = false,
			message_when_not_committed = "Commit that RIGHT NOW!",
		})
		vim.api.nvim_set_keymap("n", "<leader>gb", ":GitBlameToggle<CR>", { noremap = true })
	end,
}
