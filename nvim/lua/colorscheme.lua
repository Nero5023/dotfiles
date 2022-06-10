local set = vim.opt


if not vim.fn.has("gui_running") then
    set.t_Co = 256
end

if (vim.fn.match(vim.env.TERM, "-256color") ~= -1) and (vim.fn.match(vim.env.TERM, "screen-256color") == -1) then
   -- screen does not (yet) support truecolor
   set.termguicolors = true
end

vim.g.base16colorspace = 256
set.background = "dark"

vim.cmd [[
    colorscheme base16-gruvbox-dark-hard
    syntax on
    hi Normal ctermbg=NONE
    " Brighter comments
    call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")
    " https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
    " call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
]]


-- java doc color
vim.g.java_ignore_javadoc = 1
