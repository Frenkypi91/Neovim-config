  vim.g.lazyvim_check_order = false

  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      "git","clone","--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras" },
    { import = "plugins" },
  }, {
    defaults = { lazy = false, version = false },
    install = { colorscheme = { "oasis" } },
  })

  vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
    if vim.bo.buftype == "" then
      vim.api.nvim_win_set_cursor(0, {1, 0})
      end
      end,
  })
