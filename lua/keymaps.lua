local keymap = vim.keymap

-- leader key
vim.g.mapleader = " "

-- switch between buffers
keymap.set("n", "<C-j>", ":bnext<CR>", { silent = true })
keymap.set("n", "<C-k>", ":bprev<CR>", { silent = true })

