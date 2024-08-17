require "nvchad.mappings"

local map = vim.keymap.set

-- INFO: Basic mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "i", "n", "v" }, "<C-q>", "<cmd>:wa | qall<CR>", { desc = "Save all and exit" })
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all in the buffer" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode" })

-- INFO: LSP mappings
map("n", "<leader>pd", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true, desc = "LSP peek definition" })

-- INFO: Nvim tree mappings
map("n", "<leader>ub", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })
map("n", "<leader>f", "<cmd>NvimTreeFindFile<CR>", { desc = "Nvimtree find files and folder" })

-- INFO: Telecope mappings
map("n", "<leader>fm", "<cmd>Telescope media_files<CR>", { desc = "Telescope find media files" })
vim.api.nvim_set_keymap("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "Telescope find todos" })

-- INFO: conform mapping
map("n", "<leader>fp", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format Files" })

-- INFO: Windo mappings
-- PERF: disabled because we're using wrap window settings
-- map("n", "<leader>ws", ":split<Return>", { desc = "Window split horizontally" })
-- map("n", "<leader>wv", ":vsplit<Return>", { desc = "Window split vertically" })
-- map("n", "<leader>wh", "<C-w>h", { desc = "Window move left" })
-- map("n", "<leader>wk", "<C-w>k", { desc = "Window move up" })
-- map("n", "<leader>wj", "<C-w>j", { desc = "Window move down" })
-- map("n", "<leader>wl", "<C-w>l", { desc = "Window move right", noremap = true, silent = true }) -- clashes with the lsp mappings
-- map("n", "<leader>wp", "<C-w>l", { desc = "Window move right", noremap = true, silent = true }) -- Quick fixes chang later
-- map("n", "<leader>w=", "<C-w>=", { desc = "Window resize equal" })
-- map("n", "<leader>w|", "<C-w>|", { desc = "Window rezize max width" })
-- map("n", "<leader>w_", "<C-w>_", { desc = "Window resize max height" })
-- map("n", "<leader>wo", "<C-w>o", { desc = "Window close all other" })
-- map("n", "<leader>wx", "<C-w>x", { desc = "Window swap current with next" })

-- INFO: Buffer mappings
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Buffer New" })
map("n", "<leader>bd", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer close current" })

-- INFO: function to delete buffers except the active one
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

-- INFO: Terminal mappings
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

--  INFO: Toggle between 'manual' and 'indent' foldmethod
vim.api.nvim_set_keymap(
  "n",
  "<leader>tf",
  ":lua ToggleFoldMethod()<CR>",
  { noremap = true, silent = true, desc = "Toggle foldmethod between indent and manual" }
)

function ToggleFoldMethod()
  if vim.wo.foldmethod == "manual" then
    vim.wo.foldmethod = "indent"
    print "Foldmethod set to indent"
  else
    vim.wo.foldmethod = "manual"
    print "Foldmethod set to manual"
  end
end

-- INFO: disable defaults NvChad mappings
local nomap = vim.api.nvim_del_keymap
-- vim.api.nvim_del_keymap("n", "<leader>gt")
nomap("n", "<leader>/")
