vim.opt.scrolloff = 6
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.colorcolumn = '100'
vim.opt.expandtab = true
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.textwidth = 100
vim.opt.guicursor = ''
vim.opt.completeopt = 'menuone'

vim.g.mapleader = ' '
vim.g.vimwiki_list = {{path = '/Users/des/vimwiki'}}
vim.g.go_fmt_fail_silently = 1

vim.api.nvim_set_keymap('n', '<Leader>o', 'o<esc>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>s', ':w<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Telescope git_files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>g', ':Telescope live_grep<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>u', ':Telescope lsp_references<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>m', ':Telescope marks<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>h', ':Telescope command_history<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>t', ':GoTest<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>v', ':Vex<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>x', ':Ex<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>b', ':!gh browse %<CR>', {noremap = true})

-- after saving anything in ~/vimwiki, sync for google drive for backup
vim.api.nvim_command([[
  au! BufWritePost ~/vimwiki/* silent
    execute "!rclone sync ~/vimwiki/ google-drive:vimwiki/" |
    redraw!
]])

-- Go spacing
vim.api.nvim_command([[
  au Filetype go setl noet ts=4 sw=4
]])

-- PLUGIN STUFF
vim.cmd('packadd paq-nvim')
require 'paq' {
  {'savq/paq-nvim', opt = true};
  'nvim-treesitter/nvim-treesitter';
  'kshenoy/vim-signature';
  'michaeljsmith/vim-indent-object';
  'tpope/vim-surround';
  'vimwiki/vimwiki';
  'zhaocai/GoldenView.Vim';
  'morhetz/gruvbox';
  'neovim/nvim-lspconfig';
  'nvim-treesitter/nvim-treesitter';
  'fatih/vim-go';
  'hoob3rt/lualine.nvim';
  'terrortylor/nvim-comment';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
}

vim.g.gruvbox_contrast_dark = 'soft'
vim.cmd('colorscheme gruvbox')
vim.cmd('set termguicolors')
vim.cmd('hi SignatureMarkText guifg=#ffcb6b')
vim.cmd('hi Search NONE')
vim.cmd('hi CursorLineNr term=bold ctermfg=10 gui=bold guifg=#7c6f64')

require('nvim_comment').setup()

-- Treesitter setup
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    custom_captures = {
      ['punctuation.bracket'] = 'none',
      ['property'] = 'none',
      ['parameter'] = 'none',
      ['method'] = 'none',
      ['constant.builtin'] = 'Constant',
    },
  },
}

-- Lualine setup
require('lualine').setup{
  options = {
    icons_enabled = false,
    theme = 'gruvbox',
  },
  sections = {
    lualine_b = {'branch'},
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
    lualine_x = {'filetype'},
  }
}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'tsserver', 'gopls', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

nvim_lsp.vuels.setup {
  on_attach = on_attach,
  init_options = {
    config = {
      vetur = {
        validation = {
          script = false
        }
      }
    }
  }
}

