require "nvchad.options"

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.hlsearch = true
vim.o.backspace = "indent,eol,start" -- allow backspace on indent
vim.o.cursorline = true
vim.o.cursorlineopt = "both" -- to enable cursorline!

-- INFO: Folding
vim.o.foldmethod = "manual"
vim.o.foldopen = "all"
vim.o.foldclose = "all"

-- INFO: This is the default NvChad setttings
-- disable some default providers
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
