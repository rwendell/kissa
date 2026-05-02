local colors = require("kissa.colors")

local function get_variant()
	return vim.g.kissa_variant or (vim.o.background == "light" and "latte" or "macchiato")
end

local function theme()
	local p = colors.palettes[get_variant()]
	return {
		normal = {
			a = { bg = p.blue, fg = p.bg, gui = "bold" },
			b = { bg = p.bg_alt, fg = p.fg_dim },
			c = { bg = p.bg_alt, fg = p.fg_dim },
		},
		insert = {
			a = { bg = p.green, fg = p.bg, gui = "bold" },
			b = { bg = p.bg_alt, fg = p.fg_dim },
			c = { bg = p.bg_alt, fg = p.fg_dim },
		},
		visual = {
			a = { bg = p.purple, fg = p.bg, gui = "bold" },
			b = { bg = p.bg_alt, fg = p.fg_dim },
			c = { bg = p.bg_alt, fg = p.fg_dim },
		},
		replace = {
			a = { bg = p.orange, fg = p.bg, gui = "bold" },
			b = { bg = p.bg_alt, fg = p.fg_dim },
			c = { bg = p.bg_alt, fg = p.fg_dim },
		},
		command = {
			a = { bg = p.teal, fg = p.bg, gui = "bold" },
			b = { bg = p.bg_alt, fg = p.fg_dim },
			c = { bg = p.bg_alt, fg = p.fg_dim },
		},
		inactive = {
			a = { bg = p.bg_alt, fg = p.fg_subtle },
			b = { bg = p.bg_alt, fg = p.fg_subtle },
			c = { bg = p.bg, fg = p.fg_subtle },
		},
	}
end

return theme