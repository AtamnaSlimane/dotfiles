return {
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          python = { "black", "isort" },
          php = { "php_cs_fixer" },
          -- Add more as needed
        },
        format_on_save = {
          timeout_ms = 2000,
          lsp_fallback = true,
        },
      })

      -- ✅ Manually define the :Format command
      vim.api.nvim_create_user_command("Format", function(args)
        local buf = args.buf or 0
        conform.format({
          buf = buf,
          async = true,
          timeout_ms = 2000,
        })
      end, {
        desc = "Format current buffer with conform.nvim",
        bang = true,
      })

      -- Optional: :FormatWrite (format + save)
      vim.api.nvim_create_user_command("FormatWrite", function()
        conform.format({
          buf = 0,
          async = false,
          timeout_ms = 2000,
        })
        vim.cmd.write()
      end, {
        desc = "Format and save current buffer",
      })
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "folke/todo-comments.nvim",
    lazy = false, -- force load so it actually activates
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({})
    end,
  },
  {
    "michaelb/sniprun",
    branch = "master",

    build = "sh install.sh",
    cmd = { "SnipRun" },
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

    config = function()
      require("sniprun").setup({
        -- your options
      })
    end,
  },

  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local navic = require("nvim-navic")

      -- 1️⃣ Setup Navic
      navic.setup {
        highlight = true,
        separator = "  ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true,
        icons = {
          File          = "󰈙 ",
          Module        = "󰆧 ",
          Namespace     = "󰅪 ",
          Package       = "󰏗 ",
          Class         = "󰌗 ",
          Method        = "󰆧 ",
          Property      = "󰜢 ",
          Field         = "󰜢 ",
          Constructor   = "󰆧 ",
          Enum          = "󰕘 ",
          Interface     = "󰕘 ",
          Function      = "󰊕 ",
          Variable      = "󰀫 ",
          Constant      = "󰏿 ",
          String        = "󰀬 ",
          Number        = "󰎠 ",
          Boolean       = "󰨙 ",
          Array         = "󰅪 ",
          Object        = "󰅩 ",
          Key           = "󰌋 ",
          Null          = "󰟢 ",
          EnumMember    = "󰕘 ",
          Struct        = "󰌗 ",
          Event         = "󰉁 ",
          Operator      = "󰆕 ",
          TypeParameter = "󰊄 ",
        },
      }

      local hl = vim.api.nvim_set_hl

      -- TokyoDark palette
      hl(0, "NavicIconsFile", { fg = "#7aa2f7" })      -- blue
      hl(0, "NavicIconsClass", { fg = "#bb9af7" })     -- purple
      hl(0, "NavicIconsMethod", { fg = "#7dcfff" })    -- cyan
      hl(0, "NavicIconsFunction", { fg = "#7dcfff" })  -- cyan
      hl(0, "NavicIconsVariable", { fg = "#e0af68" })  -- yellow
      hl(0, "NavicIconsField", { fg = "#ff9e64" })     -- orange
      hl(0, "NavicIconsProperty", { fg = "#ff9e64" })  -- orange
      hl(0, "NavicIconsNamespace", { fg = "#9d7cd8" }) -- soft violet
      hl(0, "NavicIconsPackage", { fg = "#c0caf5" })   -- light foreground

      hl(0, "NavicText", { fg = "#c0caf5" })           -- main text
      hl(0, "NavicSeparator", { fg = "#565f89" })      -- muted gray
      -- 3️⃣ Auto-attach to LSP (NvChad safe)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.documentSymbolProvider then
            navic.attach(client, args.buf)
          end
        end,
      })

      -- 4️⃣ Inject into lualine (without editing lualine config)
      local ok, lualine = pcall(require, "lualine")
      if ok then
        local navic_component = {
          function()
            return navic.get_location()
          end,
          cond = function()
            return navic.is_available()
          end,
        }

        -- append to lualine_c
        table.insert(lualine.get_config().sections.lualine_c, navic_component)
        lualine.setup(lualine.get_config())
      end
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesitter-context').setup({
        enable = true,
        max_lines = 2, -- 0 means no limit
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = nil,
      })
    end
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    config = function()
      require("indent_blankline").setup {
        char = "│", -- vertical line for indentation
        show_trailing_blankline_indent = false,
        show_current_context = true, -- highlight the current block
        -- removed: show_current_context_start (v3 removed this)
        filetype_exclude = { "help", "NvimTree", "terminal" },
        buftype_exclude = { "terminal", "nofile" },
      }

      -- Optional: colors for context and regular indent
      vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#3c3836", nocombine = true })
      vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#fabd2f", nocombine = true })
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

  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local jdtls = require("jdtls")

          local root_dir = require("jdtls.setup").find_root({
            "settings.gradle",
            "settings.gradle.kts",
            "build.gradle",
            "build.gradle.kts",
            "pom.xml",
            ".git",
          })
          if not root_dir then
            return
          end

          local workspace = vim.fn.stdpath("data")
              .. "/jdtls-workspace/"
              .. vim.fn.fnamemodify(root_dir, ":p:h:t")

          jdtls.start_or_attach({
            cmd = { "jdtls" }, -- Mason
            root_dir = root_dir,
            init_options = {
              workspace = workspace,
            },
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    {
                      name = "JavaSE-21",
                      path = "/usr/lib/jvm/java-21-openjdk",
                    },
                  },
                },
              },
            },
          })
        end,
      })
    end,
  },
  -- {
  --   "yetone/avante.nvim",
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   -- ⚠️ must add this setting! ! !
  --   build = vim.fn.has("win32") ~= 0
  --       and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  --       or "make",
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   ---@module 'avante'
  --   ---@type avante.Config
  --   opts = {
  --     -- add any opts here
  --     -- this file can contain specific instructions for your project
  --     instructions_file = "avante.md",
  --     -- for example
  --     provider = "openai",
  --     providers = {
  --     openai = {
  -- endpoint = "https://generativelanguage.googleapis.com/v1beta/",
  --         model = "gemini-2.5-flash",
  --         timeout = 60000, -- Timeout in milliseconds
  --           extra_request_body = {
  --             temperature = 0.75,
  --             max_tokens = 20480,
  --           },
  -- api_key = os.getenv("OPENAI_API_KEY")
  --       },
  --       moonshot = {
  --         endpoint = "https://api.moonshot.ai/v1",
  --         model = "kimi-k2-0711-preview",
  --         timeout = 30000, -- Timeout in milliseconds
  --         extra_request_body = {
  --           temperature = 0.75,
  --           max_tokens = 32768,
  --         },
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "nvim-mini/mini.pick", -- for file_selector provider mini.pick
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --     "stevearc/dressing.nvim", -- for input provider dressing
  --     "folke/snacks.nvim", -- for input provider snacks
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
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
