vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.o.background = "light"
vim.g.colors_name = "latte"
require("macchiato.highlights").setup({ variant = "latte" })