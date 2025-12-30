# Helix Transparent Themes

This configuration includes several transparent theme variants that allow your terminal background to show through.

## What is a Transparent Theme?

A transparent theme removes the background color from the editor, allowing your terminal's background (color, image, or blur effect) to be visible. This is achieved by setting `"ui.background" = {}` which makes the background transparent.

## Available Transparent Themes

### Gruvbox Variants (Dark)

#### 1. **gruvbox_transparent** (Default)
- Base: gruvbox (default dark)
- Warm, retro color palette
- Medium contrast
- **Currently set as default**

#### 2. **gruvbox_dark_hard_transparent**
- Base: gruvbox_dark_hard
- Higher contrast than default
- Darker background colors for UI elements
- Best for: Bright terminal backgrounds

#### 3. **gruvbox_dark_soft_transparent**
- Base: gruvbox_dark_soft
- Lower contrast than default
- Softer, easier on the eyes
- Best for: Long coding sessions, dark terminal backgrounds

#### 4. **gruvbox_material_transparent**
- Base: gruvbox-material
- Modern take on gruvbox
- Softer colors, better balanced
- Best for: Clean, modern aesthetic

### Gruvbox Light

#### 5. **gruvbox_light_transparent**
- Base: gruvbox_light
- Light theme variant
- Best for: Daytime coding, bright environments

### Other

#### 6. **dracula_transparent**
- Base: dracula
- Purple/pink color scheme
- Popular with many developers

## Switching Themes

### Method 1: Update config.toml (Permanent)
Edit `~/.config/helix/config.toml`:
```toml
theme = "gruvbox_dark_hard_transparent"  # or any other theme
```

### Method 2: Runtime Switch (Temporary)
In Helix, type:
```
:theme gruvbox_dark_soft_transparent
```
This change is not saved and will reset when you restart Helix.

### Method 3: Keybinding
Add to your `config.toml`:
```toml
[keys.normal.space.t]
t = ":theme "  # Opens theme selector
```
Then press `Space t t` and type the theme name.

## Creating Your Own Transparent Theme

Want to make any Helix theme transparent? Create a new file in `~/.config/helix/themes/`:

```toml
# ~/.config/helix/themes/THEME_NAME_transparent.toml
inherits = "THEME_NAME"
"ui.background" = {}
```

### Example: Tokyo Night Transparent
```toml
# ~/.config/helix/themes/tokyonight_transparent.toml
inherits = "tokyonight"
"ui.background" = {}
```

Then use it:
```toml
theme = "tokyonight_transparent"
```

## Available Base Themes

Helix comes with many built-in themes. List them all:
```bash
ls /opt/homebrew/Cellar/helix/*/libexec/runtime/themes/
```

Popular base themes for transparent variants:
- `catppuccin_*` - Soothing pastel theme (4 variants)
- `tokyonight` - Dark blue theme
- `nord` - Arctic, north-bluish theme
- `onedark` - Atom's One Dark
- `zenburn` - Low-contrast theme
- `monokai` - Classic Sublime Text theme
- `solarized_*` - Light and dark variants
- `base16_*` - Many color scheme variants

## Terminal Configuration

For the best transparent theme experience, configure your terminal:

### iTerm2 (macOS)
1. Preferences → Profiles → Window
2. Set "Transparency" slider
3. Optional: Enable "Blur" for a frosted glass effect

### Alacritty
```yaml
# ~/.config/alacritty/alacritty.yml
window:
  opacity: 0.9  # 0.0 to 1.0
  blur: true    # macOS only
```

### Kitty
```conf
# ~/.config/kitty/kitty.conf
background_opacity 0.9
dynamic_background_opacity yes
```

### Wezterm
```lua
-- ~/.config/wezterm/wezterm.lua
return {
  window_background_opacity = 0.9,
  macos_window_background_blur = 20,
}
```

## Comparison: Gruvbox Variants

| Theme | Contrast | Best For |
|-------|----------|----------|
| gruvbox_transparent | Medium | General use, balanced |
| gruvbox_dark_hard_transparent | High | Bright backgrounds, readability |
| gruvbox_dark_soft_transparent | Low | Long sessions, less eye strain |
| gruvbox_material_transparent | Medium-Low | Modern aesthetic, clean look |
| gruvbox_light_transparent | N/A | Daytime, bright environments |

## Tips

1. **Terminal Background**: Use a subtle background image or color that doesn't distract from code
2. **Opacity**: Start with 90-95% opacity, adjust to preference
3. **Blur**: Enable blur in your terminal for better text readability
4. **Contrast**: Use hard variants for better readability with transparency
5. **Time of Day**: Consider using light themes during day, dark at night

## Troubleshooting

### Theme not loading
```bash
# Check if theme file exists
ls ~/.config/helix/themes/gruvbox_transparent.toml

# Verify no syntax errors
cat ~/.config/helix/themes/gruvbox_transparent.toml

# Check Helix health
hx --health
```

### Background not transparent
1. Ensure your terminal supports transparency
2. Check terminal transparency settings
3. Verify the theme inherits correctly
4. Some UI elements may have explicit backgrounds (this is normal)

### Colors look wrong
- Ensure your terminal supports 24-bit true color
- Check `$TERM` environment variable: `echo $TERM`
- Should be something like `xterm-256color` or `alacritty`

## Recommendation

For most users, I recommend:
- **Default**: `gruvbox_transparent` - Good balance
- **High Contrast**: `gruvbox_dark_hard_transparent` - Better readability
- **Easy on Eyes**: `gruvbox_dark_soft_transparent` - Comfortable for long sessions

The default is now set to `gruvbox_transparent`.

## Preview Themes Quickly

Create this keybinding in `config.toml`:
```toml
[keys.normal.space]
# ... other bindings ...
t = ":theme "  # Opens theme command with space to type

# Or create a theme menu
[keys.normal.space.t]
"1" = ":theme gruvbox_transparent"
"2" = ":theme gruvbox_dark_hard_transparent"
"3" = ":theme gruvbox_dark_soft_transparent"
"4" = ":theme gruvbox_material_transparent"
"5" = ":theme gruvbox_light_transparent"
"6" = ":theme dracula_transparent"
```

Then `Space t 1` switches to theme 1, `Space t 2` to theme 2, etc.

---

Enjoy your transparent Helix setup! 🎨✨
