local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		'git', 'clone', '--depth', '1',
		'https://github.com/wbthomason/packer.nvim', install_path
	})
end

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	-- Switch keyboard layout back to Latin in normal mode
	-- This allows typing e.g. in Chinese and editing with usual Vim commands
	use {
		'rlue/vim-barbaric',
		config = function()
			vim.g.XkbSwitchEnabled = 0
		end,
	}

	-- Colorscheme
	use {
		'folke/tokyonight.nvim',
		branch = 'main',
		config = function()
			vim.g.tokyonight_transparent = true
			vim.cmd[[colorscheme tokyonight]]
		end
	}

	-- Status bar
	use {
		'nvim-lualine/lualine.nvim',
		config = function()
			require'lualine'.setup{
				options = {
					theme = 'tokyonight',
				}
			}
			vim.o.showmode = false
		end
	}

	-- Fancy notifications
	use {
		'rcarriga/nvim-notify',
		config = function ()
			vim.notify = require('notify')
		end,
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			require('nvim-treesitter.install').upadte({ with_sync = true })
		end,
		config = function()
			require'nvim-treesitter.configs'.setup{
				ensure_installed = {
					'lua',
					'python',
				},
				highlight = {
					enable = true,
				}
			}
		end
	}

	use 'ibhagwan/fzf-lua'

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_browser = 'Brave Browser'
			vim.g.mkdp_refresh_slow = 1
		end,
	})

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}


	use {
		'jakewvincent/mkdnflow.nvim',
		config = function()
			require('mkdnflow').setup({
				modules = {
					folds = false,
				},
				perspective = {
					priority = 'current',
				},
				mappings = {
					MkdnFoldSection = false,
					MkdnUnfoldSection = false,
				},
			})
		end
	}

	use {
		"folke/which-key.nvim",
		config = require'plugins/whichkey'.setup
	}

	use {
		'TimUntersberger/neogit',
		requires = 'nvim-lua/plenary.nvim'
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		},
		config = function()
			local lsp = require('lsp-zero')
			lsp.preset('recommended')
			lsp.nvim_workspace()
			lsp.setup()
		end,
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end)
