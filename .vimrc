set autochdir
set autoindent
set colorcolumn=80
set expandtab
set foldlevel=2
set foldmethod=indent
set foldnestmax=10
set guifont=OperatorMonoSSm
set hlsearch
set linespace=1
set nofoldenable
set number 
set relativenumber
set rnu
set shiftwidth=2
set showcmd
set smartindent
set smarttab
set tabstop=2
set textwidth=80
syntax on

" source .vimrc anytime theres a change
autocmd BufWritePost .vimrc source %

" remove trailing spaces from certain file types
autocmd FileType js,vue autocmd BufWritePre <buffer> %s/\s\+$//e

" change swp file location so build systems dont pick up swp files
:set directory=$HOME/.vim/swapfiles/

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

"""""""""""""
" Plugins
"""""""""""""
call plug#begin('~/.vim/plugged')
  Plug 'christoomey/vim-sort-motion'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'despreston/palenight.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'posva/vim-vue'
  Plug 'scrooloose/nerdtree'
  Plug 'sheerun/vim-polyglot'
  Plug 'pangloss/vim-javascript'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'zhaocai/GoldenView.Vim'
call plug#end()

"""""""""""""""""""""""
" Theme Settings
"""""""""""""""""""""""
" set background=dark
let g:palenight_terminal_italics=1
colorscheme palenight
set termguicolors
let g:lightline = { 'colorscheme': 'palenight' }

let g:polyglot_disabled = ['json', 'jsx', 'javascript', 'vue']

" shortcut for ctrlp
let g:ctrlp_map = '<c-o>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|dist'
let g:ctrlp_lazy_update = 100

" NODETree settings
let g:NERDTreeWinSize=25
map <C-t> :NERDTreeToggle<CR>
:let g:NERDTreeShowLineNumbers=1
:autocmd BufEnter NERD_* setlocal rnu
let NERDTreeShowHidden=1

" enable backspace to delete over line breaks or auto-inserted indents
set backspace=indent,eol,start

" open split file on right
set splitright

" idk what this does but it fixes lightline
set laststatus=2

" GoldenView shortcuts
nmap <silent> <C-]>  <Plug>GoldenViewNext
nmap <silent> <C-[>  <Plug>GoldenViewPrevious
