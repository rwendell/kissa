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

-- ── OpenCode v2 theme ────────────────────────────────────────────────────────
-- OpenCode 2 reads themes from {"base": …, "light": …, "dark": …}. Each mode
-- carries a nine-step hue scale plus optional token overrides on top of base.
-- The canonical palette color sits at step 400, which is where the semantic
-- layer and the built-in themes expect the main accent.

local function clamp(v, lo, hi)
  if v < lo then return lo elseif v > hi then return hi else return v end
end

local function to_linear(c)
  return c <= 0.04045 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
end

local function from_linear(c)
  return c <= 0.0031308 and c * 12.92 or 1.055 * c ^ 0.4166666666666667 - 0.055
end

local function hex_to_oklch(hex)
  hex = hex:gsub("^#", "")
  local r, g, b = tonumber(hex:sub(1,2), 16), tonumber(hex:sub(3,4), 16), tonumber(hex:sub(5,6), 16)
  r, g, b = to_linear(r/255), to_linear(g/255), to_linear(b/255)
  local l = 0.4122214708*r + 0.5363325363*g + 0.0514459929*b
  local m = 0.2119034982*r + 0.6806995451*g + 0.1073969566*b
  local s = 0.0883024619*r + 0.2817188376*g + 0.6299787005*b
  l, m, s = l^(1/3), m^(1/3), s^(1/3)
  local L = 0.2104542553*l + 0.7936177850*m - 0.0040720468*s
  local A = 1.9779984951*l - 2.4285922050*m + 0.4505937099*s
  local B = 0.0259040371*l + 0.7827717662*m - 0.8086757660*s
  return L, math.sqrt(A*A + B*B), math.atan2(B, A)
end

local function oklch_to_hex(L, C, H)
  local a, b = C * math.cos(H), C * math.sin(H)
  local l = (L + 0.3963377774*a + 0.2158037573*b) ^ 3
  local m = (L - 0.1055613458*a - 0.0638541728*b) ^ 3
  local s = (L - 0.0894841775*a - 1.2914855480*b) ^ 3
  local r =  4.0767416621*l - 3.3077115913*m + 0.2309699292*s
  local g = -1.2684380046*l + 2.6097574011*m - 0.3413193965*s
  local bb = -0.0041960863*l - 0.7034186147*m + 1.7076147010*s
  local function to_hex(c)
    return string.format("%02X", math.floor(clamp(from_linear(clamp(c, 0, 1)), 0, 1) * 255 + 0.5))
  end
  return "#" .. to_hex(r) .. to_hex(g) .. to_hex(bb)
end

-- Nine-step scale for one hue. Steps away from 400 move toward the mode's
-- text or background lightness while losing chroma, so the ramp keeps the
-- palette's hue angle instead of crossing into neighbouring hues.
local function hue_ramp(hex, variant)
  local L, C, H = hex_to_oklch(hex)
  local dark = variant == "dark"
  local steps = {}
  for _, step in ipairs({ 100, 200, 300, 400, 500, 600, 700, 800, 900 }) do
    if step == 400 then
      steps[step] = hex
    else
      local t = math.abs(step - 400) / 500
      local target
      if step < 400 then
        target = dark and 0.97 or 0.22
        t = math.min(1, t * 1.15)
      else
        target = dark and 0.18 or 0.98
        t = math.min(1, t * 0.9)
      end
      steps[step] = oklch_to_hex(L + (target - L) * t, C * (1 - 0.5 * (math.abs(step - 400) / 500)), H)
    end
  end
  return steps
end

-- Minimal ordered JSON writer: { __kind = "obj", pairs = { {key, value}, … } }
-- and { __kind = "arr", items = { … } } keep the generated file stable.
local function obj(pairs) return { __kind = "obj", pairs = pairs } end
local function arr(items) return { __kind = "arr", items = items } end

local function json(value, indent)
  indent = indent or ""
  local kind = type(value) == "table" and value.__kind
  if kind == "arr" then
    local parts = {}
    for _, item in ipairs(value.items) do
      table.insert(parts, json(item, indent .. "  "))
    end
    return "[\n" .. indent .. "  " .. table.concat(parts, ",\n" .. indent .. "  ") .. "\n" .. indent .. "]"
  elseif kind == "obj" then
    local parts = {}
    for _, pair in ipairs(value.pairs) do
      table.insert(parts, string.format('%s  "%s": %s', indent, pair[1], json(pair[2], indent .. "  ")))
    end
    return "{\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "}"
  elseif type(value) == "string" then
    return '"' .. value .. '"'
  end
  error("cannot encode " .. type(value))
end

