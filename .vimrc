set autoindent
set backspace=indent,eol,start
set colorcolumn=80
set expandtab
set foldenable
set foldlevel=2
set foldmethod=manual
set guifont=OperatorMonoSSm
set hlsearch
set laststatus=2
set linespace=1
set noshowmode
set number
set relativenumber
set shiftwidth=2
set showcmd
set smartindent
set smarttab
set nocursorline
set splitright
set tabstop=2
set textwidth=80
set title
set titlestring=%{expand(\"%:p:h\")}
set regexpengine=1 " using the old regex engine makes scrolling faster
syntax on

" source .vimrc anytime theres a change
autocmd BufWritePost .vimrc source %

" set .hbs, .vue files to .html format so splits are resized correctly
autocmd BufNewFile,BufRead *.hbs set ft=html

" json-style syntax-highlighting for .amprc files
autocmd BufNewFile,BufRead .amprc set syntax=json

" change swp file location so build systems dont pick up swp files
set directory=$HOME/.vim/swapfiles/

let mapleader = "\<Space>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" save and escape
nnoremap <Leader>s :w<CR>

" quit and escape
nnoremap <Leader>q :q<CR>

" insert line and stay in normal mode
nnoremap <Leader>o o<esc>

" NERDTree
nnoremap <Leader>t :NERDTreeToggle<CR>

" Clear search highlighting
nnoremap <Leader>c :nohl<CR>

" Command for refreshing CTRL+P cache and buffers to pick up new files
command Refresh CtrlPClearCache | bufdo e

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
   Plug 'dense-analysis/ale'
   Plug 'zhaocai/GoldenView.Vim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ctrl+P settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<C-f>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|dist'
let g:ctrlp_lazy_update = 100

" open in vertical split with <cr>
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-v>', '<2-LeftMouse>'],
    \ 'AcceptSelection("v")': ['<cr>', '<RightMouse>'],
    \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NODETree settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinSize=25
let g:NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command="goimports"
let g:go_highlight_functions=1
let g:go_highlight_operators=1
let g:go_highlight_function_calls=1
let g:go_highlight_types=1
let g:go_highlight_function_parameters=1
let g:go_fmt_fail_silently=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Path of vimwiki files
let g:vimwiki_list = [{'path' : '/Users/dpreston/Dropbox/vimwiki'}]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run both javascript and vue linters for vue files.
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {'vue': ['eslint']}
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

let g:ale_fixers = {
      \ '*': ['trim_whitespace'],
      \ 'javascript': ['eslint'],
      \ 'vue': ['eslint']
\}

" color of the marks in the vimgutter
highlight SignatureMarkText guifg=#ffcb6b

