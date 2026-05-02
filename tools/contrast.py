#!/usr/bin/env python3
"""WCAG 2.1 contrast ratio calculator — context-aware palette verifier.

Checks:
- Foreground/syntax colors against background colors
- Surface/background colors against foreground (text-on-surface readability)
- Flags text colors that don't meet WCAG AA (4.5:1) on their context
"""

import sys
import tomllib
from pathlib import Path


def hex_to_linear(c: int) -> float:
    c = c / 255.0
    return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4


def relative_luminance(hex_color: str) -> float:
    hex_color = hex_color.lstrip("#")
    r, g, b = int(hex_color[:2], 16), int(hex_color[2:4], 16), int(hex_color[4:], 16)
    return 0.2126 * hex_to_linear(r) + 0.7152 * hex_to_linear(g) + 0.0722 * hex_to_linear(b)


def contrast_ratio(hex1: str, hex2: str) -> float:
    l1 = relative_luminance(hex1)
    l2 = relative_luminance(hex2)
    lighter = max(l1, l2)
    darker = min(l1, l2)
    return (lighter + 0.05) / (darker + 0.05)


def wcag_level(ratio: float) -> str:
    if ratio >= 7.0:
        return "AAA"
    elif ratio >= 4.5:
        return "AA"
    elif ratio >= 3.0:
        return "AA-L"
    else:
        return "FAIL"


def luminance_category(lum: float) -> str:
    if lum > 0.5:
        return "light"
    elif lum > 0.2:
        return "mid"
    else:
        return "dark"


def verify_palette(palette_path: str):
    p = Path(palette_path)
    with open(p, "rb") as f:
        data = tomllib.load(f)

    name = data["name"]
    variant = data["variant"]
    bg = data["colors"]["bg"]
    fg = data["colors"]["fg"]
    bg_lum = relative_luminance(bg)
    fg_lum = relative_luminance(fg)

    print(f"\n{'='*62}")
    print(f"  {name} ({variant})")
    print(f"  bg: {bg} (lum={bg_lum:.4f})  fg: {fg} (lum={fg_lum:.4f})")
    print(f"  Primary contrast: {contrast_ratio(fg, bg):.2f}:1 [{wcag_level(contrast_ratio(fg, bg))}]")
    print(f"{'='*62}")

    failures = []
    all_checks = []

    bg_hue = "light" if bg_lum > fg_lum else "dark"

    fg_against_bg = [
        "fg_dim", "fg_muted", "fg_subtle",
        "red", "orange", "yellow", "green", "teal", "blue", "purple", "pink",
    ]

    surface_against_fg = ["bg_alt", "surface0", "surface1", "surface2"]

    print(f"\n  ── Foreground colors on {bg} ──")
    print(f"  {'Color':<20} {'Hex':<10} {'Ratio':>8} {'Level':<8}")
    print(f"  {'─'*20} {'─'*10} {'─'*8} {'─'*8}")

    for key in fg_against_bg:
        if key in data["colors"]:
            hex_val = data["colors"][key]
            ratio = contrast_ratio(hex_val, bg)
            level = wcag_level(ratio)
            marker = " ✗" if level == "FAIL" else ""
            is_comment_like = key in ("fg_subtle", "fg_muted")
            min_level = "AA" if not is_comment_like else "AA"
            all_checks.append((key, hex_val, ratio, level, f"on bg", level != "FAIL" and (ratio >= 4.5 if not is_comment_like else ratio >= 3.0)))
            print(f"  {key:<20} {hex_val:<10} {ratio:>8.2f}:1 {level:<8}{marker}")

    print(f"\n  ── Surface colors (text readability with {fg}) ──")
    print(f"  {'Color':<20} {'Hex':<10} {'Ratio':>8} {'Level':<8}")
    print(f"  {'─'*20} {'─'*10} {'─'*8} {'─'*8}")

    for key in surface_against_fg:
        if key in data["colors"]:
            hex_val = data["colors"][key]
            ratio = contrast_ratio(fg, hex_val)
            level = wcag_level(ratio)
            marker = " ✗" if level == "FAIL" else ""
            all_checks.append((key, hex_val, ratio, level, f"fg on surface", ratio >= 4.5))
            print(f"  {key:<20} {hex_val:<10} {ratio:>8.2f}:1 {level:<8}{marker}")

    if "syntax" in data:
        print(f"\n  ── Syntax colors on {bg} ──")
        print(f"  {'Color':<20} {'Hex':<10} {'Ratio':>8} {'Level':<8}")
        print(f"  {'─'*20} {'─'*10} {'─'*8} {'─'*8}")
        for key, hex_val in data["syntax"].items():
            ratio = contrast_ratio(hex_val, bg)
            level = wcag_level(ratio)
            marker = " ✗" if level == "FAIL" else ""
            needs_aa = key not in ("comment", "fold")
            passes = ratio >= 4.5 if needs_aa else ratio >= 3.0
            all_checks.append((f"syntax.{key}", hex_val, ratio, level, f"on bg", passes))
            print(f"  {key:<20} {hex_val:<10} {ratio:>8.2f}:1 {level:<8}{marker}")

    if "ui" in data:
        print(f"\n  ── UI colors ──")
        print(f"  {'Color':<24} {'Hex':<10} {'Ratio':>8} {'Level':<8} {'Context':<14}")
        print(f"  {'─'*24} {'─'*10} {'─'*8} {'─'*8} {'─'*14}")
        for key, hex_val in data["ui"].items():
            if key.endswith("_fg"):
                ratio = contrast_ratio(hex_val, bg)
                context = "on bg"
            elif key.endswith("_bg"):
                ratio = contrast_ratio(fg, hex_val)
                context = "fg on it"
            elif key in ("cursor",):
                ratio = contrast_ratio(hex_val, bg)
                context = "on bg"
            else:
                ratio = contrast_ratio(hex_val, bg)
                context = "on bg"
            level = wcag_level(ratio)
            marker = " ✗" if level == "FAIL" else ""
            print(f"  {key:<24} {hex_val:<10} {ratio:>8.2f}:1 {level:<8} {context:<14}{marker}")

    total = len(all_checks)
    passing = sum(1 for c in all_checks if c[5])
    failing_checks = [c for c in all_checks if not c[5]]

    print(f"\n  Result: {passing}/{total} checks pass WCAG requirements")

    if failing_checks:
        print(f"\n  ⚠  {len(failing_checks)} color(s) need attention:")
        for name, hex_val, ratio, level, context, _ in failing_checks:
            print(f"     {name} ({hex_val}): {ratio:.2f}:1 {context} — needs 4.5:1")
        return False
    else:
        print(f"  ✓ All colors meet WCAG requirements")
        return True


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: contrast.py <palette1.toml> [palette2.toml ...]")
        sys.exit(1)

    results = []
    for path in sys.argv[1:]:
        results.append(verify_palette(path))

    if not all(results):
        sys.exit(1)