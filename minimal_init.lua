-- minimal_init.lua
vim.cmd('set runtimepath+=~/.config/nvim')
vim.cmd('set packpath+=~/.config/nvim')
require('lazy').setup({
    'neovim/nvim-lspconfig',
    -- add a minimal set of plugins here
})
