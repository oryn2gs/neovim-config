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
  ts_ls = {},
  -- cva configuration -- https://cva.style/docs/getting-started/installation#tailwind-css
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
  -- for information on cofiguring rust lsp check: (https://rust-analyzer.github.io/book/other_editors.html#nvim-lsp)
  rust_analyzer = {},
}

-- extending default lsp on attach
local function on_attach(client, bufnr)
  -- Call the default on_attach function
  nvlsp.on_attach(client, bufnr)

  -- Enable inlay hints if the LSP supports it
  if client.name == "rust_analyzer" then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

for lsp, opts in pairs(servers) do
  -- opts.on_attach = nvlsp.on_attach
  opts.on_attach = on_attach
  opts.on_init = nvlsp.on_init
  opts.capabilities = nvlsp.capabilities
  lspconfig[lsp].setup(opts)
end
