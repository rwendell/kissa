hi clear
if exists("syntax_on")
  syntax reset
endif
set background=light
let g:colors_name = "kissa"
lua require("kissa").setup({ variant = "latte" })