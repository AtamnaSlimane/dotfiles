-- safely require navic
local ok, navic = pcall(require, "nvim-navic")
if not ok then
  navic = nil  -- fallback if plugin not loaded yet
end

local default_opts = require("nvchad.configs.lspconfig").defaults()

-- Wrap the on_attach to include navic
local function on_attach(client, bufnr)
  -- call default on_attach first
  if default_opts.on_attach then
    default_opts.on_attach(client, bufnr)
  end

  -- attach navic if available and supported
  if navic and client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

-- Enable your servers with the wrapped on_attach
local servers = { "html", "cssls","clangd","pyright","jdtls","intelephense","gopls","css-lsp" }

for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp, { on_attach = on_attach })
end

-- Optional: auto attach Navic to any LSP (works for buffers opened later)
if navic then
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local bufnr = args.buf
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end,
  })
end
