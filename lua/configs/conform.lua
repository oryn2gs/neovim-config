local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "isort", "black" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  },
}

require("conform").setup(options)
