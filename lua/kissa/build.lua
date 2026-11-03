-- Generate all extras/ ports from palette definitions
-- Usage: nvim --headless -u NORC --cmd "set rtp+=." -c "lua require('kissa.build').run()" -c "qa"

local colors = require("kissa.colors")
local M = {}

local function write(path, content)
  local dir = vim.fn.fnamemodify(path, ":h")
  vim.fn.mkdir(dir, "p")
  local f = io.open(path, "w")
  f:write(content)
  f:close()
  print("  wrote " .. path)
end

local function hex_to_rgb(hex)
  hex = hex:gsub("^#", "")
  return tonumber(hex:sub(1,2), 16), tonumber(hex:sub(3,4), 16), tonumber(hex:sub(5,6), 16)
end

local function hex_to_rgb_float(hex)
  local r, g, b = hex_to_rgb(hex)
  return string.format("%.5f", r/255), string.format("%.5f", g/255), string.format("%.5f", b/255)
end

function M.ghostty(p, name)
  local lines = {
    "# " .. name .. " - " .. p.variant .. " theme for Ghostty",
    "# Place in ~/.config/ghostty/themes/" .. name:lower(),
    "",
  }
  local ansi_order = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }
  local bright_order = { "black_bright", "red_bright", "green_bright", "yellow_bright", "blue_bright", "magenta_bright", "cyan_bright", "white_bright" }
  for i, key in ipairs(ansi_order) do
    table.insert(lines, string.format("palette = %d=%s", i - 1, p.ansi[key]))
  end
  for i, key in ipairs(bright_order) do
    table.insert(lines, string.format("palette = %d=%s", i + 7, p.ansi[key]))
  end
  table.insert(lines, string.format("palette = %d=%s", 16, p.orange))
  table.insert(lines, string.format("palette = %d=%s", 17, p.pink))
  table.insert(lines, string.format("palette = %d=%s", 18, p.bg_alt))
  table.insert(lines, string.format("palette = %d=%s", 19, p.surface0))
  table.insert(lines, string.format("palette = %d=%s", 20, p.fg_muted))
  table.insert(lines, string.format("palette = %d=%s", 21, p.fg_dim))
  if p.terminal_256 then
    table.insert(lines, "")
    table.insert(lines, "# Warm replacements for the xterm 256-color grays.")
    for _, entry in ipairs(p.terminal_256) do
      table.insert(lines, string.format("palette = %d=%s", entry[1], entry[2]))
    end
  end
  table.insert(lines, "")
  table.insert(lines, "background = " .. p.bg)
  table.insert(lines, "foreground = " .. p.fg)
  table.insert(lines, "cursor-color = " .. p.fg)
  local sel_bg = p.variant == "dark" and p.fg or p.surface0
  local sel_fg = p.variant == "dark" and p.bg or p.fg
  table.insert(lines, "selection-background = " .. sel_bg)
  table.insert(lines, "selection-foreground = " .. sel_fg)
  return table.concat(lines, "\n")
end

function M.kitty(p, name)
  local lines = {
    "# " .. name .. " - " .. p.variant .. " theme for Kitty",
    "",
    "background " .. p.bg,
    "foreground " .. p.fg,
    "selection_background " .. (p.variant == "dark" and p.fg or p.surface0),
    "selection_foreground " .. (p.variant == "dark" and p.bg or p.fg),
    "",
    "cursor " .. p.fg,
    "cursor_text_color " .. p.bg,
    "",
    "url_color " .. p.fg_muted,
    "",
    "active_border_color " .. p.fg_subtle,
    "inactive_border_color " .. p.bg_alt,
    "",
    "tab_bar_background " .. p.bg,
    "active_tab_background " .. p.surface0,
    "active_tab_foreground " .. p.fg,
    "inactive_tab_background " .. p.bg_alt,
    "inactive_tab_foreground " .. p.fg_dim,
    "",
  }
  local ansi_order = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }
  local bright_order = { "black_bright", "red_bright", "green_bright", "yellow_bright", "blue_bright", "magenta_bright", "cyan_bright", "white_bright" }
  for i, key in ipairs(ansi_order) do
    table.insert(lines, string.format("color%d %s", i - 1, p.ansi[key]))
  end
  table.insert(lines, "")
  for i, key in ipairs(bright_order) do
    table.insert(lines, string.format("color%d %s", i + 7, p.ansi[key]))
  end
  table.insert(lines, "")
  table.insert(lines, string.format("color16 %s", p.orange))
  table.insert(lines, string.format("color17 %s", p.pink))
  if p.terminal_256 then
    table.insert(lines, "")
    for _, entry in ipairs(p.terminal_256) do
      table.insert(lines, string.format("color%d %s", entry[1], entry[2]))
    end
  end
  return table.concat(lines, "\n")
