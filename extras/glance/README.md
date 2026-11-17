# Kissa for Glance

Kissa Macchiato and Latte for [Glance](https://github.com/glanceapp/glance).

| File | Description |
| ---- | ----------- |
| [`macchiato.yml`](macchiato.yml) | Complete dark theme block. |
| [`latte.yml`](latte.yml) | Complete light theme block. |
| [`presets.yml`](presets.yml) | Both variants as Glance theme presets. |

## Install

Copy one of the theme blocks into your `glance.yml`, or merge the presets file into your existing `theme` section.

```yaml
theme:
  presets:
    kissa-macchiato:
      background-color: 40 17 10
      contrast-multiplier: 1.15
      text-saturation-multiplier: 1.6
      primary-color: 211 50 66
      positive-color: 97 34 58
      negative-color: 0 71 69

    kissa-latte:
      light: true
      background-color: 48 20 95
      contrast-multiplier: 1
      text-saturation-multiplier: 1.6
      primary-color: 213 53 43
      positive-color: 146 33 33
      negative-color: 0 44 43
```

Then pick **Kissa Macchiato** or **Kissa Latte** from Glance's theme picker.

For automatic light/dark switching, use the [Theme Switcher](https://github.com/rwendell/glance-plugins/tree/main/plugins/theme-switcher) plugin. It loads Kissa from `assets/themes/`, follows the OS preference, and adds a light/dark/system toggle.

## Palette mapping

Glance generates its text tiers from the background color and contrast multiplier, so the theme uses the Kissa background, link, positive, and negative colors directly.

| Glance property | Kissa color | Macchiato | Latte |
| --------------- | ----------- | --------- | ----- |
| `background-color` | `bg` | `40 17 10` | `48 20 95` |
| `primary-color` | `blue` | `211 50 66` | `213 53 43` |
| `positive-color` | `green` | `97 34 58` | `146 33 33` |
| `negative-color` | `red` | `0 71 69` | `0 44 43` |
| `contrast-multiplier` | text hierarchy | `1.15` | `1` |
| `text-saturation-multiplier` | warm text | `1.6` | `1.6` |

The text colors are intentionally not hardcoded: Glance derives them from `--bgh`, `--bgs`, `--bgl`, `--cm`, and `--tsm`, which keeps every widget consistent with the Kissa background.
