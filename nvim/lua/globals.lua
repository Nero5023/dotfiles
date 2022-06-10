
local set = vim.opt

-- line number config 
set.number = true             -- show line numbers
set.relativenumber = true     -- show relative numbering

-- indent
vim.cmd('filetype plugin indent on')
set.autoindent = true
set.smartindent = true
set.smarttab = true
set.ruler = true
set.expandtab = true
set.showmatch = true

-- display status 
set.laststatus = 2

-- Permanent undo
set.undodir = '~/.vimdid'
set.undofile = true

-- Proper search
set.incsearch = true
set.ignorecase = true
set.smartcase = true
set.gdefault = true

-- Spaces & Tabs
set.tabstop=4       -- number of visual spaces per TAB
set.softtabstop=4   -- number of spaces in tab when editing
set.shiftwidth=4    -- Insert 4 spaces on a tab
set.expandtab       -- tabs are spaces, mainly because of python
set.softtabstop=4


