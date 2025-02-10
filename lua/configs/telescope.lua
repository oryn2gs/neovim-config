-- This file contains telescope configuration, for more information https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#default-mappings
-- Which extends deaults telescope configuration
dofile(vim.g.base46_cache .. "telescope")

return {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },

  -- customize defaults pickers
  pickers = {
    find_files = {
      hidden = false, -- show hidden files
      no_ignore = false, -- show file ignore by gitignore
    },
  },

  extensions_list = { "themes", "terms", "media_files" },
  extensions = {
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg", "webm, pdf" },
      find_cmd = "rg",
    },
  },
}
