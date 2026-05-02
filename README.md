# Kissa

/kissa/ · "KEE-sah" · 喫茶 · a Japanese coffee house where craft meets calm

A pair of WCAG AA+ accessible color schemes rooted in espresso brown. **Macchiato** is the dark variant — rich and warm. **Latte** is the light variant — cool paper tones with espresso text. Both share the same core color `#1F1C16`: dark side as background, light side as foreground.

Auto-switches with `set background=` — one colorscheme, two moods.

## Quick Start

### Neovim

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ "rwendell/kissa", lazy = false, priority = 1000 }
```

```vim
" Auto-switches based on 'background':
set background=dark
colorscheme kissa

" Or force a variant:
colorscheme macchiato  " dark
colorscheme latte      " light
```

```lua
-- Or via Lua with options:
require("kissa").setup()           -- auto: macchiato for dark, latte for light
require("kissa").setup({ variant = "macchiato" })  -- force dark
require("kissa").setup({ variant = "latte" })      -- force light
require("kissa").setup({ variant = "auto" })        -- auto-switch on `background` change
```

### Stylix (NixOS)

```nix
stylix.base16Scheme = ./path/to/kissa/base16/macchiato.yaml;
stylix.polarity = "dark";
# or
stylix.base16Scheme = ./path/to/kissa/base16/latte.yaml;
stylix.polarity = "light";
```

### Ghostty

Copy `extras/ghostty/macchiato.theme` (or `latte.theme`) to `~/.config/ghostty/themes/`, then:

```
theme = macchiato
```

For automatic dark/light switching:

```
theme = dark:macchiato,light:latte
```

### Kitty

```ini
include /path/to/kissa/extras/kitty/macchiato.conf
```

### Alacritty

```toml
import = ["/path/to/kissa/extras/alacritty/macchiato.toml"]
```

### WezTerm

Copy `extras/wezterm/macchiato.toml` to `~/.config/wezterm/colors/`, then:

```lua
config.color_scheme = "macchiato"
```

### Foot

```ini
include=/path/to/kissa/extras/foot/macchiato.ini
```

### XResources

Copy `extras/xresources/macchiato.Xresources` and merge with `~/.Xresources`.

## Palette

### Macchiato (dark)

| Color | Hex | Usage |
|-------|-----|-------|
| `bg` | `#1F1C16` | Background |
| `bg_alt` | `#35322D` | Statusline, gutters |
| `surface0` | `#47443F` | Selection, panels |
| `surface1` | `#5D5B57` | Cursor line, folds |
| `surface2` | `#6D6B68` | Dim surfaces |
| `fg` | `#FAF0E6` | Primary text (15.1:1 AAA) |
| `fg_dim` | `#E8D5B7` | Secondary text (11.8:1 AAA) |
| `fg_muted` | `#D4C4A8` | Tertiary text (9.9:1 AAA) |
| `fg_subtle` | `#B8A48C` | Comments (7.1:1 AAA) |
| `red` | `#E87777` | Errors, deletes (5.9:1 AA) |
| `orange` | `#DA9050` | Operators, numbers (6.5:1 AA) |
| `yellow` | `#EAC67A` | Strings, warnings (10.4:1 AAA) |
| `green` | `#8CB870` | Functions, diff-add (7.5:1 AAA) |
| `teal` | `#6AB8B0` | Types, regex (7.4:1 AAA) |
| `blue` | `#7FA8D4` | Keywords, links (6.8:1 AA) |
| `purple` | `#B094CC` | Constants (6.4:1 AA) |
| `pink` | `#CC88AA` | Properties (6.2:1 AA) |

### Latte (light)

| Color | Hex | Usage |
|-------|-----|-------|
| `bg` | `#F5F4F0` | Background |
| `bg_alt` | `#E8E7E3` | Statusline, gutters |
| `surface0` | `#D5D2CB` | Selection, panels |
| `surface1` | `#C5C0B8` | Cursor line, folds |
| `surface2` | `#B5AFA6` | Dim surfaces |
| `fg` | `#1F1C16` | Primary text (15.4:1 AAA) |
| `fg_dim` | `#6E6459` | Secondary text (5.3:1 AA) |
| `fg_muted` | `#746C62` | Tertiary text (4.7:1 AA) |
| `fg_subtle` | `#91887D` | Comments (3.2:1 AA Large) |
| `red` | `#9E3E3E` | Errors, deletes (5.9:1 AA) |
| `orange` | `#8F5D22` | Operators, numbers (5.1:1 AA) |
| `yellow` | `#7D6820` | Strings, warnings (4.9:1 AA) |
| `green` | `#387050` | Functions, diff-add (5.3:1 AA) |
| `teal` | `#287070` | Types, regex (5.2:1 AA) |
| `blue` | `#3468A8` | Keywords, links (5.2:1 AA) |
| `purple` | `#6438A0` | Constants (7.3:1 AAA) |
| `pink` | `#943A68` | Properties (6.2:1 AA) |

## Ports

| Format | Path |
|--------|------|
| Neovim | `colors/macchiato.vim`, `colors/latte.vim` |
| Ghostty | `extras/ghostty/macchiato.theme`, `extras/ghostty/latte.theme` |
| Kitty | `extras/kitty/macchiato.conf`, `extras/kitty/latte.conf` |
| Alacritty | `extras/alacritty/macchiato.toml`, `extras/alacritty/latte.toml` |
| WezTerm | `extras/wezterm/macchiato.toml`, `extras/wezterm/latte.toml` |
| Foot | `extras/foot/macchiato.ini`, `extras/foot/latte.ini` |
| iTerm2 | `extras/iterm2/macchiato.itermcolors`, `extras/iterm2/latte.itermcolors` |
| XResources | `extras/xresources/macchiato.Xresources`, `extras/xresources/latte.Xresources` |
| OpenCode | `extras/opencode/kissa.json` |
| Base16 | `base16/macchiato.yaml`, `base16/latte.yaml` |
| Palette TOML | `colors/macchiato.toml`, `colors/latte.toml` |

## Building

All extras are generated from the single source of truth in `lua/kissa/colors.lua`:

```sh
nvim --headless -u NORC --cmd "set rtp+=." -c "lua require('kissa.build').run()" -c "qa"
```

## Etymology

**Kissa** (喫茶) is Japanese for "coffee house" — specifically the *kissaten* (喫茶店), the quiet, craft-focused coffee shops that predate speciality cafes. 喫 (ki) means "to drink/savor" and 茶 (sa) means "tea" — though in practice it means the place where coffee is served with intention.

Pronounced /kissa/ — "KEE-sah" with a slightly doubled s.

## License

MIT