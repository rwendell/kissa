local M = {}

M.variants = { "macchiato", "latte" }

function M.setup(opts)
  opts = opts or {}
  require("macchiato.highlights").setup(opts)
end

function M.colors()
  local variant = vim.g.macchiato_variant or "macchiato"
  return require("macchiato.colors").palettes[variant]
end

return M