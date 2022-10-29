lua require('keymaps')


set nocompatible
"let mapleader = "\<Space>"

" =============================================================================
"   PLUGINS
" =============================================================================
call plug#begin()

" Per file editor config
Plug 'ciaranm/securemodelines'
Plug 'editorconfig/editorconfig-vim'

" Movement
Plug 'easymotion/vim-easymotion'

Plug 'takac/vim-hardtime' " Vim HardTime

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'machakann/vim-highlightedyank'  " Highlight yanks
Plug 'andymass/vim-matchup'           " Highlight corresponding blocks e.g. if - fi in bash
" Plug 'ctrlpvim/ctrlp.vim'             " Quick open

" GUI enhancements
Plug 'itchyny/lightline.vim'          " Better Status Bar
Plug 'mhinz/vim-startify'             " Better start screen
Plug 'scrooloose/nerdtree'            " File explorer
Plug 'psliwka/vim-smoothie'           " makes scrolling nice and smooth
Plug 'mhinz/vim-signify'              " indicate git added, modified and removed lines

Plug 'MunifTanjim/nui.nvim'           " UI Component Library for Neovim.

Plug 'chriskempson/base16-vim'        " Theme

Plug 'yggdroot/indentline'            " Shows indentation levels

" Autocomplete
" Semantic language support
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" language syntax
Plug 'vim-python/python-syntax'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

" Text Manipulation
Plug 'tpope/vim-surround'             " Surround with parentheses & co
Plug 'jiangmiao/auto-pairs'           " Auto comple for brackets, pairs
Plug 'tpope/vim-commentary'           " Comment code

" ============== nvim-lsp ==========
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Completion framework
Plug 'hrsh7th/nvim-cmp'
" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" only because nvim-cmp require snippets
" Snippet completion source for nvim-cmp
" Plug 'hrsh7th/cmp-vsnip'
" Snippet engine
" Plug 'hrsh7th/vim-vsnip'
" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
  

" signature help
Plug 'ray-x/lsp_signature.nvim'
" ==================================

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


" nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update


" Haskell
Plug 'neovimhaskell/haskell-vim'

" Misc
Plug 'kassio/neoterm'                        " A neovim's terminal with steroids


call plug#end() 


lua require('colorscheme')


" =============================================================================
"   SETTING
" =============================================================================
let g:python_highlight_all = 1

" ****************** start migriate """"""""""""

" filetype plugin indent on

lua require('globals')

" set number              " show line numbers
" set relativenumber      " show relative numbering
" set autoindent
" set smartindent
" set smarttab
" set ruler
" set expandtab
" set showmatch

" set lightline.vim
" set laststatus=2

" Permanent undo
" set undodir=~/.vimdid
" set undofile

" Proper search
" set incsearch
" set ignorecase
" set smartcase
" set gdefault

" Spaces & Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set tabstop=4       " number of visual spaces per TAB
" set softtabstop=4   " number of spaces in tab when editing
" set shiftwidth=4    " Insert 4 spaces on a tab
" set expandtab       " tabs are spaces, mainly because of python
" set softtabstop=4

" set background=dark

" java
" let java_ignore_javadoc = 1
" ******************************** end of current migrating *******************

" =============================================================================
"   PLUGIN CONFIG
" =============================================================================
"

"  PLUGIN SETTING IN lua
lua require('plugin/neoterm')


let g:indentLine_enabled = 0         " indentline
let g:hardtime_default_on = 0        " turn off hardmode

" rust 
let g:rustfmt_autosave = 1           "enable automatic running of :RustFmt when you save a buffer.
" run file for rust file
"  nnoremap <M-r> :RustRun<CR>
" test for rust file
"  nnoremap <M-t> :RustTest<CR>
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
" Avoid showing extra messages when using completion
set shortmess+=c

 
" =============================================================================
"  COC config
" =============================================================================
" lua require('plugin/cocnvim')

" =============================================================================
"  telecope config
" =============================================================================
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" =============================================================================
"  LSP config
" =============================================================================
" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body)
        require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    -- shift + tab
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

EOF


lua << EOF
local actions = require "telescope.actions"
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.close,
            },
            n = {
                ["<C-j>"] = actions.close,
            },
        }
    }
}

EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable



" =============================================================================
" # Autocommands
" =============================================================================

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float({scope="line"})
" don't know why inlay hit not show use lua config before, here use this
" method to show
autocmd CursorHold *.rs :lua require('rust-tools.inlay_hints').set_inlay_hints()

" Enable type inlay hints
" autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }
 




" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif



" =============================================================================
"  press <leader> call run current python 
" =============================================================================
" map <leader>r :call PRUN()<CR>
" func! PRUN()
"     exec "w" 
"     if &filetype == 'python'
"         exec "!python %"
"     endif
" endfunc

" ============================================================================
" fzf plugin config
" ============================================================================

" <leader>s for Rg search
let g:fzf_layout = { 'down': '~20%' }

noremap <leader>s :Rg<Space>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': ['--tiebreak=index', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}'] }, <bang>0)

