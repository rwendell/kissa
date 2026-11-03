-- Single source of truth for all Macchiato/Latte palette colors
-- All other formats are generated from these definitions.

local M = {}

M.variants = { "macchiato", "latte" }

M.palettes = {
  macchiato = {
    variant  = "dark",
    bg       = "#1F1C16",
    bg_alt   = "#35322D",
    surface0 = "#47443F",
    surface1 = "#5D5B57",
    surface2 = "#6D6B68",
    -- Base24 background variants (progressive darker surfaces)
    bg10     = "#17140F",
    bg11     = "#100E0A",
    fg       = "#FAF0E6",
    fg_dim   = "#E8D5B7",
    fg_muted = "#D4C4A8",
    fg_subtle = "#B8A48C",
    red      = "#E87777",
    orange   = "#DA9050",
    yellow   = "#EAC67A",
    green    = "#8CB870",
    teal     = "#6AB8B0",
    blue     = "#7FA8D4",
    purple   = "#B094CC",
    pink     = "#CC88AA",
    -- bright variants
    red_bright    = "#F09090",
    green_bright  = "#A8D488",
    yellow_bright = "#F0D48C",
    blue_bright   = "#98BCE6",
    purple_bright = "#C4ACE0",
    teal_bright   = "#84CCC4",
    -- terminal ANSI mapping
    ansi = {
      black   = "#1F1C16",
      red     = "#E87777",
      green   = "#8CB870",
      yellow  = "#EAC67A",
      blue    = "#7FA8D4",
      magenta = "#B094CC",
      cyan    = "#6AB8B0",
      white   = "#B8A48C",
      black_bright   = "#6D6B68",
      red_bright      = "#F09090",
      green_bright    = "#A8D488",
      yellow_bright   = "#F0D48C",
      blue_bright     = "#98BCE6",
      magenta_bright  = "#C4ACE0",
      cyan_bright     = "#84CCC4",
      white_bright    = "#FEF4E4",
    },
  },

  latte = {
    variant  = "light",
    bg       = "#F5F4F0",
    bg_alt   = "#E8E7E3",
    surface0 = "#D5D2CB",
    surface1 = "#C5C0B8",
    surface2 = "#B5AFA6",
    -- Base24 background variants (progressive lighter surfaces)
    bg10     = "#FAF9F6",
    bg11     = "#FEFCFA",
    fg       = "#1F1C16",
    fg_dim   = "#6E6459",
    fg_muted = "#746C62",
    fg_subtle = "#91887D",
    red      = "#9E3E3E",
    orange   = "#8F5D22",
    yellow   = "#7D6820",
    green    = "#387050",
    teal     = "#287070",
    blue     = "#3468A8",
    purple   = "#6438A0",
    pink     = "#943A68",
    -- bright variants (darker than the normals: on a light background,
    -- "bright" means more contrast, not more lightness)
    red_bright    = "#8A3030",
    green_bright  = "#2E5E42",
    yellow_bright = "#6A5715",
    blue_bright   = "#29578E",
    purple_bright = "#552F8A",
    teal_bright   = "#1F5E5E",
    -- terminal ANSI mapping
    ansi = {
      black   = "#1F1C16",
      red     = "#9E3E3E",
      green   = "#387050",
      yellow  = "#7D6820",
      blue    = "#3468A8",
      magenta = "#6438A0",
      cyan    = "#287070",
      white   = "#746C62",
      black_bright   = "#6E6459",
      red_bright      = "#8A3030",
      green_bright    = "#2E5E42",
      yellow_bright   = "#6A5715",
      blue_bright     = "#29578E",
      magenta_bright  = "#552F8A",
      cyan_bright     = "#1F5E5E",
      white_bright    = "#1F1C16",
    },
    -- High end of xterm's 256-color grayscale ramp. The stock values are
    -- neutral and tuned for dark backgrounds; use warm browns so TUI text
    -- stays on-palette and readable on the light background.
    terminal_256 = {
      { 250, "#6E6459" },
      { 251, "#5C5044" },
      { 252, "#3A2F24" },
      { 253, "#332B21" },
      { 254, "#2A241C" },
      { 255, "#1F1C16" },
    },
  },
}

return M