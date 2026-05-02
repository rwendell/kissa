local colors = require("kissa.colors")
local p = colors.palettes[vim.g.kissa_variant or "macchiato"]

return {
	normal = {
		a = { bg = p.surface0, fg = p.fg, gui = "bold" },
		b = { bg = p.bg_alt, fg = p.fg_dim },
		c = { bg = p.bg_alt, fg = p.fg_muted },
	},
	insert = {
		a = { bg = p.surface0, fg = p.orange, gui = "bold" },
		b = { bg = p.bg_alt, fg = p.fg_dim },
		c = { bg = p.bg_alt, fg = p.fg_muted },
	},
	visual = {
		a = { bg = p.surface0, fg = p.yellow, gui = "bold" },
		b = { bg = p.bg_alt, fg = p.fg_dim },
		c = { bg = p.bg_alt, fg = p.fg_muted },
	},
	replace = {
		a = { bg = p.surface0, fg = p.red, gui = "bold" },
		b = { bg = p.bg_alt, fg = p.fg_dim },
		c = { bg = p.bg_alt, fg = p.fg_muted },
	},
	command = {
		a = { bg = p.surface0, fg = p.teal, gui = "bold" },
		b = { bg = p.bg_alt, fg = p.fg_dim },
		c = { bg = p.bg_alt, fg = p.fg_muted },
	},
	inactive = {
		a = { bg = p.bg_alt, fg = p.fg_subtle },
		b = { bg = p.bg_alt, fg = p.fg_subtle },
		c = { bg = p.bg, fg = p.fg_subtle },
	},
}