local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    -- python = { "isort", "black" },

    -- You can use a function here to determine the formatters dynamically
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
    rust = { "rustfmt", lsp_format = "fallback" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    lsp_fallback = true, -- fallback to lsp formatter
    async = false,
    timeout_ms = 2000,
  },
  stop_after_first = true,
}

require("conform").setup(options)
