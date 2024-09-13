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
      require "configs.conform"
    end,
  },

  -- Nvim tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      git = {
        enable = true,
        ignore = false,
      },
      filters = {
        dotfiles = false, --INFO: Set this to false to show dotfiles
      },
    },
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
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "configs.mason"
    end,
  },

  -- TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",

        "vim",
        "vimdoc",
        "regex",
        "bash",
        "markdown",
        "markdown_inline",

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
        -- "javascriptreact",
        -- "typescriptreact",
        "tsx",

        "prisma",
      },
    },
  },

  {
    "jay-babu/mason-null-ls.nvim",
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

  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

  -- todo-comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      require("todo-comments").setup() -- Load the todo-comments plugin with the above configuration
    end,
  },
}
