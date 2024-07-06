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
			a = { vim.lsp.buf.code_action, "Code actions" },
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
			b = {"<cmd>ZkBacklinks<cr>", "backlinks"},
			l = {"<cmd>ZkLinks<cr>", "links"},
			n = {"<cmd>ZkNew<cr>", "new note"},
			o = {"<cmd>ZkNotes<cr>", "open a note"},
			t = {"<cmd>ZkTags<cr>", "open by tag"},
		},
		o = {
			name = "open",
			w = { "<cmd>edit ~/vimwiki/index.md<cr>", "wiki" },
			f = {
				name = "fuzzy-find",
				b = {
					require'telescope.builtin'.buffers,
					"buffers",
				},
				c = {
					require'telescope.builtin'.find_files,
					"in current dir",
				},
				g = {
					require'telescope.builtin'.live_grep,
					"grep",
				},
				h = {
					function()
						require('telescope.builtin').find_files{search_dirs={'~'}}
					end,
					"in home dir"
				},
				r = {
					function()
						require('fzf-lua').files{cwd = '/'}
					end,
					"root"
				},
				v = {
					function()
						require('telescope.builtin').find_files{search_dirs={'/Volumes'}}
					end,
					"in /Volumes"
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
