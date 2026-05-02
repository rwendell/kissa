hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "kissa"
lua require("kissa").setup({ variant = "auto" })