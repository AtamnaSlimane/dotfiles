require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- inside terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Exit terminal insert mode" })
