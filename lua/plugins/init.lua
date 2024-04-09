return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufNewFile" }, -- uncomment for format on save
    config = function()
      return require "configs.conform"
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

        -- web-dev
        "typescript-language-server",
        "tailwindcss-language-server",
        "emmet-language-server",
        -- "eslint-lsp",
        "html-lsp",
        "css-lsp",

        "lua-language-server",
      },
    },
  },

  -- TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- add this to it's own file
    opts = {
      ensure_installed = {
        "lua",

        "vim",
        "vimdoc",

        "gitcommit",
        "dockerfile",
        "yaml",

        "html",
        "css",

        "python",
        "scss",
        "htmldjango",

        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "tsx",

        "prisma",
      },
    },
  },

  {
    "jay-babu/mason-null-ls.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require "configs.null-ls" -- require your null-ls config here (example below)
      local mason_null_ls = require "mason-null-ls"
      mason_null_ls.setup {
        ensure_installed = {
          "stylua", -- lua formatter

          "black", -- python formatter
          "pylint", -- python linter

          "prettier",
          "prettierd", -- prettier formatter
          "eslint",
          "eslint_d", -- js linter
        },
      }
    end,
  },

  -- Linters
}
