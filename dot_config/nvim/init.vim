set runtimepath^=~/.config/nvim runtimepath+=~/.config/nvim/after
let &packpath=&runtimepath

set exrc " use external .vimrcs
if has('termguicolors')
	set termguicolors
endif

lang en_US.UTF-8

" enable syntax and plugins (for netrw)
syntax enable
filetype plugin on
" set spell
set spelllang=en_us,ru

set splitbelow
set splitright

" Display all matching files when we tab-complete
set wildmenu

" Yank to the system clipboard
set clipboard=unnamed

" indent with tabs, align with spaces
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4
set scrolloff=8

set autoread " Reload the file content every time it changes
set nobackup
set nowritebackup
set noswapfile
set nohidden " do not keep buffers in background

set wrap " Word wrap long lines

set autoindent

set showmatch
set hlsearch " Search the word under cursor on *
set incsearch
set ignorecase
set number
set relativenumber

set list
set showbreak=↪\ 
set listchars=tab:│\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨

set colorcolumn=80
set signcolumn=yes

"install the plugin manager vim-plug
if empty(glob("~/.config/nvim/autoload/plug.vim"))
	execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'vimwiki/vimwiki'
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_markdown_link_ext = 1

Plug 'rlue/vim-barbaric' " for switching keyboard layouts
let g:XkbSwitchEnabled = 0

Plug 'itchyny/lightline.vim'
set noshowmode " lightline already shows mode in the status line

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-commentary'

Plug 'liuchengxu/vim-which-key'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf

Plug 'norcalli/nvim-colorizer.lua'

Plug 'tpope/vim-dispatch'

Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install'  }
let g:mkdp_browser = 'Brave Browser'
let g:mkdp_refresh_slow = 1

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Autocompletion
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

let g:tokyonight_transparent = 1
let g:tokyonight_colors = {'comment': '#60a0a0'}
colorscheme tokyonight

lua require'colorizer'.setup()

" Leader key
let mapleader = " "
let maplocalleader = '\'
nnoremap <silent> <leader>      :<c-u>WhichKey ' '<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '\'<CR>

call which_key#register('<Space>', "g:which_key_map_leader")
call which_key#register('\', "g:which_key_map_localleader")
let g:which_key_map_leader = {}
let g:which_key_map_leader.g = {
	  \ 'name': '+git',
      \ 's' : [':Git', 'git-status'],
      \ }
let g:which_key_map_leader.b = {
      \ 'name' : '+buffer' ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ '?' : ['Buffers'   , 'fzf-buffer']      ,
      \ }
let g:which_key_map_leader.f = {
      \ 'name' : '+fzf',
      \ 'b' : ['Buffers', 'fzf-buffer'],
      \ 'c' : ['Commands', 'fzf-commands'],
      \ 'f' : [':FZF', 'open-here'],
      \ 'g' : ['Rg', 'fzf-ripgrep'],
      \ 'k' : ['Maps', 'fzf-keymaps'],
      \ 's' : [":call fzf#run({'sink': 'split'})", 'open-in-split'],
      \ 'v' : [":call fzf#run({'sink': 'vsplit'})", 'open-in-vsplit'],
	  \ 'o' : [":call fzf#run({'sink': 'silent !open'})", 'open-in-macos'],
      \ }
let g:which_key_map_leader.w = {
      \ 'name' : '+vimwiki',
      \ }
let g:which_key_map_localleader = {}
let g:which_key_map_localleader.c = ['COQnow', 'completion']

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

tnoremap <Esc> <C-\><C-n>

" launch tectonic on every save of a LaTeX file
" augroup latex
" 	autocmd!
" 	autocmd BufEnter *tex let b:dispatch='tectonic %'
" 	autocmd BufWrite *tex Dispatch!
" augroup end

set completeopt=menu,menuone,noselect

lua << EOF
-- configure LSP
local coq = require("coq")
vim.g.coq_settings = {
	clients = {
		['buffers.enabled'] = false,
	},
}
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	server:setup(coq.lsp_ensure_capabilities(vim.lsp.protocol.make_client_capabilities()))
end)

-- configure treesitter
local configs = require'nvim-treesitter.configs'
configs.setup {
	ensure_installed = {
		'vim', 'lua',
		'python', 'cpp', 'go',
		'latex', 'bibtex',
		'markdown',
	},
	sync_install = false,
	highlight = {
		enable = true,
	},
	indent = {
		enable = false,
	}
}
EOF
