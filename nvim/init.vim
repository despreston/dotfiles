set autoindent
set noswapfile
set scrolloff=6
set incsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set colorcolumn=80
set expandtab
set foldenable
set foldlevel=2
set foldmethod=manual
set laststatus=2
set number
set relativenumber
set shiftwidth=2
set showcmd
set smartindent
set smarttab
set splitright
set tabstop=2
set textwidth=80
set title
set titlestring=%{expand(\"%:p:h\")}
set guicursor=

" after saving anything in ~/vimwiki, sync to rpi for backup
au! BufWritePost ~/vimwiki/* silent
  \ execute "!rsync -avz ~/vimwiki/ des-pi:/home/des/vimwiki" |
  \ redraw!

" Go spacing
au Filetype go setl noet ts=4 sw=4

let mapleader = "\<Space>"
let @i='oif err != nil {'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" save and escape
nnoremap <Leader>s :w<CR>

" quit and escape
nnoremap <Leader>q :q<CR>

" insert line and stay in normal mode
nnoremap <Leader>o o<esc>

nnoremap <C-f> :GFiles<CR>

nnoremap <Leader>v :Vex<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'kshenoy/vim-signature'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'vimwiki/vimwiki'
    Plug 'zhaocai/GoldenView.Vim'
    Plug 'morhetz/gruvbox'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }
    Plug 'nvim-treesitter/playground'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='soft'

colorscheme gruvbox
set termguicolors

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'component_function': {
      \   'filename': 'LightLineFilename'
      \ }
      \ }
function! LightLineFilename()
  return expand('%')
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General visual setting overrides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color of the marks in the vimgutter
hi SignatureMarkText guifg=#ffcb6b

" Don't highlight search results after searching.
hi Search NONE

" color of line number that cursor is on
hi CursorLineNr term=bold ctermfg=10 gui=bold guifg=#7c6f64 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Path of vimwiki files
let g:vimwiki_list = [{'path' : '/Users/des/vimwiki'}]

"----------------------------------------------------------------------
" Neovim
"----------------------------------------------------------------------
if has("nvim")
    lua require("misc")
endif
