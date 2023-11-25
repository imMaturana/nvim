require("keymaps")
require("autocmd")
local plugins = require("plugins")

-- variables
local o = vim.o

-- line number
o.number = true
o.relativenumber = true

-- global status line
o.laststatus = 3

-- tab size
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true

-- plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins)
