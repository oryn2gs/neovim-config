require "nvchad.options"

-- add yours here!

local opt = vim.opt
local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--
opt.number = true
opt.relativenumber = true
opt.autoindent = true
o.backspace = "indent,eol,start" -- allow backspace on indent

-- INFO: Folding
vim.o.foldmethod = "manual"
vim.o.foldopen = "all"
vim.o.foldclose = "all"
