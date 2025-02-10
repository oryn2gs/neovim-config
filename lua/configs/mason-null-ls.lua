-- mason null ls configuration

local mason_null_ls = require "mason-null-ls"
mason_null_ls.setup {
  ensure_installed = {
    "stylua", -- lua formatter

    "black", -- python formatter
    "pylint", -- python linter
    "ruff", -- python linter

    "prettier",
    "prettierd", -- prettier formatter
    "eslint",
    "eslint_d", -- js linter
  },
  -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
  automatic_installation = true,
}

return mason_null_ls
