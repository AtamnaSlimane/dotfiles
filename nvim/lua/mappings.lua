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

local opts = { noremap = true, silent = true }

-- Go to definition
map("n", "gd", vim.lsp.buf.definition, opts)
-- Go to declaration
map("n", "gD", vim.lsp.buf.declaration, opts)
-- Go to implementation
map("n", "gi", vim.lsp.buf.implementation, opts)
-- Go to type definition
map("n", "gt", vim.lsp.buf.type_definition, opts)
-- Find references
map("n", "gr", vim.lsp.buf.references, opts)

-- Hover documentation
map("n", "K", vim.lsp.buf.hover, opts)
-- Signature help (insert mode)
map("i", "<C-h>", vim.lsp.buf.signature_help, opts)

-- Code actions
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
-- Rename symbol
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
-- Formatting
map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<leader>z", vim.diagnostic.open_float, opts)
map("n", "<leader>q", vim.diagnostic.setloclist, opts)




local wk = require("which-key")

wk.register({
  -- LSP / General
  ["<C-h>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Signature Help" },
  ["K"]      = { "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover Documentation" },
  ["[d]"]    = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous Diagnostic" },
  ["]d"]    = { "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },

  -- LSP Go mappings (safer prefixes)
  g = {
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to Declaration" },
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to Definition" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Go to Type Definition" },
    r = {
      name = "References",
      f = { "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Find References" }, -- changed from gr to g r f
    },
  },

  -- Leader LSP mappings
  ["<leader>l"] = {
    name = "LSP",
    ca = { "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
    f  = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", desc = "Format Buffer" },
    q  = { "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "Diagnostics List" },
    rn = { "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename Symbol" },
    z  = { "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show Diagnostic" },
  },

  -- Telescope safe prefixes (<leader>F instead of <Space>f)
  ["<leader>F"] = {
    name = "Find",
    h = { "<cmd>Telescope help_tags<CR>", desc = "Help Pages" },
    b = { "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    o = { "<cmd>Telescope oldfiles<CR>", desc = "Old Files" },
    f = { "<cmd>Telescope find_files<CR>", desc = "Files" },
    w = { "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
    a = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", desc = "All Files" },
    m = { "<cmd>Format<CR>", desc = "Format File" },
    z = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Find in Buffer" },
  },

  -- Comment mappings (avoid gc overlap)
  ["<leader>c"] = {
    name = "Comment",
    t = { "<cmd>ToggleComment<CR>", desc = "Toggle Comment" },
    l = { "<cmd>ToggleLineComment<CR>", desc = "Toggle Line Comment" },
  },
}, { mode = "n" })
