local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup{
	-- Switch keyboard layout back to Latin in normal mode
	-- This allows typing e.g. in Chinese and editing with usual Vim commands
	{
		'rlue/vim-barbaric',
		config = function()
			vim.g.XkbSwitchEnabled = 0
		end,
	},

	-- Colorscheme
	{
		'folke/tokyonight.nvim',
		branch = 'main',
		config = function()
			require('tokyonight').setup({
				transparent = true,
				on_colors = function (colors)
					colors.comment = "#9aa5ce"
				end
			})
			vim.cmd[[colorscheme tokyonight]]
		end
	},

	-- Status bar
	{
		'nvim-lualine/lualine.nvim',
		config = function()
			require'lualine'.setup{
				options = {
					theme = 'tokyonight',
				}
			}
			vim.o.showmode = false
		end
	},

	-- Fancy notifications
	{
		'rcarriga/nvim-notify',
		config = function ()
			vim.notify = require('notify')
			require('notify').setup{
				background_colour = '#000000'
			}
		end,
	},

	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		config = function()
			require'nvim-treesitter.configs'.setup{
				ensure_installed = {
					'lua',
					'python',
					'markdown',
				},
				highlight = {
					enable = true,
				}
			}
		end
	},

	'ibhagwan/fzf-lua',

	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install && git reset --hard",
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_browser = 'Brave Browser'
			vim.g.mkdp_refresh_slow = 1

			vim.keymap.set(
				'n', '<leader>tp', '<plug>MarkdownPreviewToggle',
				{desc = 'Toggle Markdown preview'}
			)
		end,
	},

	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	},


	{
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
					MkdnTableNextCell = false,
				},
			})
		end
	},

	{
		"folke/which-key.nvim",
		config = require'plugins/whichkey'.setup
	},

	{
		'TimUntersberger/neogit',
		dependencies = 'nvim-lua/plenary.nvim'
	},

	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',
			{ 'j-hui/fidget.nvim', opts = {} },

			-- For working with Neovim configs in Lua
			'folke/neodev.nvim',
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'L3MON4D3/LuaSnip', build = 'make install_jsregexp'},
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/nvim-cmp',
		},
		config = require'plugins/lsp'.setup,
	},
}
