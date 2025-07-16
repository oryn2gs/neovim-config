return {
  {
    "nvim-lua/popup.nvim",
  },

  {
    "nvim-telescope/telescope-media-files.nvim",
  },

  -- nvim surround
  {
    "kylechui/nvim-surround",
    version = "*", -- use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- configuration here, or leave empty to use defaults
      }
    end,
  },

  -- formatters
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>fp",
        function()
          require("conform").format { async = true }
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          css = { "prettier" },
          html = { "prettier" },
          javascript = {
            "prettierd",
            "prettier",
          },
          javascriptreact = {
            "prettierd",
            "prettier",
          },
          typescript = {
            "prettierd",
            "prettier",
          },
          typescriptreact = {
            "prettierd",
            "prettier",
            stop_after_first = true,
          },

          python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
              return { "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          -- Use the "*" filetype to run formatters on all filetypes.
          ["*"] = { "codespell" },
          -- Use the "_" filetype to run formatters on filetypes that don't
          -- have other formatters configured.
          ["_"] = { "trim_whitespace" },
          rust = {
            "rustfmt",
          },
        },
        format_on_save = {
          -- I recommend these options. See :help conform.format for details.
          lsp_format = "fallback",
          -- timeout_ms = 500,
          timeout_ms = 2000, -- changing default timeout of 1000, because of black fmt timeout issue
        },
        stop_after_first = true,
        log_level = vim.log.levels.DEBUG, -- increase the verbosity of log level
        notify_on_error = true,
        notify_no_formatters = true,
      }
    end,
  },

  -- nvim tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = require "configs.nvimtree",
  },

  -- lsp configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate", "MasonUninstallAll", "MasonLog" },
    opts = function()
      return require "configs.mason"
    end,
  },

  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require "configs.null-ls" -- require your null-ls config here (example below)
      require "configs.mason-null-ls"
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.nvim-treesitter",
  },

  -- linters
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "bufreadpre", "bufnewfile" }, -- to disable, comment this out
    config = function()
      require "configs.nvim-lint"
    end,
  },

  -- nvchad/nvim-colorizer -- color highlighter
  {
    "nvchad/nvim-colorizer.lua",
    config = function()
      local colorizer = require "colorizer"
      colorizer.setup {
        user_default_options = {
          tailwind = true,
        },
      }
    end,
  },

  -- nvim-cmp auto completion plugins for neovim --
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    opts = function(_, opts)
      -- original nvchad kind icon formatter
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },

  -- tailwindcss autocompletion plugins
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup {
        color_square_width = 2,
      }
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    cmd = "Telescope",
    opts = function()
      return require "configs.telescope"
    end,
  },

  -- nvim noice for notification
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "munifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = require "configs.noice",
    -- FIX: need to fix the auto entering lsp "hover" view -
    -- link -> https://github.com/folke/noice.nvim/blob/0427460c2d7f673ad60eb02b35f5e9926cf67c59/lua/noice/config/views.lua
  },

  -- todo-comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      require("todo-comments").setup() -- load the todo-comments plugin with the above configuration
    end,
  },
}
