-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

-- For more configuration check `:h nvui`
M.ui = {
  tabufline = {
    -- enabled = false,
    order = { "treeOffset", "buffers", "btns" },
  },

  statusline = {
    theme = "default",
    separator_style = "default",
    -- overriding 'default order' -> https://github.com/NvChad/ui/blob/v3.0/lua/nvchad/stl/utils.lua
    order = { "mode", "file", "git", "%=", "recording", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    modules = {
      recording = function()
        if vim.fn.reg_recording() ~= "" then
          -- If recording, return the register name
          -- return string.format(" Recording @%s ", vim.fn.reg_recording())
          return string.format("%%#Recording# Recording @%s %%#Normal#", vim.fn.reg_recording())
        else
          return ""
        end
      end,
    },
  },
}

-- Theme resides in base46 for latest update
-- For more configuration check `nvui.base46` with telescope
M.base46 = {
  theme = "tomorrow_night",
  transparency = true,
  theme_toggle = { "tomorrow_night", "aquarium" },

  -- To edit already existing theme
  -- changed_themes = {
  --   tomorrow_night = {},
  --   aquarium = {}
  -- },
  --

  -- FIX: italic is not working for comment
  --
  -- check ":h treesitter-highlights" for more informaion and options
  -- hl_override = {
  --   Comment = { italic = true },
  -- ["@comment"] = { bg = "base00", fg = "NONE", italic = true },
  -- },
}

-- load nvChad dashboard on startup
M.nvdash = {
  load_on_startup = true,
  -- header = {}, -- change intro header
}

--
M.cheatsheet = {
  theme = "grid", -- simple/grid
  -- to exclude the groups from cheat sheet -- add a group name in exluded groups
  excluded_groups = {},
}

return M
