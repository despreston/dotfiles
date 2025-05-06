-- Settings that only work in VSCode Neovim extension
-- Currently empty as most settings are handled by VSCode itself
-- Add VSCode-specific settings here as needed

-- Example of how to call VSCode commands if needed:
-- vim.api.nvim_set_keymap('n', '<Leader>f', "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>", {noremap = true})

-- LSP Keybindings equivalent to Neovim's LSP
-- These use VSCode's built-in LSP functionality
vim.api.nvim_set_keymap('n', 'gD', "<cmd>call VSCodeNotify('editor.action.revealDeclaration')<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gd', "<cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'K', "<cmd>call VSCodeNotify('editor.action.showHover')<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', "<cmd>call VSCodeNotify('editor.action.triggerParameterHints')<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<space>r', "<cmd>call VSCodeNotify('editor.action.rename')<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<space>e', "<cmd>call VSCodeNotify('editor.action.showHover')<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '[d', "<cmd>call VSCodeNotify('editor.action.marker.prev')<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', ']d', "<cmd>call VSCodeNotify('editor.action.marker.next')<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<space>f', "<cmd>call VSCodeNotify('editor.action.formatDocument')<CR>", {noremap = true, silent = true})