local function neutral_scale(p)
  return obj({
    { "100", p.fg },
    { "200", p.fg_dim },
    { "300", p.fg_muted },
    { "400", p.fg_subtle },
    { "500", p.surface2 },
    { "600", p.surface1 },
    { "700", p.surface0 },
    { "800", p.bg_alt },
    { "900", p.bg },
  })
end

local function hue_block(p)
  local function scale(key)
    return obj((function()
      local out = {}
      for _, step in ipairs({ 100, 200, 300, 400, 500, 600, 700, 800, 900 }) do
        table.insert(out, { tostring(step), hue_ramp(p[key], p.variant)[step] })
      end
      return out
    end)())
  end
  return obj({
    { "gray", neutral_scale(p) },
    { "red", scale("red") },
    { "orange", scale("orange") },
    { "yellow", scale("yellow") },
    { "green", scale("green") },
    -- Kissa calls this hue teal; OpenCode's standard scale name is cyan.
    { "cyan", scale("teal") },
    { "blue", scale("blue") },
    { "purple", scale("purple") },
    { "pink", scale("pink") },
    -- Macchiato's accent is yellow; Latte's is blue (yellow is too pale on
    -- #F5F4F0 to carry an accent role at AA).
    { "accent", p.variant == "dark" and "$hue.yellow" or "$hue.blue" },
    { "interactive", "$hue.blue" },
    { "neutral", "$hue.gray" },
  })
end

local function diff_block(p)
  return obj({
    { "text", obj({
      { "added", "$hue.green.400" },
      { "removed", "$hue.red.400" },
      -- Context text and line numbers are readable text, not chrome:
      -- Latte uses fg_muted so they clear AA on bg_alt.
      { "context", p.variant == "light" and "$hue.neutral.300" or "$hue.neutral.400" },
      { "hunkHeader", "$hue.blue.400" },
    }) },
    { "background", obj({
      { "added", p.diff_add_bg },
      { "removed", p.diff_remove_bg },
      -- Context lines keep the plain background so context text clears AA
      -- without darkening the neutral used for added/removed fills.
      { "context", "$background.base" },
    }) },
    -- Highlight is the +/- sign itself, so it uses the diff text colors.
    { "highlight", obj({
      { "added", "$hue.green.400" },
      { "removed", "$hue.red.400" },
    }) },
    { "lineNumber", obj({
      { "text", p.variant == "light" and "$hue.neutral.300" or "$hue.neutral.400" },
      -- The gutter stays untinted; line fills and +/- signs carry the state.
      { "background", obj({
        { "added", "$background.base" },
        { "removed", "$background.base" },
      }) },
    }) },
  })
end

local function mode_tokens(p)
  local light = p.variant == "light"
  local text = {
    -- OpenCode renders reasoning text with muted, and menus render it on
    -- background.raised.base. Latte's fg_muted only reaches 4.18:1 there,
    -- so light mode steps up to fg_dim; Macchiato uses fg_subtle.
    { "muted", light and "$hue.neutral.200" or "$hue.neutral.400" },
  }
  if not light then
    -- Plain red is 4.46:1 on raised panels in dark mode; the bright ANSI red
    -- is part of the palette and clears AA there (5.53:1).
    table.insert(text, { "feedback", obj({
      { "error", obj({ { "base", p.red_bright } }) },
    }) })
  end
  return obj({
    { "hue", hue_block(p) },
    { "text", obj(text) },
    { "diff", diff_block(p) },
    { "markdown", obj({
      { "blockQuote", light and "$hue.neutral.300" or "$hue.neutral.400" },
      { "listEnumeration", light and "$hue.neutral.300" or "$hue.neutral.400" },
    }) },
  })
end

function M.opencode(p)
  local d = p.macchiato
  local base = obj({
    { "categorical", arr({ "blue", "purple", "cyan", "green", "orange", "red", "pink" }) },
    { "text", obj({
      { "base", "$hue.neutral.100" },
      { "muted", "$hue.neutral.300" },
      { "action", obj({
        { "primary", obj({
          { "base", "$text.base" },
          { "$selected", "$hue.interactive.400" },
          { "$disabled", "$hue.neutral.300" },
        }) },
        { "secondary", obj({
          { "base", "$text.muted" },
          { "$hovered", "$text.base" },
        }) },
        { "destructive", obj({
          -- Text on a filled destructive action uses the mode's background,
          -- which is the highest-contrast neutral in both palettes.
          { "base", "$hue.neutral.900" },
          { "$disabled", "$hue.neutral.300" },
        }) },
      }) },
      { "formfield", obj({
        { "base", "$text.base" },
        { "$hovered", "$hue.interactive.400" },
        { "$focused", "$hue.interactive.400" },
        { "$pressed", "$hue.interactive.400" },
        { "$disabled", "$text.muted" },
        { "$selected", "$hue.interactive.400" },
      }) },
      { "feedback", obj({
        { "error", obj({ { "base", "$hue.red.400" } }) },
        { "warning", obj({ { "base", "$hue.yellow.400" } }) },
        { "success", obj({ { "base", "$hue.green.400" } }) },
        { "info", obj({ { "base", "$hue.blue.400" } }) },
      }) },
    }) },
    { "background", obj({
      { "base", "$hue.neutral.900" },
      { "raised", obj({
        { "base", "$hue.neutral.800" },
        { "high", "$hue.neutral.700" },
        { "max", "$hue.neutral.600" },
      }) },
      { "action", obj({
        { "primary", obj({
          { "base", "transparent" },
          { "$hovered", "$hue.neutral.700" },
          { "$focused", "$hue.interactive.600" },
          { "$selected", "transparent" },
        }) },
        { "secondary", obj({ { "base", "transparent" } }) },
        { "destructive", obj({ { "base", "$hue.red.400" } }) },
      }) },
      { "formfield", obj({ { "base", "$background.base" } }) },
      { "feedback", obj({
        { "error", obj({ { "base", "$background.base" } }) },
        { "warning", obj({ { "base", "$background.base" } }) },
        { "success", obj({ { "base", "$background.base" } }) },
        { "info", obj({ { "base", "$background.base" } }) },
      }) },
    }) },
    { "border", obj({ { "base", "$hue.neutral.600" } }) },
    { "scrollbar", obj({ { "base", "$hue.neutral.500" } }) },
    { "diff", diff_block(d) },
    { "syntax", obj({
      { "comment", "$hue.neutral.400" },
      { "keyword", "$hue.blue.400" },
      { "function", "$hue.blue.400" },
      { "variable", "$hue.neutral.200" },
      { "string", "$hue.green.400" },
      { "number", "$hue.orange.400" },
      { "type", "$hue.cyan.400" },
      { "operator", "$hue.orange.400" },
      { "punctuation", "$hue.neutral.200" },
    }) },
    { "markdown", obj({
      { "text", "$hue.neutral.100" },
      { "heading", "$hue.blue.400" },
      { "link", "$hue.cyan.400" },
      { "linkText", "$hue.yellow.400" },
      { "code", "$hue.green.400" },
      { "blockQuote", "$hue.neutral.400" },
      { "emphasis", "$hue.purple.400" },
      { "strong", "$hue.neutral.200" },
      { "horizontalRule", "$hue.neutral.600" },
      { "listItem", "$hue.neutral.100" },
      { "listEnumeration", "$hue.neutral.400" },
      { "image", "$hue.cyan.400" },
      { "imageText", "$hue.cyan.400" },
      { "codeBlock", "$hue.green.400" },
    }) },
    { "@dialog", obj({
      { "text", obj({
        -- fg_muted only clears AA on the base background; dialogs sit on a
        -- raised surface, so step up to fg_dim for muted text and labels.
        { "muted", "$hue.neutral.200" },
        { "action", obj({
          { "secondary", obj({ { "base", "$text.base" } }) },
        }) },
      }) },
      { "background", obj({
        { "base", "$background.raised.base" },
        { "action", obj({
          { "primary", obj({ { "$hovered", "$background.raised.max" } }) },
          { "secondary", obj({ { "$hovered", "$background.raised.max" } }) },
        }) },
      }) },
      { "@footer", obj({
        { "text", obj({ { "muted", "$hue.neutral.200" } }) },
      }) },
    }) },
  })

  return json(obj({
    { "$schema", "https://opencode.ai/theme.json" },
    { "base", base },
    { "light", mode_tokens(p.latte) },
    { "dark", mode_tokens(p.macchiato) },
  })) .. "\n"
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

  -- TOML palettes
  for _, variant in ipairs(colors.variants) do
    local p = colors.palettes[variant]
    local lines = {
      "name = \"" .. (variant == "macchiato" and "Macchiato" or "Latte") .. "\"",
      "variant = \"" .. p.variant .. "\"",
      "",
    }
    local sections = {
      {
        header = "[colors]",
        keys = { "bg", "bg_alt", "surface0", "surface1", "surface2", "fg", "fg_dim", "fg_muted", "fg_subtle", "red", "orange", "yellow", "green", "teal", "blue", "purple", "pink", "diff_add_bg", "diff_remove_bg" },
      },
      {
        header = "[terminal]",
        source = p.ansi,
        keys = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white", "black_bright", "red_bright", "green_bright", "yellow_bright", "blue_bright", "magenta_bright", "cyan_bright", "white_bright" },
      },
    }
    for _, sec in ipairs(sections) do
      table.insert(lines, sec.header)
      local source = sec.source or p
      for _, k in ipairs(sec.keys) do
        table.insert(lines, k .. " = \"" .. source[k] .. "\"")
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