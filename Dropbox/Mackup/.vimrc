set autoindent
set colorcolumn=80
set expandtab
set foldlevel=2
set foldmethod=manual
set foldnestmax=10
set foldenable
set guifont=OperatorMonoSSm
set hlsearch
set linespace=1
set number
set relativenumber
set shiftwidth=2
set showcmd
set smartindent
set smarttab
set tabstop=2
set textwidth=80
set title
set noshowmode
syntax on
set titlestring=%{expand(\"%:p:h\")}

" source .vimrc anytime theres a change
autocmd BufWritePost .vimrc source %

" remove trailing spaces from certain file types
autocmd FileType js,vue autocmd BufWritePre <buffer> %s/\s\+$//e

" html-style syntax-highlighting for .hbs, .vue files
autocmd BufNewFile,BufRead *.hbs,*.vue set syntax=html

" set .hbs, .vue files to .html format so splits are resized correctly
autocmd BufNewFile,BufRead *.hbs set ft=html

" js-style syntax-highlighting for .json files
autocmd BufNewFile,BufRead *.json set syntax=javascript

" change swp file location so build systems dont pick up swp files
set directory=$HOME/.vim/swapfiles/

let mapleader = "\<Space>"

" save and escape
nnoremap <Leader>s :w<CR>

" quit and escape
nnoremap <Leader>q :q<CR>

" insert line and stay in normal mode
nnoremap <Leader>o o<esc>

" paste from register 0 in normal mode
nnoremap <Leader>0 "0p

" CtrlP
nnoremap <Leader>p :CtrlP<CR>

" NERDTree
nnoremap <Leader>t :NERDTreeToggle<CR>

" Clear search highlighting
nnoremap <Leader>c :nohl<CR>

" Command for refreshing CTRL+P cache and buffers to pick up new files
command Refresh CtrlPClearCache | bufdo e

"""""""""""""
" Plugins
"""""""""""""
call plug#begin('~/.vim/plugged')
   Plug 'christoomey/vim-sort-motion'
   Plug 'ctrlpvim/ctrlp.vim'
   Plug 'despreston/palenight.vim'
   Plug 'fatih/vim-go'
   Plug 'itchyny/lightline.vim'
   Plug 'kshenoy/vim-signature'
   Plug 'michaeljsmith/vim-indent-object'
   Plug 'pangloss/vim-javascript'
   Plug 'scrooloose/nerdtree'
   Plug 'tmsvg/pear-tree'
   Plug 'tpope/vim-commentary'
   Plug 'tpope/vim-surround'
   Plug 'vimwiki/vimwiki'
   Plug 'zhaocai/GoldenView.Vim'
   Plug 'dense-analysis/ale'
call plug#end()

"""""""""""""""""""""""
" Theme Settings
"""""""""""""""""""""""
let g:palenight_terminal_italics=1
colorscheme palenight
set termguicolors

let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'component_function': {
      \   'filename': 'LightLineFilename'
      \ }
      \ }
function! LightLineFilename()
  return expand('%')
endfunction

" I have better plugins to handle syntax for these filetypes
let g:polyglot_disabled = ['json', 'jsx', 'javascript', 'vue']

" shortcut for ctrlp
let g:ctrlp_map = '<c-o>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|dist'
let g:ctrlp_lazy_update = 100

" open in vertical split with <cr>
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-v>', '<2-LeftMouse>'],
    \ 'AcceptSelection("v")': ['<cr>', '<RightMouse>'],
    \ }

"""""""""""""""""""
" NODETree settings
"""""""""""""""""""
let g:NERDTreeWinSize=25
let g:NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1


" enable backspace to delete over line breaks or auto-inserted indents
set backspace=indent,eol,start

" open split file on right
set splitright

" idk what this does but it fixes lightline
set laststatus=2

" color of the marks in the vimgutter
highlight SignatureMarkText guifg=#ffcb6b

" Settings for vim-go syntax highlighting
let g:go_highlight_functions=1
let g:go_highlight_operators=1
let g:go_highlight_function_calls=1
let g:go_highlight_types=1
let g:go_highlight_function_parameters=1
let g:go_gopls_enabled=0

" Path of vimwiki files
let g:vimwiki_list = [{'path' : '/Users/dpreston/Dropbox/vimwiki'}]

let g:ale_fixers = {
      \ '*': ['trim_whitespace'],
      \ 'javascript': ['eslint'],
\}

let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

