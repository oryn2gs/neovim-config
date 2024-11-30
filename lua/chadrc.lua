-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

-- For more configuration check `nvui` with telescope
M.ui = {
  tabufline = {},
  statusline = {
    theme = "default",
    orders = {
      "mode",
      "file",
      "git",
      "%=",
      "lsp_msg",
      "%=",
      "diagnostics",
      "lsp",
      "cwd",
      "cursor",
      "record_status",
    },
    modules = {
      --  FIX: show the active recording status
      record_status = function()
        local rec = vim.fn.reg_recording()
        return rec ~= "" and ("Recording @" .. rec) or ""
      end,
      some = "Hello form other side",
    },
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

-- Theme resides in base46 for latest update
-- For more configuration check `nvui.base46` with telescope
M.base46 = {
  theme = "tomorrow_night",
  transparency = true,
}

return M
