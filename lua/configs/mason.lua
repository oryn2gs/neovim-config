local options = require "nvchad.configs.mason"

opts = {
  ensure_installed = {
    -- python
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
}

options.ensure_installed = vim.list_extend(options.ensure_installed or {}, opts.ensure_installed)

return options
