return {

  {
    "nvim-lua/popup.nvim",
    lazy = true,
  },
  {
    "nvim-telescope/telescope-media-files.nvim",
    lazy = true,
  },

  -- Formatters
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
        "eslint-lsp",
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
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
      require "configs.nvim-lint"
    end,
  },

  -- NvChad/nvim-colorizer
  {
    "NvChad/nvim-colorizer.lua",
    -- opts = {
    --   user_default_options = {
    --     tailwind = true,
    --   },
    -- },
    config = function()
      local colorizer = require "colorizer"
      colorizer.setup {
        user_default_options = {
          tailwind = true,
        },
      }
    end,
  },
  -- Update the options of nvim cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    opts = function(_, opts)
      -- original NvChad kind icon formatter
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "nvchad.configs.telescope"
      table.insert(conf.extensions_list, "media_files") -- extending the default list

      -- Append the media files settings to the list of exiting extension table
      table.insert(conf.extensions, "media_files") -- extending the default list
      conf.extensions.media_files = {
        filetypes = { "png", "webp", "jpg", "jpeg", "webm, pdf" },
        find_cmd = "rg",
      }

      return conf
    end,
  },
}
-- NvChad/,
