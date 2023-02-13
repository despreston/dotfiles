vim.opt.scrolloff = 6
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
vim.opt.completeopt = 'menu,menuone,noselect'

vim.g.mapleader = ' '
vim.g.go_fmt_fail_silently = 1

vim.api.nvim_set_keymap('n', '<Leader>o', 'o<esc>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>s', ':w<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Telescope find_files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>g', ':Telescope live_grep<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>u', ':Telescope lsp_references<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>m', ':Telescope marks<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>h', ':Telescope command_history<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>t', ':GoTest<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>v', ':Vex<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>x', ':Ex<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>b', ':!gh browse %<CR>', {noremap = true})

-- Go spacing
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  command = "setl noet ts=4 sw=4",
})

-- PLUGIN STUFF
vim.cmd('packadd paq-nvim')
require 'paq' {
  {'savq/paq-nvim', opt = true};
  'hrsh7th/nvim-cmp';
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-path';
  'hrsh7th/cmp-nvim-lsp';
  'L3MON4D3/LuaSnip';
  'nvim-treesitter/nvim-treesitter';
  'kshenoy/vim-signature';
  'michaeljsmith/vim-indent-object';
  'tpope/vim-surround';
  'zhaocai/GoldenView.Vim';
  'morhetz/gruvbox';
  'neovim/nvim-lspconfig';
  'hoob3rt/lualine.nvim';
  'nvim-lua/plenary.nvim';
  'terrortylor/nvim-comment';
  'nvim-telescope/telescope.nvim';
  'gpanders/editorconfig.nvim';
  'nvim-treesitter/playground';
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
    enable = true
  },
}

vim.api.nvim_set_hl(0, '@variable', { link = 'None' })
vim.api.nvim_set_hl(0, '@property', { link = 'None' })
vim.api.nvim_set_hl(0, '@constant.builtin', { link = 'None' })
vim.api.nvim_set_hl(0, '@namespace', { link = 'None' })
vim.api.nvim_set_hl(0, '@field', { link = 'None' })

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

-- setup nvim-cmp
local cmp = require('cmp')
local select_opts = {behavior = cmp.SelectBehavior.Select}
cmp.setup {
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'buffer', keyword_length = 3},
    {name = 'nvim_lsp', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  mapping = {
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'tsserver', 'gopls', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

nvim_lsp.graphql.setup {
  on_attach = on_attach,
  command = 'graphql-lsp',
  filetypes = { 'typescript', 'typescriptreact', 'go', 'graphql' },
  settings = { ['graphql-config.load.legacy'] = true },
  initializationOptions = { ['graphql-config.load.legacy'] = true }
}

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

