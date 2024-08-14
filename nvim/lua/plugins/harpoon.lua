return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		vim.keymap.set("n", "<C-a>", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<C-s>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<C-j>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-k>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-l>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<C-;>", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-K-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-K-N>", function()
			harpoon:list():next()
		end)
	end,
}