end

function M.alacritty(p, name)
  local lines = {
    "# " .. name .. " - " .. p.variant .. " theme for Alacritty",
    "",
    "[colors.primary]",
    "background = '0x" .. p.bg:gsub("#","") .. "'",
    "foreground = '0x" .. p.fg:gsub("#","") .. "'",
    "",
    "[colors.cursor]",
    "text = '0x" .. p.bg:gsub("#","") .. "'",
    "cursor = '0x" .. p.fg:gsub("#","") .. "'",
    "",
    "[colors.normal]",
  }
  local ansi_order = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }
  local ansi_names = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }
  for i, key in ipairs(ansi_order) do
    table.insert(lines, string.format("%-10s = '0x%s'", ansi_names[i], p.ansi[key]:gsub("#","")))
  end
  table.insert(lines, "")
  table.insert(lines, "[colors.bright]")
  local bright_order = { "black_bright", "red_bright", "green_bright", "yellow_bright", "blue_bright", "magenta_bright", "cyan_bright", "white_bright" }
  local bright_names = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }
  for i, key in ipairs(bright_order) do
    table.insert(lines, string.format("%-10s = '0x%s'", bright_names[i], p.ansi[key]:gsub("#","")))
  end
  if p.terminal_256 then
    table.insert(lines, "")
    table.insert(lines, "[colors.indexed]")
    for _, entry in ipairs(p.terminal_256) do
      table.insert(lines, string.format("%d = '0x%s'", entry[1], entry[2]:gsub("#","")))
    end
  end
  return table.concat(lines, "\n")
end

function M.wezterm(p, name)
  local lines = {
    "# " .. name .. " - " .. p.variant .. " theme for WezTerm",
    "",
    "[colors]",
    "background = \"" .. p.bg .. "\"",
    "foreground = \"" .. p.fg .. "\"",
    "",
    "cursor_bg = \"" .. p.fg .. "\"",
    "cursor_border = \"" .. p.fg .. "\"",
    "cursor_fg = \"" .. p.bg .. "\"",
    "",
    "selection_bg = \"" .. (p.variant == "dark" and p.fg or p.surface0) .. "\"",
    "selection_fg = \"" .. (p.variant == "dark" and p.bg or p.fg) .. "\"",
    "",
    "ansi = [",
  }
  local ansi_order = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }
  for _, key in ipairs(ansi_order) do
    table.insert(lines, "  \"" .. p.ansi[key] .. "\",")
  end
  table.insert(lines, "]")
  table.insert(lines, "")
  table.insert(lines, "brights = [")
  local bright_order = { "black_bright", "red_bright", "green_bright", "yellow_bright", "blue_bright", "magenta_bright", "cyan_bright", "white_bright" }
  for _, key in ipairs(bright_order) do
    table.insert(lines, "  \"" .. p.ansi[key] .. "\",")
  end
  table.insert(lines, "]")
  table.insert(lines, "")
  table.insert(lines, "[colors.indexed]")
  table.insert(lines, "16 = \"" .. p.orange .. "\"")
  table.insert(lines, "17 = \"" .. p.pink .. "\"")
  if p.terminal_256 then
    for _, entry in ipairs(p.terminal_256) do
      table.insert(lines, string.format("%d = \"%s\"", entry[1], entry[2]))
    end
  end
  return table.concat(lines, "\n")
