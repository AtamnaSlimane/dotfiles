require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls","clangd","pyright","jdtls","phpactor","intelephense","gopls","css-lsp","dartls","typescript-language-server" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
