-- Use external .vimrc files
vim.opt.exrc = true

vim.opt.termguicolors = true

vim.opt.spelllang = {"en_us", "ru"}

vim.opt.splitbelow = true
vim.opt.splitright = true

-- Display all matching files when we tab-complete
vim.opt.wildmenu = true

-- Yank to the system clipboard
vim.opt.clipboard = "unnamed"

-- Indent with tabs, align with spaces
vim.opt.expandtab = false
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.scrolloff = 8

-- Reload file content every time it changes
vim.opt.autoread = true

-- Disable creating backups and swap files when editing
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Do not keep buffers in background
vim.opt.hidden = false

-- Wrap long lines
vim.opt.wrap = true

-- Search options
vim.opt.showmatch = true
vim.opt.hlsearch = true -- Search the word under cursor on *
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.list = true
vim.opt.showbreak = '↪ '
vim.opt.listchars = {
	tab = '│ ',
	nbsp = '␣',
	trail = '•',
	extends = '⟩',
	precedes = '⟨'
}

vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
