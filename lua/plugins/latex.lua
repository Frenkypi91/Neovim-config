--------------------------------------
-- LaTeX
--------------------------------------
return {
  {
    "lervag/vimtex",
    ft = { "tex" },
    init = function()
      -- Use Okular for PDF viewing
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"

      -- Enable latexmk
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        options = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
        },
      }

      -- Quickfix behavior
      vim.g.vimtex_quickfix_open_on_warning = 0 -- open only on errors

      -- Improve LSP-ish diagnostics via texlab
      vim.g.vimtex_complete_enabled = 1
    end,
  },

--------------------------------------
-- Markdown preview
--------------------------------------
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown" },
    opts = {},
  },
}
