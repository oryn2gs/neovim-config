local lint = require "lint"

lint.linters_by_ft = {
  python = { "ruff" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  rust = { "clippy" },
}

require("lint").linters.pylint.cmd = "python"
require("lint").linters.pylint.args = { "-m", "pylint", "-f", "json" }

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

-- Automatically run linters after saving.  Use "InsertLeave" for more aggressive linting.
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

vim.keymap.set("n", "<leader>ll", function()
  lint.try_lint()
end, { desc = "Trigger linting for current file" })
