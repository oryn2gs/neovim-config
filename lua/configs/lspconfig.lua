local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

-- load defaults Nvchad lspconfig
nvlsp.defaults()

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
  -- tsserver = {},
  ts_ls = {},
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

for lsp, opts in pairs(servers) do
  opts.on_attach = nvlsp.on_attach
  opts.on_init = nvlsp.on_init
  opts.capabilities = nvlsp.capabilities
  lspconfig[lsp].setup(opts)
end
