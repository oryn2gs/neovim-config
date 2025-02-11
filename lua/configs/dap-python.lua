-- INFO: using default configuration and adapters
local dap = require "dap"
local dap_python = require "dap-python"

-- Function to automatically select the Python interpreter (venv or system Python)
local function get_python_path()
  -- Check if the current project has a virtualenv (VIRTUAL_ENV variable exists)
  local venv = os.getenv "VIRTUAL_ENV"
  if venv then
    -- If inside a virtual environment, use the Python interpreter from the venv
    return vim.fn.expand(venv .. "/bin/python")
  else
    -- If not inside a venv, fallback to the debugpy provided by mason
    return vim.fn.expand "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
  end
end

dap_python.setup(get_python_path())

table.insert(dap.configurations.python, {
  {
    type = "python",
    request = "launch",
    name = "Launch Test",
    module = "unittest",
    args = { "discover", "-s", ".", "-p", "test_*.py" },
    pythonPath = get_python_path(),
  },
})

local map = vim.keymap.set
map("n", "<leader>dc", function()
  dap_python.test_class()
end, { noremap = true, silent = true, desc = "Dap python test class" })
map("n", "<leader>dm", function()
  dap_python.test_method()
end, { noremap = true, silent = true, desc = "Dap python test method" })
map("n", "<leader>ds", function()
  dap_python.debug_selection()
end, { noremap = true, silent = true, desc = "Dap python test selection" })

-- load dap-python when python file is loaded
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    require "dap-python"
  end,
})
