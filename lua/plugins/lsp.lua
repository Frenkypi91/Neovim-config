return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = {
        "pyright",
        "julia-lsp",
        "r-languageserver",
        "clangd",
        "rust-analyzer",
        "fortls",
        "texlab",
        "html-lsp",
        "css-lsp",
      }
      return opts
    end,
  },
}
