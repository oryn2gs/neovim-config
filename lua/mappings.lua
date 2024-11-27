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
--TODO: add am keymap to open file as folder to system app

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
map({ "n", "t" }, "<leader>tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.3 }
end, { desc = "Terminal Toggleable vertical term" })

map("n", "<leader>tt", function()
  require("nvchad.term").new { pos = "sp", size = 0.3 }
end, { desc = "Terminal New horizontal term" })

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

-- INFO: Comments
local function set_comment_keymap()
  local comment_map = {
    python = "#",
    lua = "--",
    javascript = "//",
    typescript = "//",
    yml = "#",
    yaml = "#",
  }

  -- Fetch the current filetype
  local filetype = vim.bo.filetype
  local comment_string = comment_map[filetype]

  -- Return if the filetype has no comment string defined
  if not comment_string then
    return
  end

  -- Create the key mapping for the current buffer
  vim.api.nvim_buf_set_keymap(
    0,
    "n",
    "gcA",
    "$a " .. comment_string .. " <Esc>i",
    { noremap = true, silent = true, desc = "Comment add at end of the line." }
  )
end

-- Set up an autocommand to trigger the function when a file is loaded
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = set_comment_keymap,
})

-- INFO: disable defaults NvChad mappings
local nomap = vim.api.nvim_del_keymap
-- vim.api.nvim_del_keymap("n", "<leader>gt")
nomap("n", "<leader>/")
nomap("n", "<leader>b")
