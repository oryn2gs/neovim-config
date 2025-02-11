local dap = require "dap"
local map = vim.keymap.set

-- Define DAP breakpoint signs
vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})
vim.fn.sign_define("DapBreakpointRejected", {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})
vim.fn.sign_define("DapStopped", {
  text = "",
  texthl = "DiagnosticSignWarn",
  linehl = "Visual",
  numhl = "DiagnosticSignWarn",
})

-- Mappings
map("n", "<leader>db", function()
  dap.continue()
end, { desc = "Dap run debug." })
map("n", "<leader>sn", function()
  dap.step_over()
end, { desc = "Dap step over" })
map("n", "<leader>si", function()
  dap.step_into()
end, { desc = "Dap step_into" })
map("n", "<leader>so", function()
  dap.step_out()
end, { desc = "Dap step out." })
map("n", "<Leader>tb", function()
  dap.toggle_breakpoint()
end, { desc = "Dap toggle breakpoint" })
map("n", "<Leader>rl", function()
  dap.run_last()
end, { desc = "Dap run last." })
map("n", "<leader>cb", function()
  dap.clear_breakpoints()
end, { desc = "Dap Clear Breakpoints" })

-- Ensure nvim-dap loads when opening Python or Lua files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "lua" },
  callback = function()
    require "dap" -- Load DAP
  end,
})

-- Python debug adapters and configurations
local function get_python_path()
  -- Check if the current project has a virtualenv (VIRTUAL_ENV variable exists)
  local venv = os.getenv "VIRTUAL_ENV"
  if venv then
    -- If inside a virtual environment, use the Python interpreter from the venv
    return vim.fn.expand(venv .. "/bin/python")
  else
    -- If not inside a venv, fallback to the debugpy provided by mason
    -- return vim.fn.expand "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    return vim.fn.expand "/opt/anaconda3/bin/python"
  end
end

dap.adapters.python = function(cb, config)
  if config.request == "attach" then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or "127.0.0.1"
    cb {
      type = "server",
      port = assert(port, "`connect.port` is required for a python `attach` configuration"),
      host = host,
      options = {
        source_filetype = "python",
      },
    }
  else
    cb {
      type = "executable",
      -- command = "path/to/virtualenvs/debugpy/bin/python",
      command = get_python_path(),
      args = { "-m", "debugpy.adapter" },
      options = {
        source_filetype = "python",
      },
    }
  end
end

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch",
    name = "Launch file",
    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = get_python_path(),
  },
}
