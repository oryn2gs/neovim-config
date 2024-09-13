local configs = require "nvchad.configs.lspconfig"

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local servers = {
  html = {},
  cssls = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT", -- Neovim uses LuaJIT
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          globals = { "vim" }, -- Define globals
          disable = { "lowercase-global" }, -- You can add more to ignore other warnings
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true), -- Neovim runtime files
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  tsserver = {},
  tailwindcss = {},
  eslint = {},
  emmet_language_server = {},
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "strict", -- enabled to global type checking ("off", "basic", "standard", "strict")
        },
        disableOrganizeImports = true,
        autoImportCompletions = true, -- Enable auto imports
        inlayHints = { -- Enable inlay hints
          enabled = true,
          parameterHints = true,
          typeHints = true,
          chainingHints = true,
          otherHints = true,
        },
      },
    },
  },
}

for name, opts in pairs(servers) do
  opts.on_init = on_init
  opts.on_attach = on_attach
  opts.capabilities = capabilities

  require("lspconfig")[name].setup(opts)
end
