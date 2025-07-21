vim.g.mapleader = " "

vim.keymap.set("n", "<C-.>", vim.cmd.cnext)
vim.keymap.set("n", "<C-,>", vim.cmd.cprev)
vim.keymap.set("n", "<leader>p", "o<esc>Pk<CR>")
vim.keymap.set("n", "<leader><leader>", vim.cmd.so)
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "gg\"+yG")
vim.keymap.set("n", "<leader>cc", ":Git commit -m \"\"")
vim.keymap.set("n", "<leader>nh", ":nohls<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")
vim.keymap.set("v", "<leader>p", "\"_dP")
vim.keymap.set("v", "<leader>y", "\"+y")