end

function M.foot(p, name)
  local section = p.variant == "dark" and "colors-dark" or "colors-light"
  local lines = {
    "# " .. name .. " - " .. p.variant .. " theme for Foot",
    "# Include in foot.ini: include=/path/to/" .. name:lower() .. ".ini",
    "",
    "initial-color-theme=" .. p.variant,
    "",
    "[" .. section .. "]",
  }
  local ansi_order = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }
  local bright_order = { "black_bright", "red_bright", "green_bright", "yellow_bright", "blue_bright", "magenta_bright", "cyan_bright", "white_bright" }
  local normal_names = { "regular0", "regular1", "regular2", "regular3", "regular4", "regular5", "regular6", "regular7" }
  local bright_names = { "bright0", "bright1", "bright2", "bright3", "bright4", "bright5", "bright6", "bright7" }
  table.insert(lines, "foreground=" .. p.fg:gsub("#",""))
  table.insert(lines, "background=" .. p.bg:gsub("#",""))
  for i, key in ipairs(ansi_order) do
    table.insert(lines, string.format("%s=%s", normal_names[i], p.ansi[key]:gsub("#","")))
  end
  for i, key in ipairs(bright_order) do
    table.insert(lines, string.format("%s=%s", bright_names[i], p.ansi[key]:gsub("#","")))
  end
  return table.concat(lines, "\n")
end

function M.iterm2(p, name)
  local function rgb_entry(key, hex)
    local r, g, b = hex_to_rgb_float(hex)
    return string.format(
      "\t<key>%s</key>\n\t<dict>\n\t\t<key>Color Space</key>\n\t\t<string>sRGB</string>\n\t\t<key>Red Component</key>\n\t\t<real>%s</real>\n\t\t<key>Green Component</key>\n\t\t<real>%s</real>\n\t\t<key>Blue Component</key>\n\t\t<real>%s</real>\n\t</dict>",
      key, r, g, b
    )
  end
  local ansi_order = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }
  local bright_order = { "black_bright", "red_bright", "green_bright", "yellow_bright", "blue_bright", "magenta_bright", "cyan_bright", "white_bright" }
  local ansi_names = { "Ansi 0", "Ansi 1", "Ansi 2", "Ansi 3", "Ansi 4", "Ansi 5", "Ansi 6", "Ansi 7" }
  local bright_names = { "Ansi 8", "Ansi 9", "Ansi 10", "Ansi 11", "Ansi 12", "Ansi 13", "Ansi 14", "Ansi 15" }
  local lines = {
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">',
    '<plist version="1.0">',
    '<dict>',
  }
  for i, key in ipairs(ansi_order) do
    table.insert(lines, rgb_entry(ansi_names[i], p.ansi[key]))
  end
  for i, key in ipairs(bright_order) do
    table.insert(lines, rgb_entry(bright_names[i], p.ansi[key]))
  end
  table.insert(lines, rgb_entry("Background Color", p.bg))
  table.insert(lines, rgb_entry("Foreground Color", p.fg))
  table.insert(lines, rgb_entry("Bold Color", p.fg))
  table.insert(lines, rgb_entry("Cursor Color", p.fg))
  table.insert(lines, rgb_entry("Cursor Text Color", p.bg))
  table.insert(lines, rgb_entry("Selected Text Color", p.fg))
  table.insert(lines, rgb_entry("Selection Color", p.surface0))
  table.insert(lines, "</dict>")
  table.insert(lines, "</plist>")
  return table.concat(lines, "\n")
end

