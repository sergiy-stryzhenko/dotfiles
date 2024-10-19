local M = {}

function M.setup()
	local wk = require("which-key")
	wk.setup {
	}

	wk.add({
		{"<leader>b", group = "buffer"},
		{"<leader>b[", "<cmd>bp<cr>", desc = "Previous buffer"},
		{"<leader>b]", "<cmd>:bn<cr>", desc = "Next buffer" },
		{"<leader>bd", "<cmd>:bd<cr>", desc = "Close buffer"},

		{"<leader>c", group = "code"},
		{"<leader>ca", vim.lsp.buf.code_action, desc = "Code actions"},

		{"<leader>g", group = "git"},
		{"<leader>gs", "<cmd>Neogit<cr>", desc = "git status"},

		{"<leader>i", group = "insert"},

		{"<leader>n", group = "notes"},
		{"<leader>nb", "<cmd>ZkBacklinks<cr>", desc = "backlinks"},
		{"<leader>nl", "<cmd>ZkLinks<cr>", desc = "links"},
		{"<leader>nn", "<cmd>ZkNew<cr>", desc = "new note"},
		{"<leader>no", "<cmd>ZkNotes<cr>", desc = "open a note"},
		{"<leader>nt", "<cmd>ZkTags<cr>", desc = "open by tag"},

		{"<leader>o", group = "open"},
		{"<leader>ow", "<cmd>edit ~/vimwiki/index.md<cr>", desc = "Vimwiki" },
		{"<leader>of", group = "fuzzy-find"},
		{"<leader>ofb", require'telescope.builtin'.buffers, desc = "buffers"},
		{"<leader>ofc", require'telescope.builtin'.find_files, desc = "in working dir"},
		{"<leader>ofg", require'telescope.builtin'.live_grep, desc = "grep"},
		{"<leader>ofh", function ()
			require'telescope.builtin'.find_files{search_dirs={'~'}}
		end, desc = "in `~`"},
		{"<leader>ofr", function ()
			require'fzf-lua'.files{cwd = '/'}
		end, desc = "in `/`"},
		{"<leader>ofv", function ()
			require'telescope.builtin'.find_files{search_dirs={'/Volumes'}}
		end, desc = "in `/Volumes`"},

		{"<leader>p", name="project"},

		{"<leader>t", group = "toggle"},

		{"<leader>w", group = "window"},
		{"<leader>ws", "<cmd>split %<cr>", desc = "split"},
		{"<leader>wv", "<cmd>vsplit %<cr>", desc = "vsplit"},
	})
end

return M
