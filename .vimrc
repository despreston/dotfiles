set autoindent
set noswapfile
set scrolloff=6
set incsearch
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
set nocursorline
set splitright
set tabstop=2
set textwidth=80
set title
set titlestring=%{expand(\"%:p:h\")}
set regexpengine=2
syntax on

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

" run GoTest
nnoremap <Leader>t :GoTest<CR>

nnoremap <C-f> :GFiles<CR>

nnoremap <Leader>v :Vex<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'fatih/vim-go'
    Plug 'itchyny/lightline.vim'
    Plug 'kshenoy/vim-signature'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'pangloss/vim-javascript'
    Plug 'tmsvg/pear-tree'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'vimwiki/vimwiki'
    Plug 'dense-analysis/ale'
    Plug 'zhaocai/GoldenView.Vim'
    Plug 'despreston/palenight.vim'
    Plug 'morhetz/gruvbox'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:palenight_terminal_italics=1
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
" Settings for vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command="goimports"
let g:go_highlight_functions=1
let g:go_highlight_operators=1
let g:go_highlight_function_calls=0
let g:go_highlight_types=1
let g:go_highlight_function_parameters=0
let g:go_fmt_fail_silently=1
let g:go_def_mod_mode='godef'
let g:go_highlight_trailing_whitespace_error=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Path of vimwiki files
let g:vimwiki_list = [{'path' : '/Users/des/vimwiki'}]

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
      \ 'typescript': ['deno'],
      \ 'javascript': ['eslint'],
      \ 'vue': ['eslint']
\}

" color of the marks in the vimgutter
highlight SignatureMarkText guifg=#ffcb6b
