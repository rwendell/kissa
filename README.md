# ![Kissa 喫茶](logo.svg)　喫茶　· /kissa/ · "KEE-sah"
WCAG AA+ accessible color schemes rooted in espresso.

<div align="center">
  <img src="assets/macchiato.png" width="49%" /> <img src="assets/latte.png" width="49%" />
</div>

## Quick Start

### Neovim

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "rwendell/kissa",
  lazy = false,
  priority = 1000,
  config = function()
    require("kissa").setup({ variant = "auto" })
  end,
}
```

## Palette

| Color | Macchiato | Latte | Usage |
|-------|-----------|-------|-------|
| `bg` | ![#1F1C16](https://placehold.co/22x22/1F1C16/1F1C16) | ![#F5F4F0](https://placehold.co/22x22/F5F4F0/F5F4F0) | Background |
| `bg_alt` | ![#35322D](https://placehold.co/22x22/35322D/35322D) | ![#E8E7E3](https://placehold.co/22x22/E8E7E3/E8E7E3) | Statusline, gutters |
| `surface0` | ![#47443F](https://placehold.co/22x22/47443F/47443F) | ![#D5D2CB](https://placehold.co/22x22/D5D2CB/D5D2CB) | Selection, panels |
| `surface1` | ![#5D5B57](https://placehold.co/22x22/5D5B57/5D5B57) | ![#C5C0B8](https://placehold.co/22x22/C5C0B8/C5C0B8) | Cursor line, folds |
| `surface2` | ![#6D6B68](https://placehold.co/22x22/6D6B68/6D6B68) | ![#B5AFA6](https://placehold.co/22x22/B5AFA6/B5AFA6) | Dim surfaces |
| `fg` | ![#FAF0E6](https://placehold.co/22x22/FAF0E6/FAF0E6) | ![#1F1C16](https://placehold.co/22x22/1F1C16/1F1C16) | Primary text |
| `fg_dim` | ![#E8D5B7](https://placehold.co/22x22/E8D5B7/E8D5B7) | ![#6E6459](https://placehold.co/22x22/6E6459/6E6459) | Secondary text |
| `fg_muted` | ![#D4C4A8](https://placehold.co/22x22/D4C4A8/D4C4A8) | ![#746C62](https://placehold.co/22x22/746C62/746C62) | Tertiary text |
| `fg_subtle` | ![#B8A48C](https://placehold.co/22x22/B8A48C/B8A48C) | ![#91887D](https://placehold.co/22x22/91887D/91887D) | Comments |
| `red` | ![#E87777](https://placehold.co/22x22/E87777/E87777) | ![#9E3E3E](https://placehold.co/22x22/9E3E3E/9E3E3E) | Errors, deletes |
| `orange` | ![#DA9050](https://placehold.co/22x22/DA9050/DA9050) | ![#8F5D22](https://placehold.co/22x22/8F5D22/8F5D22) | Operators, numbers |
| `yellow` | ![#EAC67A](https://placehold.co/22x22/EAC67A/EAC67A) | ![#7D6820](https://placehold.co/22x22/7D6820/7D6820) | Strings, warnings |
| `green` | ![#8CB870](https://placehold.co/22x22/8CB870/8CB870) | ![#387050](https://placehold.co/22x22/387050/387050) | Functions, diff-add |
| `teal` | ![#6AB8B0](https://placehold.co/22x22/6AB8B0/6AB8B0) | ![#287070](https://placehold.co/22x22/287070/287070) | Types, regex |
| `blue` | ![#7FA8D4](https://placehold.co/22x22/7FA8D4/7FA8D4) | ![#3468A8](https://placehold.co/22x22/3468A8/3468A8) | Keywords, links |
| `purple` | ![#B094CC](https://placehold.co/22x22/B094CC/B094CC) | ![#6438A0](https://placehold.co/22x22/6438A0/6438A0) | Constants |
| `pink` | ![#CC88AA](https://placehold.co/22x22/CC88AA/CC88AA) | ![#943A68](https://placehold.co/22x22/943A68/943A68) | Properties |

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
