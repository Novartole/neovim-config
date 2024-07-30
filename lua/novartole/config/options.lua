local opt = vim.opt

vim.opt.vb = true -- never ever make terminal beep

-- appearance
--
opt.background = "dark" -- set background
opt.cursorline = true -- enable highlighting of the current line
opt.expandtab = true -- use spaces instead of tabs
opt.number = true -- print line number
opt.relativenumber = true -- relative line numbers
opt.scrolloff = 8 -- keep 8 lines left (up/down)
opt.shiftround = true -- round indent
opt.showmode = false -- don't show mode since we have a statusline
opt.sidescrolloff = 8 -- columns of context
opt.signcolumn = "yes" -- always show the signcolumn, otherwise it would shift the text each time
opt.splitbelow = true -- put new windows below current
opt.splitkeep = "screen" -- scroll behavior when opening, closing or resizing horizontal splits
opt.splitright = true -- put new windows right of current
opt.termguicolors = true -- true color support
opt.winminwidth = 5 -- minimum window width
opt.wrap = false -- disable line wrapping
opt.foldlevel = 99 -- folds with a higher level will be closed

-- pop-up
--
opt.pumheight = 20 -- maximum number of entries in a popup
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- avoid all the hit-enter prompts caused by file messages

-- backup
--
opt.backup = false
opt.swapfile = false
opt.undofile = true -- automatically saves undo history to an undo file
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- typing
--
opt.backspace = "indent,eol,start" -- backspace
opt.clipboard:append("unnamedplus") -- sync with system clipboard
opt.completeopt = "menu,menuone,noselect" -- Insert mode completion
opt.iskeyword:append("-") -- declare that '-' is not a separator
opt.shiftwidth = 2 -- size of an indent
opt.smartindent = true -- insert indents automatically
opt.softtabstop = 2
opt.spelllang = { "en", "ru" } -- check spelling for these languages
opt.tabstop = 2 -- number of spaces tabs count for
opt.wildmode = "longest:full,full" -- command-line completion mode

-- search & replace
--
opt.grepprg = "rg --vimgrep" -- use rg by default
opt.hlsearch = false
opt.ignorecase = true -- ignore case
opt.incsearch = true
opt.smartcase = true -- don't ignore case with capitals

-- works only on v0.10
if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end
