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
      black_bright   = "#5D5B57",
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
    -- bright variants
    red_bright    = "#B85555",
    green_bright  = "#509058",
    yellow_bright = "#968232",
    blue_bright   = "#4C80BE",
    purple_bright = "#7E52BA",
    teal_bright   = "#388888",
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
      red_bright      = "#B85555",
      green_bright    = "#509058",
      yellow_bright   = "#968232",
      blue_bright     = "#4C80BE",
      magenta_bright  = "#7E52BA",
      cyan_bright     = "#388888",
      white_bright    = "#FEFCFA",
    },
  },
}

return M