return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufNewFile" }, -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- Lsp configuration
  {
    "neovim/nvim-lspconfig",

    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    -- need to add mason tool _ installer insted on mason_null/ (forr installing formattters and linter,)--> check the none-ls.lua file
    opts = {
      ensure_installed = {
        "pyright",

        "lua-language-server",

        "html-lsp",
        "css-lsp",
      },
    },
  },

  -- TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
        "scss",
        "javascript",
        "htmldjango",
        "gitcommit",
        "dockerfile",
        "prisma",
        "typescript",
        "yaml",
      },
    },
  },

  ---add nvim lint for linters

  -- Linters
}