function M.xresources(p, name)
  local lines = {
    "! " .. name .. " - " .. p.variant .. " theme",
    "! Paste into https://terminal.sexy to preview",
    "",
    "*.foreground: " .. p.fg,
    "*.background: " .. p.bg,
    "*.cursorColor: " .. (p.variant == "dark" and p.yellow or p.blue),
    "*.colorBD: " .. p.fg,
    "",
  }
  local ansi_order = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }
  local bright_order = { "black_bright", "red_bright", "green_bright", "yellow_bright", "blue_bright", "magenta_bright", "cyan_bright", "white_bright" }
  for i, key in ipairs(ansi_order) do
    table.insert(lines, string.format("*.color%d:  %s", i - 1, p.ansi[key]))
  end
  for i, key in ipairs(bright_order) do
    table.insert(lines, string.format("*.color%d:  %s", i + 7, p.ansi[key]))
  end
  if p.terminal_256 then
    for _, entry in ipairs(p.terminal_256) do
      table.insert(lines, string.format("*.color%d:  %s", entry[1], entry[2]))
    end
  end
  return table.concat(lines, "\n")
end

function M.opencode(p)
  local d = p.macchiato
  local l = p.latte
  local tokens = {
    primary            = { d.blue,         l.blue },
    secondary          = { d.fg_muted,     l.fg_muted },
    accent             = { d.yellow,       l.blue },
    error              = { d.red,          l.red },
    warning            = { d.yellow,       l.yellow },
    success            = { d.green,        l.green },
    info               = { d.blue,         l.blue },
    text               = { d.fg,           l.fg },
    textMuted          = { d.fg_subtle,    l.fg_subtle },
    background         = { d.bg,           l.bg },
    backgroundPanel    = { d.bg_alt,       l.bg_alt },
    backgroundElement  = { d.surface0,     l.surface0 },
    border             = { d.surface1,     l.surface1 },
    borderActive       = { d.blue,         l.blue },
    borderSubtle       = { d.surface0,     l.surface0 },
    diffAdded          = { d.green,        l.green },
    diffRemoved        = { d.red,          l.red },
    diffContext        = { d.bg_alt,       l.bg_alt },
    diffHunkHeader     = { d.bg_alt,       l.bg_alt },
    diffHighlightAdded    = { "#2D3A28",   "#B8D4A8" },
    diffHighlightRemoved = { "#3A2222",   "#D4A8A8" },
    diffAddedBg          = { "#2D3A28",   "#D8ECD0" },
    diffRemovedBg        = { "#3A2222",   "#ECD0D0" },
    diffContextBg         = { d.bg_alt,     l.bg_alt },
    diffLineNumber       = { d.fg_subtle,  l.fg_muted },
    diffAddedLineNumberBg    = { "#2D3A28",   "#C8E0B8" },
    diffRemovedLineNumberBg = { "#3A2222",   "#E0B8B8" },
    markdownText         = { d.fg,           l.fg },
    markdownHeading      = { d.blue,         l.blue },
    markdownLink         = { d.teal,         l.teal },
    markdownLinkText     = { d.yellow,       l.yellow },
    markdownCode         = { d.green,        l.green },
    markdownBlockQuote   = { d.fg_subtle,    l.fg_subtle },
    markdownEmph         = { d.purple,       l.purple },
    markdownStrong        = { d.fg_dim,       l.fg_dim },
    markdownHorizontalRule = { d.surface1,    l.surface1 },
    markdownListItem     = { d.fg,           l.fg },
    markdownListEnumeration = { d.fg_subtle, l.fg_muted },
    markdownImage        = { d.teal,         l.teal },
    markdownImageText    = { d.teal,         l.teal },
    markdownCodeBlock    = { d.green,        l.green },
    syntaxComment       = { d.fg_subtle,    l.fg_subtle },
    syntaxKeyword       = { d.blue,         l.blue },
    syntaxFunction       = { d.blue,         l.blue },
    syntaxVariable      = { d.fg_dim,       l.fg_dim },
    syntaxString        = { d.green,        l.green },
    syntaxNumber        = { d.orange,        l.orange },
    syntaxType          = { d.teal,          l.teal },
    syntaxOperator      = { d.orange,        l.orange },
    syntaxPunctuation   = { d.fg_dim,       l.fg_dim },
    syntaxConstant      = { d.purple,        l.purple },
  }
  local lines = {
    '{',
    '  "$schema": "https://opencode.ai/theme.json",',
    '  "theme": {',
  }
  local keys = {}
  for k in pairs(tokens) do table.insert(keys, k) end
  table.sort(keys)
  for i, k in ipairs(keys) do
    local v = tokens[k]
    local comma = i < #keys and "," or ""
    table.insert(lines, string.format('    "%s": { "dark": "%s", "light": "%s" }%s', k, v[1], v[2], comma))
  end
  table.insert(lines, '  }')
  table.insert(lines, '}')
  return table.concat(lines, "\n")
