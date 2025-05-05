-- Common settings for both Neovim and VSCode
vim.g.mapleader = ' '
vim.g.go_fmt_fail_silently = 1

-- Common keybindings that work in both environments
vim.api.nvim_set_keymap('n', '<Leader>o', 'o<esc>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>s', ':w<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<CR>', {noremap = true})

-- Load environment-specific settings
if vim.g.vscode then
  -- VSCode Neovim extension
  require('vscode')
else
  -- Native Neovim
  require('nvim-only')
end
