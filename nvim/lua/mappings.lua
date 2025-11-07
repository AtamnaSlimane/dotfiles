require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.opt.relativenumber=true
-- inside terminal mode
-- when  pressing jj it entern nteminal which can be exited with space x
vim.keymap.set('t', 'jjj', [[<C-\><C-n>]], { desc = "Exit terminal insert mode" })
