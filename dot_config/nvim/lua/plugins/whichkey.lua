local M = {}

function M.setup()
	local wk = require("which-key")
	wk.setup{
	}

	wk.register({
		b = {
			name = "buffer",
			['['] = { "<cmd>:bp<cr>", "Previous buffer" },
			[']'] = { "<cmd>:bn<cr>", "Next buffer" },
			d = { "<cmd>:bd<cr>", "Close buffer" },
		},
		c = {
			name = "code",
		},
		g = {
			name = "git",
			s = { "<cmd>Neogit<cr>", "status" },
		},
		i = {
			name = "insert",
		},
		n = {
			name = "notes",
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
		p = {
			name = "project",
		},
		s = {
			name = "search",
		},
		t = {
			name = "toggle",
		},
		w = {
			name = "window",
			s = { "<cmd>split %<cr>", "split" },
			v = { "<cmd>vsplit %<cr>", "vsplit" },
		}
	}, { prefix = "<leader>" })
end

return M
