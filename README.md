# ![Kissa 喫茶](logo.svg)　喫茶　· /kissa/ · "KEE-sah"
WCAG AA+ accessible color schemes rooted in espresso.

## Quick Start

### Neovim

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ "rwendell/kissa", lazy = false, priority = 1000 }
```

### Ghostty

Copy `extras/ghostty/*` to `~/.config/ghostty/themes/`, then:

```
theme = dark:macchiato,light:latte
```

## Palette

### Macchiato (dark)

| Color | | Hex | Usage |
|-------|-|-----|-------|
| `bg` | ![](https://placehold.co/15x15/1F1C16/1F1C16) | `#1F1C16` | Background |
| `bg_alt` | ![](https://placehold.co/15x15/35322D/35322D) | `#35322D` | Statusline, gutters |
| `surface0` | ![](https://placehold.co/15x15/47443F/47443F) | `#47443F` | Selection, panels |
| `surface1` | ![](https://placehold.co/15x15/5D5B57/5D5B57) | `#5D5B57` | Cursor line, folds |
| `surface2` | ![](https://placehold.co/15x15/6D6B68/6D6B68) | `#6D6B68` | Dim surfaces |
| `fg` | ![](https://placehold.co/15x15/FAF0E6/FAF0E6) | `#FAF0E6` | Primary text (15.1:1 AAA) |
| `fg_dim` | ![](https://placehold.co/15x15/E8D5B7/E8D5B7) | `#E8D5B7` | Secondary text (11.8:1 AAA) |
| `fg_muted` | ![](https://placehold.co/15x15/D4C4A8/D4C4A8) | `#D4C4A8` | Tertiary text (9.9:1 AAA) |
| `fg_subtle` | ![](https://placehold.co/15x15/B8A48C/B8A48C) | `#B8A48C` | Comments (7.1:1 AAA) |
| `red` | ![](https://placehold.co/15x15/E87777/E87777) | `#E87777` | Errors, deletes (5.9:1 AA) |
| `orange` | ![](https://placehold.co/15x15/DA9050/DA9050) | `#DA9050` | Operators, numbers (6.5:1 AA) |
| `yellow` | ![](https://placehold.co/15x15/EAC67A/EAC67A) | `#EAC67A` | Strings, warnings (10.4:1 AAA) |
| `green` | ![](https://placehold.co/15x15/8CB870/8CB870) | `#8CB870` | Functions, diff-add (7.5:1 AAA) |
| `teal` | ![](https://placehold.co/15x15/6AB8B0/6AB8B0) | `#6AB8B0` | Types, regex (7.4:1 AAA) |
| `blue` | ![](https://placehold.co/15x15/7FA8D4/7FA8D4) | `#7FA8D4` | Keywords, links (6.8:1 AA) |
| `purple` | ![](https://placehold.co/15x15/B094CC/B094CC) | `#B094CC` | Constants (6.4:1 AA) |
| `pink` | ![](https://placehold.co/15x15/CC88AA/CC88AA) | `#CC88AA` | Properties (6.2:1 AA) |

### Latte (light)

| Color | | Hex | Usage |
|-------|-|-----|-------|
| `bg` | ![](https://placehold.co/15x15/F5F4F0/F5F4F0) | `#F5F4F0` | Background |
| `bg_alt` | ![](https://placehold.co/15x15/E8E7E3/E8E7E3) | `#E8E7E3` | Statusline, gutters |
| `surface0` | ![](https://placehold.co/15x15/D5D2CB/D5D2CB) | `#D5D2CB` | Selection, panels |
| `surface1` | ![](https://placehold.co/15x15/C5C0B8/C5C0B8) | `#C5C0B8` | Cursor line, folds |
| `surface2` | ![](https://placehold.co/15x15/B5AFA6/B5AFA6) | `#B5AFA6` | Dim surfaces |
| `fg` | ![](https://placehold.co/15x15/1F1C16/1F1C16) | `#1F1C16` | Primary text (15.4:1 AAA) |
| `fg_dim` | ![](https://placehold.co/15x15/6E6459/6E6459) | `#6E6459` | Secondary text (5.3:1 AA) |
| `fg_muted` | ![](https://placehold.co/15x15/746C62/746C62) | `#746C62` | Tertiary text (4.7:1 AA) |
| `fg_subtle` | ![](https://placehold.co/15x15/91887D/91887D) | `#91887D` | Comments (3.2:1 AA Large) |
| `red` | ![](https://placehold.co/15x15/9E3E3E/9E3E3E) | `#9E3E3E` | Errors, deletes (5.9:1 AA) |
| `orange` | ![](https://placehold.co/15x15/8F5D22/8F5D22) | `#8F5D22` | Operators, numbers (5.1:1 AA) |
| `yellow` | ![](https://placehold.co/15x15/7D6820/7D6820) | `#7D6820` | Strings, warnings (4.9:1 AA) |
| `green` | ![](https://placehold.co/15x15/387050/387050) | `#387050` | Functions, diff-add (5.3:1 AA) |
| `teal` | ![](https://placehold.co/15x15/287070/287070) | `#287070` | Types, regex (5.2:1 AA) |
| `blue` | ![](https://placehold.co/15x15/3468A8/3468A8) | `#3468A8` | Keywords, links (5.2:1 AA) |
| `purple` | ![](https://placehold.co/15x15/6438A0/6438A0) | `#6438A0` | Constants (7.3:1 AAA) |
| `pink` | ![](https://placehold.co/15x15/943A68/943A68) | `#943A68` | Properties (6.2:1 AA) |

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


## Etymology

**Kissa** (喫茶) is Japanese for "coffee house" — specifically the *kissaten* (喫茶店), the quiet, craft-focused coffee shops that predate speciality cafes. 喫 (ki) means "to drink/savor" and 茶 (sa) means "tea" — though in practice it means the place where coffee is served with intention.

Pronounced /kissa/ — "KEE-sah" with a slightly doubled s.

## License

MIT
