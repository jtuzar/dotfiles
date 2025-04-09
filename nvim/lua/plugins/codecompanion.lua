return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "gemini",
				},
				inline = {
					adapter = "gemini",
				},
			},
		})
	end,
    keys = {
        {
            "<leader>k",
            "<cmd>CodeCompanionChat Toggle<CR>"
        },
        {
            "<leader>l",
            "<cmd>CodeCompanionActions<CR>"
        }
    }
}
