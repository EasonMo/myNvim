-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- 设置缩进为2
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "lua" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
  group = vim.api.nvim_create_augroup("filetype_tab_width", { clear = true }),
})

-- 实现复制时与系统剪贴板同步，支持tmux，ssh
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = { "*" },
  callback = function()
    if vim.v.event.operator == "y" then
      vim.fn.setreg("+", vim.fn.getreg("0"))
    end
  end,
  group = vim.api.nvim_create_augroup("YankToClipboard", { clear = true }),
})
