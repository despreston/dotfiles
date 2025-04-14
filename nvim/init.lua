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
vim.opt.guicursor = ''
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.confirm = true
vim.opt.winwidth = 105
vim.opt.clipboard = 'unnamedplus'
vim.o.wrap = false

vim.g.mapleader = ' '
vim.g.go_fmt_fail_silently = 1

vim.api.nvim_set_keymap('n', '<Leader>o', 'o<esc>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>s', ':w<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Telescope find_files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>g', ':Telescope live_grep<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>p', ':Telescope oldfiles<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>u', ':Telescope lsp_references<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>h', ':Telescope command_history<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>v', ':Vex<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>x', ':Ex<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-n>', '<C-W><Right>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', '<C-W><Left>', { noremap = true, silent = true })

-- PLUGIN STUFF
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    opts = { contrast = "soft" },
    init = function()
      vim.cmd("colorscheme gruvbox")
      vim.cmd('hi SignatureMarkText guifg=#ffcb6b')
      vim.cmd('hi Search NONE')
      vim.cmd('hi CursorLineNr term=bold ctermfg=10 gui=bold guifg=#7c6f64')
      vim.api.nvim_set_hl(0, '@variable.parameter.go', { link = 'None' })
      vim.api.nvim_set_hl(0, '@variable.member.go', { link = 'None' })
      vim.api.nvim_set_hl(0, '@module.go', { link = 'None' })
      vim.api.nvim_set_hl(0, '@property', { link = 'None' })
      vim.api.nvim_set_hl(0, '@package', { link = 'None' })
      vim.api.nvim_set_hl(0, '@constant.builtin', { link = 'None' })
      vim.api.nvim_set_hl(0, '@namespace', { link = 'None' })
      vim.api.nvim_set_hl(0, '@field', { link = 'None' })
      vim.api.nvim_set_hl(0, '@parameter', { link = 'None' })
    end
  };
  'L3MON4D3/LuaSnip';
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      highlight = {
        enable = true,
        disable = { "sql" },
      },
    }
  };
  'kshenoy/vim-signature';
  'michaeljsmith/vim-indent-object';
  'neovim/nvim-lspconfig';
  {
    'hoob3rt/lualine.nvim',
    opts = {
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
  };
  'nvim-lua/plenary.nvim';
  {
    'nvim-telescope/telescope.nvim',
    opts = {
      defaults = { 
        file_ignore_patterns = { 
          "*.lock" 
        },
        layout_strategy = "vertical",
        dynamic_preview_title = true,
      }
    }
  };
  {
    'rmagatti/auto-session',
    opts = {
      auto_session_enable_last_session = true,
      auto_restore_enabled = true,
    }
  };
  'github/copilot.vim';
  'prettier/vim-prettier';
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      local cmp = require('cmp')
      return {
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
    end
  };
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-path';
  'hrsh7th/cmp-nvim-lsp';
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    opts = {
      provider = "copilot",
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
})

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
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'ts_ls', 'gopls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- Go: Run gofmt/gofmpt, import packages automatically on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('setGoFormatting', { clear = true }),
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
    vim.lsp.buf.format()
  end
})

-- tsx: Run prettier on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('runPrettier', { clear = true }),
  pattern = '*.tsx',
  callback = function()
    vim.cmd('PrettierAsync')
  end
})

-- Treesitter setup
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = { "sql" },
  },
}
