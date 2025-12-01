return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },


  -- DAP support
  { "mfussenegger/nvim-dap" },

  -- Flutter tools
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup {
        -- Flutter debugger config
        debugger = {
          enabled = false,
          run_via_dap = false,
          register_configurations = function(_)
            local dap = require("dap")
            dap.adapters.dart = {
              type = "executable",
              command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
              args = { "flutter" },
            }

            dap.configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch flutter",
                dartSdkPath = "home/flutter/bin/cache/dart-sdk/",
                flutterSdkPath = "home/flutter",
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
              },
            }
          end,
        },
        dev_log = {
          enabled = false, -- set true if not using DAP
          open_cmd = "tabedit",
        },
        lsp = {
          on_attach = function(client, bufnr)
            local lspconfig = require("nvchad.configs.lspconfig")
            if lspconfig.on_attach then
              lspconfig.on_attach(client, bufnr)
            end
          end,
          capabilities = require("nvchad.configs.lspconfig").capabilities,
        },
      }
    end,
  },

  -- Dart syntax highlighting
  { "dart-lang/dart-vim-plugin" },
}

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
