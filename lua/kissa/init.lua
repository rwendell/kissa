local M = {}

M.variants = { "macchiato", "latte" }

local augroup = vim.api.nvim_create_augroup("kissa", { clear = true })

local function resolve_variant(opts)
  opts = opts or {}
  if opts.variant and opts.variant ~= "auto" then
    return opts.variant
  end
  return vim.o.background == "light" and "latte" or "macchiato"
end

function M.setup(opts)
  opts = opts or {}
  local variant = resolve_variant(opts)

  require("kissa.highlights").setup({ variant = variant })

  local ok, lualine = pcall(require, "lualine")
  if ok then
    lualine.setup({ options = { theme = "kissa" } })
  end

  if opts.variant == "auto" or (not opts.variant and not vim.g.kissa_variant) then
    vim.api.nvim_create_autocmd("OptionSet", {
      group = augroup,
      pattern = "background",
      callback = function()
        local new_variant = vim.o.background == "light" and "latte" or "macchiato"
        if new_variant ~= vim.g.kissa_variant then
          require("kissa.highlights").setup({ variant = new_variant })
          local ok2, lualine2 = pcall(require, "lualine")
          if ok2 then
            lualine2.setup({ options = { theme = "kissa" } })
          end
        end
      end,
    })
  end
end

function M.colors()
  local variant = vim.g.kissa_variant or "macchiato"
  return require("kissa.colors").palettes[variant]
end

return M