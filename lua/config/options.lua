  vim.opt.background = "dark"
  vim.opt.termguicolors = true
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.signcolumn = "yes"
  vim.opt.cursorline = true
  vim.opt.splitright = true
  vim.opt.splitbelow = true

  vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    severity_sort = true,
    float = { border = "rounded" },
  })
