return {
  {
    "nvim-lua/popup.nvim",
    lazy = true,
  },

  {
    "nvim-telescope/telescope-media-files.nvim",
    lazy = true,
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
    event = { "bufwritepre", "bufnewfile" }, -- uncomment for format on save
    config = function()
      require "configs.conform"
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

  -- tailwindcss highlighter
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

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
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

  -- nvim-dap configuration
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    event = { "BufReadPre *.py" },
    dependencies = {
      "rcarriga/nvim-dap-ui", -- DAP UI
      "theHamsta/nvim-dap-virtual-text", -- DAP Virtual Text
      -- "mfussenegger/nvim-dap-python", -- Python DAP support
    },
    config = function()
      require "configs.nvim-dap"
    end,
  },

  -- nvim-dap-ui configuration
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require "configs.dapui"
    end,
  },

  -- nvim dap virtual text
  {
    "nvim-dap-virtual-text",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap", -- Ensure dap is loaded before virtual text
    },
    opts = {}, -- if you want custom configuration
  },

  -- dap-python configuration
  -- INFO: using default configuration and adapters
  -- {
  --   "mfussenegger/nvim-dap-python",
  --   lazy = true,
  --   config = function()
  --     require "configs.dap-python"
  --   end,
  -- },
}
