return {
  "danilamihailov/beacon.nvim",
  event = { "BufReadPre", "BufNewFile" },

  config = function()

---------------------------------------
-- Beacon setup
---------------------------------------
require("beacon").setup({
    enabled = true,

    -- minimum jump distance to trigger the flash
    min_jump = 10,

    -- animation / appearance
    width = 40,      -- highlight width
    speed = 2,       -- fade speed
    fps = 60,        -- smoothness
    winblend = 70,   -- transparency

  -- events that trigger Beacon
  cursor_events = { "CursorMoved", "CursorMovedI" },
  window_events = { "WinEnter", "FocusGained" },

  -- sensible exclusions
  ignore_filetypes = {
    "help",
    "lazy",
    "mason",
    "qf",
    "TelescopePrompt",
    "Trouble",
    "neo-tree",
    "NvimTree",
    "dashboard",
    "alpha",
  },
  ignore_buftypes = {
    "terminal",
    "nofile",
    "prompt",
  },
  })

---------------------------------------
-- Highlight
---------------------------------------
local function set_beacon_hl()
  vim.api.nvim_set_hl(0, "Beacon", {
    bg = "#2f3e46", -- perfect for Oasis Dark
    blend = 0,
  })
  end

  -- apply immediately
  set_beacon_hl()

  -- reapply after every colorscheme change
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_beacon_hl,
  })

---------------------------------------
-- Toggle Beacon (<leader>b)
---------------------------------------
vim.g.beacon_enabled = true

  vim.keymap.set("n", "<leader>b", function()
  local ok, beacon = pcall(require, "beacon")
  if not ok then return end

    vim.g.beacon_enabled = not vim.g.beacon_enabled
    beacon.setup({ enabled = vim.g.beacon_enabled })

    vim.notify(
      vim.g.beacon_enabled and "Beacon: ON" or "Beacon: OFF",
      vim.log.levels.INFO
    )
    end, { desc = "Toggle Beacon" })
  end
}
