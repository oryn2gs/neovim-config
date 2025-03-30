-- setting custom hightlight group
vim.api.nvim_set_hl(0, "Recording", { fg = "#f0c674", bg = "none" }) -- for Recording text in statusline

-- disable the bg hightlights in tabufline
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = "none" }) -- Active tab highlight
