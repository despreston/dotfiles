-- Settings that only work in native Neovim (not VSCode)
vim.opt.scrolloff = 6
vim.opt.ignorecase = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.colorcolumn = '80'
vim.opt.expandtab = true
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.textwidth = 80
vim.opt.guicursor = ''
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.confirm = true

-- PLUGIN STUFF
vim.cmd 'packadd paq-nvim'
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
  'zhaocai/GoldenView.Vim';
  'morhetz/gruvbox';
  'neovim/nvim-lspconfig';
  'hoob3rt/lualine.nvim';
  'nvim-lua/plenary.nvim';
  'terrortylor/nvim-comment';
  'nvim-telescope/telescope.nvim';
  'editorconfig/editorconfig-vim';
}

vim.g.gruvbox_contrast_dark = 'soft'
vim.cmd('colorscheme gruvbox')
vim.cmd('set termguicolors')
vim.cmd('hi SignatureMarkText guifg=#ffcb6b')
vim.cmd('hi Search NONE')
vim.cmd('hi CursorLineNr term=bold ctermfg=10 gui=bold guifg=#7c6f64')

require('nvim_comment').setup()

-- Treesitter setup
vim.treesitter.language.register('sql', 'sql')
require('nvim-treesitter').setup {
  highlight = {
    enable = true,
    disable = { "sql" },
  },
}

-- Telescope setup
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "*.lock"
    },
  },
}

vim.api.nvim_set_keymap('n', '<Leader>u', ':Telescope lsp_references<CR>', {noremap = true})

vim.api.nvim_set_hl(0, '@variable', { link = 'None' })
vim.api.nvim_set_hl(0, '@property', { link = 'None' })
vim.api.nvim_set_hl(0, '@constant.builtin', { link = 'None' })
vim.api.nvim_set_hl(0, '@namespace', { link = 'None' })
vim.api.nvim_set_hl(0, '@field', { link = 'None' })
vim.api.nvim_set_hl(0, '@parameter', { link = 'None' })

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
        file_status = true,
        path = 1
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

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { noremap = true, silent = true, buffer = args.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format() end, opts)
  end,
})

local servers = { 'ts_ls', 'gopls', 'rust_analyzer' }
for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
  vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end
})
