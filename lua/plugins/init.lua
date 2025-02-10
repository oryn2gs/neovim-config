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
    opts = {
      sort = {}, -- override defaults sorting methods
      git = {
        enable = true,
        ignore = false,
      },
      filters = {
        dotfiles = false, --info: set this to false to show dotfiles
      },
      view = {
        width = 35,
      },

      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        local map = vim.keymap.set
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        -- toggle is configured in global mappings "mappings.lua"
        -- map("n", "<leader>ub", "<cmd>NvimTreeToggle<CR>", opts "Nvimtree Toggle window") --
        map("n", "D", api.fs.remove, opts "Delete")
        map("n", "d", api.fs.trash, opts "Trash")
        map("n", "<C-s>", function()
          local node = api.tree.get_node_under_cursor()
          if node then
            vim.ui.open(node.absolute_path)
          end
        end, opts "Open in system application")
      end,
    },
  },

  -- lsp configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate", "MasonUninstallAll", "MasonLog" },
    opts = function()
      return require "configs.mason"
    end,
  },

  -- treesitter
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
    opts = {
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
            enabled = false, -- enable auto open
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            luasnip = false, -- Will open signature help when jumping to Luasnip insert nodes
            throttle = 50, -- Debounce lsp signature help request by 50ms
          },
          view = nil, -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {
            border = "none",
            focus = false,
          }, -- merged with defaults from documentation
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
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "muniftanjim/nui.nvim",
      -- optional:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   if not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
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
