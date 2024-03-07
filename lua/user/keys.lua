-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighLight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
--

-- move back and forward in the quickfix list
vim.keymap.set('n', '<C-j>', '<cmd>cnext<cr>')
vim.keymap.set('n', '<C-k>', '<cmd>cprevious<cr>')
