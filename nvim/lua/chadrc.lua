-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "tokyonight",
  transparency = true,  --
	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.plugins = {
  override = {
    ["nvim-tree/nvim-tree.lua"] = false,  -- disables the plugin
  },
  add = {
    ["SmiteshP/nvim-navic"] = {},
  }
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }
M.nvdash = {
    load_on_startup = true,  -- load dashboard when Neovim starts
    config = {
        header = {
        },
        buttons = {
            { "  Find File", "Telescope find_files" },
            { "  Recent Files", "Telescope oldfiles" },
            { "  Find Word",   "Telescope live_grep" },
            { "  New File",    "ene | startinsert" },
            { "  Load Session", "SessionLoad" },
            { "  Quit",        "qa" },
        },
        footer = { "🚀 Happy Coding with Neovim!" },
        options = {
            cursor_column = 0.5,  -- center the dashboard horizontally
            padding = { top = 2, bottom = 2 },
        },
    }
}
return M