end

function M.base16_yaml(p, name, variant_name)
  local full_name = "Kissa " .. name
  local slug = full_name:lower():gsub(" ", "-")
  local lines = {
    "system: \"base16\"",
    "name: \"" .. full_name .. "\"",
    "author: \"rwendell (https://github.com/rwendell/kissa)\"",
    "variant: \"" .. p.variant .. "\"",
    "palette:",
  }
  local base16_map = {
    { "base00", p.bg, "bg" },
    { "base01", p.bg_alt, "bg_alt" },
    { "base02", p.surface0, "surface0" },
    { "base03", p.fg_subtle, "fg_subtle (comments)" },
    { "base04", p.fg_muted, "fg_muted" },
    { "base05", p.fg, "fg" },
    { "base06", p.fg_dim, "fg_dim" },
    { "base07", p.ansi.white_bright, p.variant == "light" and "bright white (dark on light for ANSI 15)" or "bright white" },
    { "base08", p.red, "red" },
    { "base09", p.orange, "orange" },
    { "base0A", p.yellow, "yellow" },
    { "base0B", p.green, "green" },
    { "base0C", p.teal, "teal" },
    { "base0D", p.blue, "blue" },
    { "base0E", p.purple, "purple" },
    { "base0F", p.pink, "pink" },
  }
  for _, item in ipairs(base16_map) do
    table.insert(lines, "  " .. item[1] .. ": \"" .. item[2] .. "\" # " .. item[3])
  end
  table.insert(lines, "")
  return table.concat(lines, "\n")
end

function M.base24_yaml(p, name)
  local full_name = "Kissa " .. name
  local lines = {
    "system: \"base24\"",
    "name: \"" .. full_name .. "\"",
    "author: \"rwendell (https://github.com/rwendell/kissa)\"",
    "variant: \"" .. p.variant .. "\"",
    "palette:",
  }
  local base24_map = {
    { "base00", p.bg, "bg" },
    { "base01", p.bg_alt, "bg_alt" },
    { "base02", p.surface0, "surface0" },
    { "base03", p.ansi.black_bright, "bright black (ANSI 8)" },
    { "base04", p.fg_muted, "fg_muted" },
    { "base05", p.fg, "fg" },
    { "base06", p.fg_dim, "fg_dim" },
    { "base07", p.ansi.white_bright, "bright white (ANSI 15)" },
    { "base08", p.red, "red" },
    { "base09", p.orange, "orange (ANSI 16)" },
    { "base0A", p.yellow, "yellow" },
    { "base0B", p.green, "green" },
    { "base0C", p.teal, "teal" },
    { "base0D", p.blue, "blue" },
    { "base0E", p.purple, "purple" },
    { "base0F", p.pink, "pink (ANSI 17)" },
    { "base10", p.bg10, p.variant == "dark" and "darker background" or "lighter background" },
    { "base11", p.bg11, p.variant == "dark" and "darkest background" or "lightest background" },
    { "base12", p.ansi.red_bright, "bright red (ANSI 9)" },
    { "base13", p.ansi.yellow_bright, "bright yellow (ANSI 11)" },
    { "base14", p.ansi.green_bright, "bright green (ANSI 10)" },
    { "base15", p.ansi.cyan_bright, "bright cyan (ANSI 14)" },
    { "base16", p.ansi.blue_bright, "bright blue (ANSI 12)" },
    { "base17", p.ansi.magenta_bright, "bright magenta (ANSI 13)" },
  }
  for _, item in ipairs(base24_map) do
    table.insert(lines, "  " .. item[1] .. ": \"" .. item[2] .. "\" # " .. item[3])
  end
  table.insert(lines, "")
  return table.concat(lines, "\n")
