local colors = require("kissa.colors")

local M = {}

function M.setup(opts)
  opts = opts or {}
  local variant = opts.variant or vim.o.background == "light" and "latte" or "macchiato"
  local p = colors.palettes[variant]

  vim.cmd("hi clear")
  vim.o.termguicolors = true
  vim.g.kissa_variant = variant
  vim.g.colors_name = "kissa"

  local hi = vim.api.nvim_set_hl
  local ns = 0

  -- Editor
  hi(ns, "Normal", { fg = p.fg, bg = p.bg })
  hi(ns, "NormalFloat", { fg = p.fg, bg = p.bg_alt })
  hi(ns, "FloatBorder", { fg = p.fg_subtle, bg = p.bg_alt })
  hi(ns, "NormalNC", { fg = p.fg_dim, bg = p.bg })
  hi(ns, "SignColumn", { fg = p.fg_subtle, bg = p.bg })
  hi(ns, "FoldColumn", { fg = p.fg_subtle, bg = p.bg })
  hi(ns, "CursorLine", { bg = p.bg_alt })
  hi(ns, "CursorLineNr", { fg = p.yellow, bg = p.bg_alt })
  hi(ns, "LineNr", { fg = p.fg_subtle, bg = p.bg })
  hi(ns, "ColorColumn", { bg = p.surface0 })
  hi(ns, "Whitespace", { fg = p.surface1 })

  -- Cursor
  hi(ns, "Cursor", { fg = p.bg, bg = p.fg })
  hi(ns, "lCursor", { link = "Cursor" })
  hi(ns, "CursorIM", { link = "Cursor" })
  hi(ns, "CursorColumn", { link = "CursorLine" })

  -- Selection
  hi(ns, "Visual", { fg = p.fg, bg = p.surface0 })
  hi(ns, "VisualNOS", { link = "Visual" })

  -- Search
  hi(ns, "Search", { fg = p.bg, bg = p.yellow })
  hi(ns, "IncSearch", { fg = p.bg, bg = p.orange })
  hi(ns, "CurSearch", { link = "IncSearch" })
  hi(ns, "Substitute", { fg = p.fg, bg = p.surface0 })

  -- Window
  hi(ns, "WinSeparator", { fg = p.surface1 })
  hi(ns, "EndOfBuffer", { fg = p.surface1 })

  -- Menu/completion
  hi(ns, "Pmenu", { fg = p.fg, bg = p.surface0 })
  hi(ns, "PmenuSel", { fg = p.fg, bg = p.surface1 })
  hi(ns, "PmenuSbar", { bg = p.surface1 })
  hi(ns, "PmenuThumb", { bg = p.surface2 })
  hi(ns, "WildMenu", { link = "PmenuSel" })

  -- Statusline
  hi(ns, "StatusLine", { fg = p.fg_dim, bg = p.bg_alt })
  hi(ns, "StatusLineNC", { fg = p.fg_subtle, bg = p.bg_alt })
  hi(ns, "StatusLineTerm", { link = "StatusLine" })
  hi(ns, "StatusLineTermNC", { link = "StatusLineNC" })

  -- Tabline
  hi(ns, "TabLine", { fg = p.fg_dim, bg = p.bg_alt })
  hi(ns, "TabLineFill", { bg = p.bg })
  hi(ns, "TabLineSel", { fg = p.fg, bg = p.surface0 })

  -- Syntax
  hi(ns, "Comment", { fg = p.fg_subtle })
  hi(ns, "Constant", { fg = p.purple })
  hi(ns, "String", { fg = p.green })
  hi(ns, "Character", { fg = p.green })
  hi(ns, "Number", { fg = p.orange })
  hi(ns, "Float", { link = "Number" })
  hi(ns, "Boolean", { fg = p.purple })
  hi(ns, "Identifier", { fg = p.fg_dim })
  hi(ns, "Function", { fg = p.blue })
  hi(ns, "Statement", { fg = p.purple })
  hi(ns, "Conditional", { fg = p.purple })
  hi(ns, "Repeat", { fg = p.purple })
  hi(ns, "Label", { fg = p.yellow })
  hi(ns, "Operator", { fg = p.orange })
  hi(ns, "Keyword", { fg = p.blue })
  hi(ns, "Exception", { fg = p.red })
  hi(ns, "PreProc", { fg = p.pink })
  hi(ns, "Include", { fg = p.blue })
  hi(ns, "Define", { fg = p.blue })
  hi(ns, "Macro", { fg = p.pink })
  hi(ns, "PreCondit", { fg = p.pink })
  hi(ns, "Type", { fg = p.teal })
  hi(ns, "Typedef", { fg = p.teal })
  hi(ns, "StorageClass", { fg = p.orange })
  hi(ns, "Structure", { fg = p.teal })
  hi(ns, "Special", { fg = p.yellow })
  hi(ns, "SpecialChar", { fg = p.orange })
  hi(ns, "Tag", { fg = p.blue })
  hi(ns, "Delimiter", { fg = p.fg_dim })
  hi(ns, "SpecialComment", { fg = p.fg_subtle })
  hi(ns, "Debug", { fg = p.orange })
  hi(ns, "Underlined", { fg = p.blue, underline = true })
  hi(ns, "Error", { fg = p.red, bg = p.bg })
  hi(ns, "Todo", { fg = p.yellow, bg = p.bg, bold = true })

  -- Diff
  hi(ns, "DiffAdd", { fg = p.green, bg = p.surface0 })
  hi(ns, "DiffChange", { fg = p.blue, bg = p.surface0 })
  hi(ns, "DiffDelete", { fg = p.red, bg = p.surface0 })
  hi(ns, "DiffText", { fg = p.yellow, bg = p.surface0 })
  hi(ns, "diffAdded", { fg = p.green })
  hi(ns, "diffRemoved", { fg = p.red })
  hi(ns, "diffChanged", { fg = p.blue })
  hi(ns, "diffOldFile", { fg = p.red })
  hi(ns, "diffNewFile", { fg = p.green })
  hi(ns, "diffFile", { fg = p.yellow })
  hi(ns, "diffLine", { fg = p.fg_subtle })
  hi(ns, "diffIndexLine", { fg = p.blue })

  -- Diagnostics
  hi(ns, "DiagnosticError", { fg = p.red })
  hi(ns, "DiagnosticWarn", { fg = p.yellow })
  hi(ns, "DiagnosticInfo", { fg = p.blue })
  hi(ns, "DiagnosticHint", { fg = p.teal })
  hi(ns, "DiagnosticSignError", { link = "DiagnosticError" })
  hi(ns, "DiagnosticSignWarn", { link = "DiagnosticWarn" })
  hi(ns, "DiagnosticSignInfo", { link = "DiagnosticInfo" })
  hi(ns, "DiagnosticSignHint", { link = "DiagnosticHint" })
  hi(ns, "DiagnosticUnderlineError", { sp = p.red, underline = true })
  hi(ns, "DiagnosticUnderlineWarn", { sp = p.yellow, underline = true })
  hi(ns, "DiagnosticUnderlineInfo", { sp = p.blue, underline = true })
  hi(ns, "DiagnosticUnderlineHint", { sp = p.teal, underline = true })
  hi(ns, "DiagnosticVirtualTextError", { fg = p.red, bg = p.surface0 })
  hi(ns, "DiagnosticVirtualTextWarn", { fg = p.yellow, bg = p.surface0 })
  hi(ns, "DiagnosticVirtualTextInfo", { fg = p.blue, bg = p.surface0 })
  hi(ns, "DiagnosticVirtualTextHint", { fg = p.teal, bg = p.surface0 })

  -- Git signs
  hi(ns, "GitSignsAdd", { fg = p.green })
  hi(ns, "GitSignsChange", { fg = p.blue })
  hi(ns, "GitSignsDelete", { fg = p.red })
  hi(ns, "GitSignsAddLn", { fg = p.green, bg = p.surface0 })
  hi(ns, "GitSignsChangeLn", { fg = p.blue, bg = p.surface0 })
  hi(ns, "GitSignsDeleteLn", { fg = p.red, bg = p.surface0 })

  -- Folds
  hi(ns, "Folded", { fg = p.fg_subtle, bg = p.bg_alt })
  hi(ns, "MatchParen", { fg = p.yellow, bg = p.surface0, bold = true })
  hi(ns, "NonText", { fg = p.surface1 })
  hi(ns, "SpecialKey", { fg = p.fg_subtle })
  hi(ns, "Conceal", { fg = p.fg_subtle })

  -- Spell
  hi(ns, "SpellBad", { sp = p.red, undercurl = true })
  hi(ns, "SpellCap", { sp = p.blue, undercurl = true })
  hi(ns, "SpellLocal", { sp = p.yellow, undercurl = true })
  hi(ns, "SpellRare", { sp = p.purple, undercurl = true })

  -- Title/modes
  hi(ns, "Title", { fg = p.yellow, bold = true })
  hi(ns, "Question", { fg = p.teal })
  hi(ns, "ModeMsg", { fg = p.fg_dim })
  hi(ns, "MoreMsg", { fg = p.blue })
  hi(ns, "WarningMsg", { fg = p.yellow })
  hi(ns, "ErrorMsg", { fg = p.red })

  -- Quickfix
  hi(ns, "QuickFixLine", { bg = p.surface0 })
  hi(ns, "qfLineNr", { fg = p.fg_subtle })
  hi(ns, "qfSeparator", { fg = p.fg_subtle })

  -- Treesitter
  hi(ns, "@variable", { fg = p.fg_dim })
  hi(ns, "@variable.builtin", { fg = p.purple })
  hi(ns, "@variable.parameter", { fg = p.fg_dim })
  hi(ns, "@variable.member", { fg = p.pink })
  hi(ns, "@constant", { fg = p.purple })
  hi(ns, "@constant.builtin", { fg = p.orange })
  hi(ns, "@constant.macro", { fg = p.pink })
  hi(ns, "@module", { fg = p.teal })
  hi(ns, "@module.builtin", { fg = p.teal })
  hi(ns, "@label", { fg = p.yellow })
  hi(ns, "@string", { fg = p.green })
  hi(ns, "@string.regexp", { fg = p.teal })
  hi(ns, "@string.escape", { fg = p.orange })
  hi(ns, "@string.special", { fg = p.yellow })
  hi(ns, "@character", { fg = p.green })
  hi(ns, "@character.special", { fg = p.orange })
  hi(ns, "@number", { fg = p.orange })
  hi(ns, "@number.float", { link = "@number" })
  hi(ns, "@boolean", { fg = p.purple })
  hi(ns, "@type", { fg = p.teal })
  hi(ns, "@type.builtin", { fg = p.teal })
  hi(ns, "@type.qualifier", { fg = p.blue })
  hi(ns, "@type.definition", { fg = p.teal })
  hi(ns, "@attribute", { fg = p.pink })
  hi(ns, "@property", { fg = p.pink })
  hi(ns, "@function", { fg = p.blue })
  hi(ns, "@function.builtin", { fg = p.orange })
  hi(ns, "@function.call", { fg = p.fg_dim })
  hi(ns, "@function.macro", { fg = p.pink })
  hi(ns, "@method", { fg = p.blue })
  hi(ns, "@method.call", { fg = p.fg_dim })
  hi(ns, "@constructor", { fg = p.yellow })
  hi(ns, "@operator", { fg = p.orange })
  hi(ns, "@keyword", { fg = p.blue })
  hi(ns, "@keyword.function", { fg = p.blue })
  hi(ns, "@keyword.operator", { fg = p.orange })
  hi(ns, "@keyword.return", { fg = p.purple })
  hi(ns, "@keyword.conditional", { fg = p.purple })
  hi(ns, "@keyword.repeat", { fg = p.purple })
  hi(ns, "@keyword.exception", { fg = p.red })
  hi(ns, "@keyword.import", { fg = p.blue })
  hi(ns, "@keyword.storage", { fg = p.orange })
  hi(ns, "@keyword.coroutine", { fg = "NONE", bg = "NONE" })
  hi(ns, "@keyword.directives", { fg = p.pink })
  hi(ns, "@comment", { fg = p.fg_subtle })
  hi(ns, "@comment.documentation", { fg = p.fg_muted })
  hi(ns, "@punctuation", { fg = p.fg_dim })
  hi(ns, "@punctuation.bracket", { fg = p.fg_dim })
  hi(ns, "@punctuation.delimiter", { fg = p.fg_dim })
  hi(ns, "@punctuation.special", { fg = p.orange })
  hi(ns, "@text", { fg = p.fg })
  hi(ns, "@text.strong", { fg = p.fg, bold = true })
  hi(ns, "@text.emphasis", { fg = p.fg, italic = true })
  hi(ns, "@text.underline", { fg = p.blue, underline = true })
  hi(ns, "@text.strike", { strikethrough = true })
  hi(ns, "@text.title", { fg = p.yellow, bold = true })
  hi(ns, "@text.literal", { fg = p.green })
  hi(ns, "@text.quote", { fg = p.fg_subtle })
  hi(ns, "@text.uri", { fg = p.blue, underline = true })
  hi(ns, "@text.math", { fg = p.fg })
  hi(ns, "@text.reference", { fg = p.blue })
  hi(ns, "@text.environment", { fg = p.purple })
  hi(ns, "@text.environment.name", { fg = p.teal })
  hi(ns, "@text.diff.add", { fg = p.green })
  hi(ns, "@text.diff.delete", { fg = p.red })
  hi(ns, "@tag", { fg = p.blue })
  hi(ns, "@tag.attribute", { fg = p.pink })
  hi(ns, "@tag.delimiter", { fg = p.fg_dim })
  hi(ns, "@namespace", { fg = p.teal })

  -- LSP semantic tokens
  hi(ns, "@lsp.type.class", { link = "@type" })
  hi(ns, "@lsp.type.decorator", { link = "@attribute" })
  hi(ns, "@lsp.type.enum", { link = "@type" })
  hi(ns, "@lsp.type.enumMember", { link = "@constant" })
  hi(ns, "@lsp.type.function", { link = "@function" })
  hi(ns, "@lsp.type.interface", { link = "@type" })
  hi(ns, "@lsp.type.macro", { link = "@constant.macro" })
  hi(ns, "@lsp.type.method", { link = "@method" })
  hi(ns, "@lsp.type.namespace", { link = "@module" })
  hi(ns, "@lsp.type.parameter", { link = "@variable.parameter" })
  hi(ns, "@lsp.type.property", { link = "@property" })
  hi(ns, "@lsp.type.struct", { link = "@type" })
  hi(ns, "@lsp.type.type", { link = "@type" })
  hi(ns, "@lsp.type.typeParameter", { link = "@type" })
  hi(ns, "@lsp.type.variable", { link = "@variable" })

  -- Plugins
  -- Telescope
  hi(ns, "TelescopeNormal", { fg = p.fg, bg = p.bg })
  hi(ns, "TelescopeBorder", { fg = p.surface1, bg = p.bg })
  hi(ns, "TelescopePromptNormal", { fg = p.fg, bg = p.bg_alt })
  hi(ns, "TelescopePromptBorder", { fg = p.surface1, bg = p.bg_alt })
  hi(ns, "TelescopePromptTitle", { fg = p.yellow, bg = p.surface0 })
  hi(ns, "TelescopePreviewTitle", { fg = p.green, bg = p.surface0 })
  hi(ns, "TelescopeResultsTitle", { fg = p.blue, bg = p.surface0 })
  hi(ns, "TelescopeMatching", { fg = p.orange, bold = true })
  hi(ns, "TelescopeSelection", { fg = p.fg, bg = p.surface0 })
  hi(ns, "TelescopeSelectionCaret", { fg = p.green })
  hi(ns, "TelescopeMultiIcon", { fg = p.yellow })
  hi(ns, "TelescopeMultiSelection", { fg = p.fg_dim })

  -- nvim-cmp
  hi(ns, "CmpItemAbbr", { fg = p.fg_dim })
  hi(ns, "CmpItemAbbrDeprecated", { fg = p.fg_subtle, strikethrough = true })
  hi(ns, "CmpItemAbbrMatch", { fg = p.fg, bold = true })
  hi(ns, "CmpItemAbbrMatchFuzzy", { fg = p.fg })
  hi(ns, "CmpItemKind", { fg = p.fg_subtle })
  hi(ns, "CmpItemKindClass", { fg = p.teal })
  hi(ns, "CmpItemKindColor", { fg = p.purple })
  hi(ns, "CmpItemKindConstant", { fg = p.orange })
  hi(ns, "CmpItemKindConstructor", { fg = p.yellow })
  hi(ns, "CmpItemKindEnum", { fg = p.teal })
  hi(ns, "CmpItemKindEnumMember", { fg = p.purple })
  hi(ns, "CmpItemKindEvent", { fg = p.orange })
  hi(ns, "CmpItemKindField", { fg = p.pink })
  hi(ns, "CmpItemKindFile", { fg = p.fg_muted })
  hi(ns, "CmpItemKindFolder", { fg = p.yellow })
  hi(ns, "CmpItemKindFunction", { fg = p.blue })
  hi(ns, "CmpItemKindInterface", { fg = p.teal })
  hi(ns, "CmpItemKindKeyword", { fg = p.blue })
  hi(ns, "CmpItemKindMethod", { fg = p.blue })
  hi(ns, "CmpItemKindModule", { fg = p.teal })
  hi(ns, "CmpItemKindOperator", { fg = p.orange })
  hi(ns, "CmpItemKindProperty", { fg = p.pink })
  hi(ns, "CmpItemKindReference", { fg = p.fg_dim })
  hi(ns, "CmpItemKindSnippet", { fg = p.fg_subtle })
  hi(ns, "CmpItemKindStruct", { fg = p.teal })
  hi(ns, "CmpItemKindText", { fg = p.fg_dim })
  hi(ns, "CmpItemKindTypeParameter", { fg = p.teal })
  hi(ns, "CmpItemKindUnit", { fg = p.orange })
  hi(ns, "CmpItemKindValue", { fg = p.orange })
  hi(ns, "CmpItemKindVariable", { fg = p.fg_dim })
  hi(ns, "CmpItemMenu", { fg = p.fg_subtle })

  -- gitsigns
  hi(ns, "GitSignsAdd", { fg = p.green })
  hi(ns, "GitSignsChange", { fg = p.blue })
  hi(ns, "GitSignsDelete", { fg = p.red })
  hi(ns, "GitSignsCurrentLineBlame", { fg = p.fg_subtle })

  -- indent-blankline
  hi(ns, "IndentBlanklineChar", { fg = p.surface1 })
  hi(ns, "IndentBlanklineContextChar", { fg = p.fg_subtle })
  hi(ns, "IndentBlanklineWhitespaceChar", { fg = p.surface0 })

  -- mini.indentscope
  hi(ns, "MiniIndentscopeSymbol", { fg = p.fg_subtle })
  hi(ns, "MiniIndentscopeSymbolOff", { fg = p.surface1 })

  -- which-key
  hi(ns, "WhichKey", { fg = p.blue })
  hi(ns, "WhichKeyGroup", { fg = p.teal })
  hi(ns, "WhichKeyDesc", { fg = p.fg_dim })
  hi(ns, "WhichKeySeparator", { fg = p.fg_subtle })
  hi(ns, "WhichKeyFloat", { bg = p.bg_alt })
  hi(ns, "WhichKeyValue", { fg = p.purple })

  -- hop
  hi(ns, "HopNextKey", { fg = p.yellow, bold = true })
  hi(ns, "HopNextKey1", { fg = p.blue })
  hi(ns, "HopNextKey2", { fg = p.teal })
  hi(ns, "HopUnmatched", { fg = p.fg_subtle })

  -- notify
  hi(ns, "NotifyERRORBorder", { fg = p.red })
  hi(ns, "NotifyWARNBorder", { fg = p.yellow })
  hi(ns, "NotifyINFOBorder", { fg = p.blue })
  hi(ns, "NotifyDEBUGBorder", { fg = p.fg_subtle })
  hi(ns, "NotifyTRACEBorder", { fg = p.purple })
  hi(ns, "NotifyERRORIcon", { link = "NotifyERRORBorder" })
  hi(ns, "NotifyWARNIcon", { link = "NotifyWARNBorder" })
  hi(ns, "NotifyINFOIcon", { link = "NotifyINFOBorder" })
  hi(ns, "NotifyDEBUGIcon", { link = "NotifyDEBUGBorder" })
  hi(ns, "NotifyTRACEIcon", { link = "NotifyTRACEBorder" })

  -- nvim-tree / neo-tree
  hi(ns, "NvimTreeFolderIcon", { fg = p.blue })
  hi(ns, "NvimTreeFolderName", { fg = p.blue })
  hi(ns, "NvimTreeOpenedFolderName", { fg = p.blue, bold = true })
  hi(ns, "NvimTreeEmptyFolderName", { fg = p.fg_subtle })
  hi(ns, "NvimTreeRootFolder", { fg = p.yellow, bold = true })
  hi(ns, "NvimTreeGitDirty", { fg = p.blue })
  hi(ns, "NvimTreeGitStaged", { fg = p.green })
  hi(ns, "NvimTreeGitMerge", { fg = p.orange })
  hi(ns, "NvimTreeGitRenamed", { fg = p.purple })
  hi(ns, "NvimTreeGitNew", { fg = p.green })
  hi(ns, "NvimTreeGitDeleted", { fg = p.red })

  -- Lualink
  hi(ns, "WinBar", { fg = p.fg_dim, bg = p.bg })
  hi(ns, "WinBarNC", { fg = p.fg_subtle, bg = p.bg })

  -- Terminal colors
  vim.g.terminal_color_0  = p.ansi.black
  vim.g.terminal_color_1  = p.ansi.red
  vim.g.terminal_color_2  = p.ansi.green
  vim.g.terminal_color_3  = p.ansi.yellow
  vim.g.terminal_color_4  = p.ansi.blue
  vim.g.terminal_color_5  = p.ansi.magenta
  vim.g.terminal_color_6  = p.ansi.cyan
  vim.g.terminal_color_7  = p.ansi.white
  vim.g.terminal_color_8  = p.ansi.black_bright
  vim.g.terminal_color_9  = p.ansi.red_bright
  vim.g.terminal_color_10 = p.ansi.green_bright
  vim.g.terminal_color_11 = p.ansi.yellow_bright
  vim.g.terminal_color_12 = p.ansi.blue_bright
  vim.g.terminal_color_13 = p.ansi.magenta_bright
  vim.g.terminal_color_14 = p.ansi.cyan_bright
  vim.g.terminal_color_15 = p.ansi.white_bright
end

return M