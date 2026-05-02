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

| Color | Macchiato | Latte | Usage |
|-------|-----------|-------|-------|
| `bg` | ![](https://placehold.co/22x22/1F1C16/1F1C16) `#1F1C16` | ![](https://placehold.co/22x22/F5F4F0/F5F4F0) `#F5F4F0` | Background |
| `bg_alt` | ![](https://placehold.co/22x22/35322D/35322D) `#35322D` | ![](https://placehold.co/22x22/E8E7E3/E8E7E3) `#E8E7E3` | Statusline, gutters |
| `surface0` | ![](https://placehold.co/22x22/47443F/47443F) `#47443F` | ![](https://placehold.co/22x22/D5D2CB/D5D2CB) `#D5D2CB` | Selection, panels |
| `surface1` | ![](https://placehold.co/22x22/5D5B57/5D5B57) `#5D5B57` | ![](https://placehold.co/22x22/C5C0B8/C5C0B8) `#C5C0B8` | Cursor line, folds |
| `surface2` | ![](https://placehold.co/22x22/6D6B68/6D6B68) `#6D6B68` | ![](https://placehold.co/22x22/B5AFA6/B5AFA6) `#B5AFA6` | Dim surfaces |
| `fg` | ![](https://placehold.co/22x22/FAF0E6/FAF0E6) `#FAF0E6` | ![](https://placehold.co/22x22/1F1C16/1F1C16) `#1F1C16` | Primary text |
| `fg_dim` | ![](https://placehold.co/22x22/E8D5B7/E8D5B7) `#E8D5B7` | ![](https://placehold.co/22x22/6E6459/6E6459) `#6E6459` | Secondary text |
| `fg_muted` | ![](https://placehold.co/22x22/D4C4A8/D4C4A8) `#D4C4A8` | ![](https://placehold.co/22x22/746C62/746C62) `#746C62` | Tertiary text |
| `fg_subtle` | ![](https://placehold.co/22x22/B8A48C/B8A48C) `#B8A48C` | ![](https://placehold.co/22x22/91887D/91887D) `#91887D` | Comments |
| `red` | ![](https://placehold.co/22x22/E87777/E87777) `#E87777` | ![](https://placehold.co/22x22/9E3E3E/9E3E3E) `#9E3E3E` | Errors, deletes |
| `orange` | ![](https://placehold.co/22x22/DA9050/DA9050) `#DA9050` | ![](https://placehold.co/22x22/8F5D22/8F5D22) `#8F5D22` | Operators, numbers |
| `yellow` | ![](https://placehold.co/22x22/EAC67A/EAC67A) `#EAC67A` | ![](https://placehold.co/22x22/7D6820/7D6820) `#7D6820` | Strings, warnings |
| `green` | ![](https://placehold.co/22x22/8CB870/8CB870) `#8CB870` | ![](https://placehold.co/22x22/387050/387050) `#387050` | Functions, diff-add |
| `teal` | ![](https://placehold.co/22x22/6AB8B0/6AB8B0) `#6AB8B0` | ![](https://placehold.co/22x22/287070/287070) `#287070` | Types, regex |
| `blue` | ![](https://placehold.co/22x22/7FA8D4/7FA8D4) `#7FA8D4` | ![](https://placehold.co/22x22/3468A8/3468A8) `#3468A8` | Keywords, links |
| `purple` | ![](https://placehold.co/22x22/B094CC/B094CC) `#B094CC` | ![](https://placehold.co/22x22/6438A0/6438A0) `#6438A0` | Constants |
| `pink` | ![](https://placehold.co/22x22/CC88AA/CC88AA) `#CC88AA` | ![](https://placehold.co/22x22/943A68/943A68) `#943A68` | Properties |

## Ports

| Format | Path |
|--------|------|
| Neovim | [`colors/`](colors/) |
| Ghostty | [`extras/ghostty/`](extras/ghostty/) |
| Kitty | [`extras/kitty/`](extras/kitty/) |
| Alacritty | [`extras/alacritty/`](extras/alacritty/) |
| WezTerm | [`extras/wezterm/`](extras/wezterm/) |
| Foot | [`extras/foot/`](extras/foot/) |
| iTerm2 | [`extras/iterm2/`](extras/iterm2/) |
| XResources | [`extras/xresources/`](extras/xresources/) |
| OpenCode | [`extras/opencode/`](extras/opencode/) |
| Base16 | [`base16/`](base16/) |
| Palette TOML | [`palette/`](palette/) |


## Etymology

**Kissa** (喫茶) is Japanese for "coffee house" — specifically the *kissaten* (喫茶店), the quiet, craft-focused coffee shops that predate speciality cafes. 喫 (ki) means "to drink/savor" and 茶 (sa) means "tea" — though in practice it means the place where coffee is served with intention.
