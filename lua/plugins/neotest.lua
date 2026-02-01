------------------------------------
-- Test runner
------------------------------------
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "rouge8/neotest-rust",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      table.insert(opts.adapters, require("neotest-python")({
        runner = "pytest",
      }))
      table.insert(opts.adapters, require("neotest-rust")({}))
      return opts
    end,
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Test: nearest" },
      { "<leader>tT", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: file" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test: output" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test: summary" },
    },
  },
}