end

function M.run()
  local root = vim.fn.getcwd()
  local extras = root .. "/extras"

  for _, variant in ipairs(colors.variants) do
    local p = colors.palettes[variant]
    local name = variant == "macchiato" and "Macchiato" or "Latte"
    local vname = variant:sub(1,1):upper() .. variant:sub(2)

    write(extras .. "/ghostty/" .. variant .. ".theme", M.ghostty(p, name))
    write(extras .. "/kitty/" .. variant .. ".conf", M.kitty(p, name))
    write(extras .. "/alacritty/" .. variant .. ".toml", M.alacritty(p, name))
    write(extras .. "/wezterm/" .. variant .. ".toml", M.wezterm(p, name))
    write(extras .. "/foot/" .. variant .. ".ini", M.foot(p, name))
    write(extras .. "/iterm2/" .. variant .. ".itermcolors", M.iterm2(p, name))
    write(extras .. "/xresources/" .. variant .. ".Xresources", M.xresources(p, name))
  end

  -- OpenCode theme (combined dark+light)
  write(extras .. "/opencode/kissa.json", M.opencode(colors.palettes, "Kissa"))

  -- Base16 YAML files
  for _, variant in ipairs(colors.variants) do
    local p = colors.palettes[variant]
    local name = variant == "macchiato" and "Macchiato" or "Latte"
    write(root .. "/base16/kissa-" .. variant .. ".yaml", M.base16_yaml(p, name, variant))
  end

  -- Base24 YAML files
  for _, variant in ipairs(colors.variants) do
    local p = colors.palettes[variant]
    local name = variant == "macchiato" and "Macchiato" or "Latte"
    write(root .. "/base24/kissa-" .. variant .. ".yaml", M.base24_yaml(p, name))
  end

  -- TOML palettes
  for _, variant in ipairs(colors.variants) do
    local p = colors.palettes[variant]
    local lines = {
      "name = \"" .. (variant == "macchiato" and "Macchiato" or "Latte") .. "\"",
      "variant = \"" .. p.variant .. "\"",
      "",
    }
    local sections = {
      { "colors", { "bg", "bg_alt", "surface0", "surface1", "surface2", "fg", "fg_dim", "fg_muted", "fg_subtle", "red", "orange", "yellow", "green", "teal", "blue", "purple", "pink" } },
      { "terminal", { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white", "black_bright", "red_bright", "green_bright", "yellow_bright", "blue_bright", "magenta_bright", "cyan_bright", "white_bright" } },
    }
    for _, section in ipairs(sections) do
      local section_name, keys = section[1], section[2]
      table.insert(lines, "[" .. section_name .. "]")
      for _, k in ipairs(keys) do
        local value = section_name == "terminal" and p.ansi[k] or p[k]
        table.insert(lines, k .. " = \"" .. value .. "\"")
      end
      table.insert(lines, "")
    end
    if p.terminal_256 then
      table.insert(lines, "[terminal.256]")
      for _, entry in ipairs(p.terminal_256) do
        table.insert(lines, string.format("%d = \"%s\"", entry[1], entry[2]))
      end
      table.insert(lines, "")
    end
    write(root .. "/palette/" .. variant .. ".toml", table.concat(lines, "\n"))
  end

  print("Done! All extras generated.")
end

return M