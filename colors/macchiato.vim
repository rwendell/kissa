vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "macchiato"
require("macchiato.highlights").setup({ variant = "macchiato" })