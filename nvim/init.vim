set noswapfile
set scrolloff=6
set ignorecase
set smartcase
set backspace=indent,eol,start
set colorcolumn=100
set expandtab
set foldlevel=2
set laststatus=2
set number
set relativenumber
set shiftwidth=2
set smartindent
set splitright
set tabstop=2
set textwidth=100
set title
set titlestring=%{expand(\"%:p:h\")}
set guicursor=

" after saving anything in ~/vimwiki, sync for google drive for backup
au! BufWritePost ~/vimwiki/* silent
  \ execute "!rclone sync ~/vimwiki/ google-drive:vimwiki/" |
  \ redraw!

" Path of vimwiki files
let g:vimwiki_list = [{'path' : '/Users/des/vimwiki'}]

" Go spacing
au Filetype go setl noet ts=4 sw=4

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
nnoremap <C-f> :Telescope git_files<CR>
nnoremap <Leader>g :Telescope live_grep<CR>
nnoremap <Leader>r :Telescope lsp_references<CR>
nnoremap <Leader>m :Telescope marks<CR>
nnoremap <Leader>h :Telescope command_history<CR>
nnoremap <Leader>t :GoTest<CR>
nnoremap <Leader>v :Vex<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
    Plug 'kshenoy/vim-signature'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'tpope/vim-surround'
    Plug 'vimwiki/vimwiki'
    Plug 'zhaocai/GoldenView.Vim'
    Plug 'morhetz/gruvbox'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'windwp/nvim-autopairs'
    Plug 'hoob3rt/lualine.nvim'
    Plug 'terrortylor/nvim-comment'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox
set termguicolors

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General visual setting overrides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color of the marks in the vimgutter
hi SignatureMarkText guifg=#ffcb6b
" Don't highlight search results after searching.
hi Search NONE
" color of line number that cursor is on
hi CursorLineNr term=bold ctermfg=10 gui=bold guifg=#7c6f64 

if has("nvim")
    lua require("misc")
endif
