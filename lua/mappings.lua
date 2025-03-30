require "nvchad.mappings"

local map = vim.keymap.set

-- map("n", "<Leader>bb", function()
--   require("dap").toggle_breakpoint()
-- end)
--
--

-- Themes
map("n", "<leader>ta", function()
  require("base46").toggle_transparency()
end, { desc = "Theme toggle transparency." })

-- Basic mappings
map({ "i", "n", "v" }, "<C-q>", "<cmd>:wa | qall<CR>", { desc = "Save all and exit" })
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all in the buffer" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode" })

-- LSP mappings
map("n", "<leader>pd", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true, desc = "LSP peek definition" })

-- Nvim tree mappings
map("n", "<leader>ub", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })

-- Telecope mappings
map("n", "<leader>fm", "<cmd>Telescope media_files<CR>", { desc = "Telescope find media files" })
map("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "Telescope find todos" })

-- conform mapping
map("n", "<leader>fp", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format Files" })

-- Noice Mappings
map("n", "<leader>nm", "<cmd>Noice telescope<CR>", { desc = "Noice messages in telescope." })
map("n", "<leader>ne", "<cmd>Noice errors<CR>", { desc = "Noice errors message." })

-- NVIM window management
map("n", "<leader>ws", ":split<Return>", { desc = "Window split horizontally" })
map("n", "<leader>wv", ":vsplit<Return>", { desc = "Window split vertically" })
map("n", "<leader>we", "<C-w>=", { desc = "Window resize equally" })
map("n", "<leader>wm", "<C-w>|", { desc = "Window resize active window to max-width" })
map("n", "<leader>wo", "<C-w>o", { desc = "Window quit all other windows" })
map("n", "<leader>wq", "<C-w>q", { desc = "Window quit active window" })
map("n", "<leader>ww", "<C-w>w", { desc = "Window switch" })
map("n", "<leader>w>", "<C-w>>", { desc = "Window width increase" })
map("n", "<leader>w<", "<C-w><", { desc = "Window width decrease" })
map("n", "<leader>w+", "<C-w>+", { desc = "Window height increase" })
map("n", "<leader>w-", "<C-w>-", { desc = "Window height decrease" })

-- Buffer mappings
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Buffer New" })
map("n", "<leader>bd", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer close current" })
map("n", "<leader>bh", function()
  require("nvchad.tabufline").move_buf(-1)
end, { desc = "Buffer move current to left." })
map("n", "<leader>bl", function()
  require("nvchad.tabufline").move_buf(1)
end, { desc = "Buffer move current to right." })
map("n", "<leader>bf", function()
  require("nvchad.tabufline").closeBufs_at_direction "right"
end, { desc = "Buffer close at direction right." })
map("n", "<leader>bb", function()
  require("nvchad.tabufline").closeBufs_at_direction "left"
end, { desc = "Buffer move current to right." })
-- for i = 1, 9, 1 do -- change the buffer number
--   vim.keymap.set("n", string.format("<A-%s>", i), function()
--     vim.api.nvim_set_current_buf(vim.t.bufs[i])
--   end)
-- end

-- function to delete buffers except the active one
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

-- Terminal mappings
map({ "n", "t" }, "<leader>tt", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.5 }
end, { desc = "Terminal Toggleable vertical term" })

map("n", "<leader>tb", function()
  require("nvchad.term").new { pos = "sp", size = 0.5 }
end, { desc = "Terminal New horizontal term" })

map("t", "<ESC>", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_close(win, true)
end, { desc = "Terminal Close term in terminal mode" })

--  Toggle between 'manual' and 'indent' foldmethod
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

-- Comments
local function set_comment_keymap()
  local comment_map = {
    python = "#",
    lua = "--",
    javascript = "//",
    typescript = "//",
    yml = "#",
    yaml = "#",
    json = "#",
    toml = "#",
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

-- disable defaults NvChad mappings
local nomap = vim.api.nvim_del_keymap
-- vim.api.nvim_del_keymap("n", "<leader>gt")
nomap("n", "<leader>/")
nomap("n", "<leader>b")
