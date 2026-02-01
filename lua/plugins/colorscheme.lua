return {
  {
    "uhs-robert/oasis.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "starlight" },
    config = function(_, opts)
      require("oasis").setup(opts)
      vim.cmd.colorscheme("oasis")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "oasis" },
  },
}
