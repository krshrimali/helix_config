# Helix Limitations & Workarounds

This document outlines known limitations in Helix compared to Neovim and provides workarounds.

## 1. Cannot Focus Into Hover Popups

### The Issue
Unlike Neovim (where you can press `K` twice to focus into the documentation popup), Helix currently does **not** support focusing into hover popups. This means you cannot:
- Select and copy text from documentation
- Follow links in API descriptions
- Scroll using normal navigation keys (`j`/`k`)

### Current Capabilities
You **can**:
- Show hover popup: `K`
- Scroll the popup: `Ctrl+d` (down) / `Ctrl+u` (up)
- Close the popup: `Esc`

### Workarounds

#### 1. Go to Definition (Recommended)
Instead of viewing docs in a popup, jump to the source:
```
1. Press `g d` to go to definition
2. Read the docstring/comments directly
3. Press `Ctrl+o` to jump back
```

#### 2. Use Symbol Picker
For exploring documentation:
```
1. Press `Ctrl+s` for symbol picker
2. Fuzzy search for the function/class
3. Press Enter to jump to it
4. Read the full source documentation
```

#### 3. External Documentation
For standard library or third-party packages:
```bash
# Python example
python -m pydoc <module_name>

# Or use online docs
# - Python: https://docs.python.org
# - Rust: https://docs.rs
```

### Future Support
There's an [open pull request (#12208)](https://github.com/helix-editor/helix/pull/12208) that adds a `goto_hover` command. Once merged, this will dump hover documentation into a scratch buffer where you can:
- Use normal Helix navigation
- Select and copy text
- Search within documentation
- Follow links

**Track the issue**: [#12206](https://github.com/helix-editor/helix/issues/12206)

---

## 2. No Built-in Terminal

### The Issue
Helix doesn't have a built-in terminal like Neovim's ToggleTerm.

### Workaround
This configuration uses external terminal windows:
- `Space g g` - Opens Lazygit in a new terminal
- Scripts in `~/.config/helix/scripts/` spawn external terminals

For macOS:
- Uses iTerm2 or Terminal.app
- Scripts automatically detect available terminal emulator

For Linux:
- Supports alacritty, kitty, gnome-terminal
- Falls back to current terminal if none found

---

## 3. Window Navigation

### The Issue
Helix doesn't have Neovim-style window navigation (like `Alt+h/j/k/l`).

### Current Capabilities
- `Ctrl+w v` - Vertical split
- `Ctrl+w s` - Horizontal split
- `Ctrl+w w` - Cycle between splits
- `Ctrl+w q` - Close current split

### Configured Shortcuts
- `Space k v` - Vertical split
- `Space k s` - Horizontal split

---

## 4. No Lua Plugin System

### The Issue
Helix doesn't support Lua plugins like Neovim.

### Alternatives

#### Shell Scripts
This configuration uses shell scripts for custom functionality:
```bash
~/.config/helix/scripts/
├── github_permalink.sh      # GitHub permanent links
├── github_permalink_wrapper.sh
├── git_lazygit.sh          # Lazygit integration
└── helix_info.sh
```

#### External Tools
Integrate with external tools via keybindings:
```toml
[keys.normal.space.g]
g = ":sh ~/.config/helix/scripts/git_lazygit.sh"
y = ":run-shell-command ~/.config/helix/scripts/github_permalink_wrapper.sh"
```

#### Future: Rust Plugins
Helix is considering a plugin system written in Rust (not yet implemented).

---

## 5. Buffer Navigation Limitations

### The Issue
GitHub permalink script cannot easily get current file/line info from Helix (unlike Neovim which can pass buffer context to scripts).

### Workaround
The `github_permalink_wrapper.sh` script uses multiple strategies:
1. Process inspection (auto-detect open files)
2. Temp file communication
3. Manual input (fallback)

**Note**: This is less seamless than Neovim but still functional.

---

## Advantages Over Neovim

Despite these limitations, Helix has several advantages:

### 1. Performance
- Written in Rust, extremely fast
- No startup time
- Instant LSP responses

### 2. Multiple Selections
- More powerful than Neovim's visual mode
- Native support for multiple cursors
- Selection-first editing model

### 3. Built-in LSP
- First-class LSP support out of the box
- No configuration needed for basic functionality
- Works immediately after installing language servers

### 4. Modern Defaults
- Sensible defaults
- No need for extensive configuration
- Tree-sitter integration built-in

### 5. Simpler Mental Model
- Consistent command structure
- Selection → Action (vs Vim's Action → Motion)
- Easier to learn for new users

---

## Summary Table

| Feature | Neovim | Helix | Workaround |
|---------|--------|-------|------------|
| Focus hover popup | ✅ Yes (press K twice) | ❌ No | Use `g d` to go to source |
| Scroll hover popup | ✅ Yes | ✅ Yes (Ctrl+d/Ctrl+u) | - |
| Built-in terminal | ✅ Yes (ToggleTerm, etc) | ❌ No | External terminal scripts |
| Window navigation | ✅ Yes (Alt+hjkl, etc) | ⚠️ Basic (Ctrl+w) | Use splits + Ctrl+w |
| Lua plugins | ✅ Yes | ❌ No | Shell scripts + external tools |
| GitHub permalink | ✅ Easy | ⚠️ Limited | Script with manual input |
| Multiple selections | ⚠️ Via plugins | ✅ Native | - |
| LSP setup | ⚠️ Requires config | ✅ Built-in | - |
| Startup time | ⚠️ Slow (with plugins) | ✅ Instant | - |
| Performance | ⚠️ Variable | ✅ Excellent | - |

---

## Staying Updated

To get new features as they're released:

```bash
# Update Helix
brew upgrade helix

# Check version
hx --version

# See what's new
# Visit: https://helix-editor.com/news/
```

When `goto_hover` is merged, update your config:
```toml
[keys.normal]
K = "hover"  # First press: show popup
# K pressed again will use goto_hover (when available)
```

---

## Resources

- [Helix Issue #12206](https://github.com/helix-editor/helix/issues/12206) - Entering popup documentation
- [Helix PR #12208](https://github.com/helix-editor/helix/pull/12208) - goto_hover command
- [Helix Documentation](https://docs.helix-editor.com/)
- [Helix GitHub Discussions](https://github.com/helix-editor/helix/discussions)
