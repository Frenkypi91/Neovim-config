  local map = vim.keymap.set
  map("n", "<leader>rr", function()
    require("snacks").terminal.open(nil, { win = { split = "right" } })
  end, { desc = "Open runner terminal" })
