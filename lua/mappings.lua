require "nvchad.mappings"

local map = vim.keymap.set

-- basic
map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "i", "n", "v" }, "<C-q>", "<cmd>:wa | qall<CR>", { desc = "Save all and exit" })

-- Select all
map("n", "<C-a>", "gg<S-v>G")

-- nvimtree
map("n", "<leader>ub", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })
map("n", "<leader>f", "<cmd>NvimTreeFindFile<CR>", { desc = "Nvimtree find files and folder" })

--telescope git commands

-- Telecope media files
map("n", "<leader>fm", "<cmd>Telescope media_files<CR>", { desc = "Telescope find media files" })

-- formatters
map("n", "<leader>fp", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format Files" })

-- Window
map("n", "<leader>ws", ":split<Return>", { desc = "Window split horizontally" })
map("n", "<leader>wv", ":vsplit<Return>", { desc = "Window split vertically" })
map("n", "<leader>wh", "<C-w>h", { desc = "Window move left" })
map("n", "<leader>wk", "<C-w>k", { desc = "Window move up" })
map("n", "<leader>wj", "<C-w>j", { desc = "Window move down" })
map("n", "<leader>wl", "<C-w>l", { desc = "Window move right", noremap = true, silent = true }) -- clashes with the lsp mappings
map("n", "<leader>w=", "<C-w>=", { desc = "Window resize equal" })
map("n", "<leader>w|", "<C-w>|", { desc = "Window rezize max width" })
map("n", "<leader>w_", "<C-w>_", { desc = "Window resize max height" })
map("n", "<leader>wo", "<C-w>o", { desc = "Window close all other" })
map("n", "<leader>wx", "<C-w>x", { desc = "Window swap current with next" })

-- buffers
map("i", "jj", "<ESC>", { desc = "Exit insert mode" })
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Buffer New" })
map("n", "<leader>bd", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer close current" })

-- Deletes all the buffers except the current one
function delete_other_buffers()
  local current_buffer = vim.api.nvim_get_current_buf()
  local all_buffers = vim.api.nvim_list_bufs()
  for _, buffer in ipairs(all_buffers) do
    if buffer ~= current_buffer then
      vim.api.nvim_buf_delete(buffer, { force = true })
    end
  end
end
map("n", "<leader>bo", ":lua delete_other_buffers()<CR>", { noremap = true, desc = "Buffer close all other" })

-- terminal
map({ "n", "t" }, "<leader>tt", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.3 }
end, { desc = "Terminal Toggleable vertical term" })

map("n", "<leader>th", function()
  require("nvchad.term").new { pos = "sp", size = 0.3 }
end, { desc = "Terminal New horizontal term" })

map("n", "<leader>tv", function()
  require("nvchad.term").new { pos = "vsp", size = 0.3 }
end, { desc = "Terminal New vertical window" })

map("t", "<ESC>", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_close(win, true)
end, { desc = "Terminal Close term in terminal mode" })

-- Disable Nvchad mappings
local nomap = vim.keymap.del

nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap({ "n", "t" }, "<M-v>")
nomap({ "n", "t" }, "<M-h>")
nomap("t", "<C-X>")
nomap("n", "<C-n>")
nomap("n", "<leader>x")
nomap("n", "<leader>b")
