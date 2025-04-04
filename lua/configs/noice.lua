-- noice configuration https://github.com/folke/noice.nvim
return {
  background_color = "#000000",
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },

    -- lsp signature help
    signature = {
      enabled = true,
      auto_open = {
        enabled = false,
        trigger = false, -- Automatically show signature help when typing a trigger character from the LSP
        luasnip = false, -- Will open signature help when jumping to Luasnip insert nodes
        throttle = 50, -- Debounce lsp signature help request by 50ms
      },
      view = nil, -- when nil, use defaults from documentation
      opts = {}, -- merged with defaults from documentation
    },
    -- documentation
    documentation = {
      view = "hover",
      ---@type NoiceViewOptions
      opts = {
        lang = "markdown",
        replace = true,
        render = "plain",
        format = { "{message}" },
        win_options = { concealcursor = "n", conceallevel = 3 },
      },
    },
  },

  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },

  --show recording with noice
  -- INFO: uncomment to show recording with noice
  -- using statusline to show recording
  --
  -- routes = {
  --   {
  --     view = "notify",
  --     filter = { event = "msg_showmode" },
  --   },
  -- },
}
