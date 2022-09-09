local M = {}

function source_config()
	vim.notify("Updating config...")
	vim.cmd[[luafile ~/.config/nvim/init.lua]]
	vim.notify("Config updated, compiling Packer")
	vim.cmd[[PackerCompile]]
	vim.notify("Compiled Packer")
end

function M.setup()
	local wk = require("which-key")
	wk.setup{
	}

	wk.register({
		c = {
			source_config,
			"source-config"
		},
		o = {
			name = "open",
			w = { "<cmd>edit ~/vimwiki/index.md<cr>", "wiki" },
			f = {
				name = "fzf",
				b = { require('fzf-lua').buffers, "buffers" },
				c = { require('fzf-lua').files, "current" },
				h = {
					function()
						require('fzf-lua').files{cwd='~'}
					end,
					"home"
				},
				r = {
					function()
						require('fzf-lua').files{cwd = '/'}
					end,
					"root"
				},
				v = {
					function()
						require('fzf-lua').files{cwd='/Volumes'}
					end,
					"volumes"
				},
			},
		},
		s = { "<cmd>split %<cr>", "split" },
		v = { "<cmd>vsplit %<cr>", "vsplit" },
		g = {
			name = "git",
			s = { "<cmd>Neogit<cr>", "status" },
		}
	}, { prefix = "<leader>" })
end

return M
