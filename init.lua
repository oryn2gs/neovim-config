
if vim.g.vscode then
	-- VSCode extension
	print("VS Code IDE... Starting....")
	-- require("vscode.settings")
	vim.cmd([[source $HOME/.config/nvim/vscode/settings.vim]])
  -- easy motion  install
  else
    -- nvim editor
    
    --NvChad default config
    vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
  vim.g.mapleader = " "

  -- bootstrap lazy and all plugins
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
  end

  vim.opt.rtp:prepend(lazypath)

  local lazy_config = require "configs.lazy"

  -- load plugins
  require("lazy").setup({
    {
      "NvChad/NvChad",
      lazy = false,
      branch = "v2.5",
      import = "nvchad.plugins",
      config = function()
        require "options"
      end,
    },

    { import = "plugins" },
  }, lazy_config)

  -- load theme
  dofile(vim.g.base46_cache .. "defaults")
  dofile(vim.g.base46_cache .. "statusline")

  require "nvchad.autocmds"

  vim.schedule(function()
    require "mappings"
  end)

  -- Configuring python in the workspace
	local function get_python_interpreter()
		-- Determine the Python interpreter path dynamically, defaults to conda python.
		local default_python = "/Users/alchee/opt/anaconda3/bin/python"

		if os.getenv("VIRTUAL_ENV") then
			print("env activate")
			return os.getenv("VIRTUAL_ENV") .. "/bin/python"
		else
			return default_python
		end
	end

	vim.g.python3_host_prog = get_python_interpreter()
end
