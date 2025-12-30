# Helix Configuration

This Helix configuration is inspired by and ported from my Neovim setup, providing similar functionality and keybindings.

## Features

- **Transparent Themes**: Gruvbox transparent theme variants that show your terminal background
- **LSP Integration**: Comprehensive LSP setup with ty + ruff for Python, and more
- **Custom Keymaps**: Similar to Neovim configuration with `Space` as the leader key
- **GitHub Permalink**: Generate GitHub permanent links for the current file/selection
- **Git Integration**: Lazygit, git blame, and other git operations
- **Symbol Navigation**: LSP-powered symbol viewer and navigation
- **Vim-like Navigation**: 0, $, K keybindings work like Vim/Neovim

## Directory Structure

```
~/.config/helix/
├── config.toml           # Main configuration file with keymaps
├── languages.toml        # LSP and language-specific settings
├── README.md            # This file
├── THEMES.md            # Theme documentation
├── KEYBINDINGS.md       # Quick reference for keybindings
├── PYTHON_SETUP.md      # Python (ty + ruff) setup guide
├── LIMITATIONS.md       # Known limitations and workarounds
├── themes/              # Custom transparent themes
│   ├── dracula_transparent.toml
│   ├── gruvbox_transparent.toml (default)
│   ├── gruvbox_dark_hard_transparent.toml
│   ├── gruvbox_dark_soft_transparent.toml
│   ├── gruvbox_material_transparent.toml
│   └── gruvbox_light_transparent.toml
└── scripts/             # Custom helper scripts
    ├── github_permalink.sh
    ├── github_permalink_wrapper.sh
    ├── git_lazygit.sh
    └── helix_info.sh
```

## Key Mappings

### Insert Mode

- `jk` - Exit to normal mode (like Neovim)
- `Esc` - Exit to normal mode

### Normal Mode

#### File Operations

- `Ctrl+p` - File picker (fuzzy find files)
- `Ctrl+s` - LSP document symbols (like a symbol tree/outline)
- `Space w` - Save file
- `Space q` - Quit
- `Space Q` - Force quit

#### Buffer Navigation

- `H` - Previous buffer (like Neovim `Shift+h`)
- `L` - Next buffer (like Neovim `Shift+l`)
- `Space b b` - Buffer picker
- `Space b d` - Close buffer
- `Space b n` - Next buffer
- `Space b p` - Previous buffer

#### LSP Operations (`Space l`)

- `Space l a` - Code actions
- `Space l d` - Show diagnostics/hover documentation
- `Space l f` - Format code
- `Space l g g` - Go to definition
- `Space l i` - Go to implementation
- `Space l j` - Next diagnostic
- `Space l k` - Previous diagnostic
- `Space l r` - Rename symbol
- `Space l s` - Document symbols picker
- `Space l S` - Workspace symbols picker
- `Space l t` - Go to type definition
- `Space l R` - Go to references

#### Git Operations (`Space g`)

- `Space g g` - Open Lazygit (in new terminal)
- `Space g b` - Git blame on entire file
- `Space g d` - Git diff on current file
- `Space g s` - Git status
- `Space g y` - **Generate GitHub permalink** (copies to clipboard)
- `g b` - Git blame current line (quick blame)

#### File Finding (`Space f`)

- `Space f f` - Find files
- `Space f g` - Files in current directory
- `Space f r` - Recent files
- `Space f b` - Buffer picker

#### Search

- `Space / /` - Global search (live grep)
- `Space h` - Clear search highlights

#### Diagnostics (`Space d`)

- `Space d d` - Show diagnostics
- `Space d f` - File diagnostics
- `Space d w` - Workspace diagnostics

#### Window/Splits (`Space k`)

- `Space k s` - Horizontal split
- `Space k v` - Vertical split

#### Options Toggle (`Space o`)

- `Space o w` - Toggle soft wrap
- `Space o r` - Toggle line numbers
- `Space o l` - Toggle cursor line

#### Quick Navigation

- `0` - Go to start of line (like Vim/Neovim)
- `$` - Go to end of line (like Vim/Neovim)
- `K` - Show documentation/hover (use Ctrl+d/Ctrl+u to scroll)
- `g b` - Git blame current line (shows who last modified the line under cursor)
- `g d` - Go to definition
- `g r` - Go to references
- `+` - Increment number
- `-` - Decrement number

### Select/Visual Mode

- `0` - Go to start of line (extends selection)
- `$` - Go to end of line (extends selection)
- `<` - Indent left (keep selection)
- `>` - Indent right (keep selection)
- `Space g y` - Generate GitHub permalink for selection

## Custom Scripts

### GitHub Permalink Generator

**Location**: `~/.config/helix/scripts/github_permalink.sh`

Generates a GitHub permanent link for the current file and line selection.

**Usage**:
- In Helix: `Space g y` (normal or visual mode)
- Manual: `~/.config/helix/scripts/github_permalink.sh <file_path> <start_line> [end_line]`

**How it works**:
1. Uses Helix's `%{buffer_name}` to get current file path
2. Uses `%{selection_line_start}` and `%{selection_line_end}` to get line range
3. Detects the git repository root
4. Gets the current commit SHA
5. Constructs a GitHub permalink with file and line numbers
6. Copies to clipboard (macOS, Linux with xclip, or wl-clipboard)

**Example output**:
```
https://github.com/krshrimali/neovim/blob/f52bd796/lua/user/keymaps.lua#L42-L45
```

**Usage**:
- Position cursor on a line and press `Space g y` for single line
- Select multiple lines (visual mode) and press `Space g y` for line range
- Works in both normal and select mode

### Lazygit Integration

**Location**: `~/.config/helix/scripts/git_lazygit.sh`

Opens Lazygit in a new terminal window (iTerm2 or Terminal.app on macOS, various terminals on Linux).

**Usage**: `Space g g` in Helix

### Additional Scripts

- `helix_github_permalink.sh` - Helper for GitHub permalink with temp file approach
- `helix_info.sh` - Information script for debugging

## LSP Configuration

The `languages.toml` file configures LSP servers for various languages:

### Python: ty + ruff

Your Python setup uses two complementary LSP servers:

1. **ty** (Type Checker):
   - Extremely fast Python type checker from Astral (creators of ruff and uv)
   - Written in Rust, 10x-60x faster than mypy and Pyright
   - Provides: type checking, go-to-definition, find references, auto-complete, inlay hints
   - Released December 2025, currently in beta

2. **ruff** (Linter + Formatter):
   - Fast linting and formatting
   - Auto-fixes for many issues
   - Replaces flake8, black, isort, etc.

Together, they provide a complete Python development experience with blazing-fast performance.

### Configured Languages

- **Python**: ty (type checker) + ruff (linter + formatter)
- **Rust**: rust-analyzer with clippy
- **Go**: gopls with goimports
- **TypeScript/JavaScript**: typescript-language-server with prettier
- **C/C++**: clangd with background indexing
- **Markdown**: marksman
- **TOML**: taplo
- **JSON**: vscode-json-language-server
- **YAML**: yaml-language-server
- **Bash**: bash-language-server

### Installing LSP Servers

To use LSP features, install the required language servers:

```bash
# Python
brew install ruff  # Linter and formatter
uv tool install ty  # Type checker (extremely fast, from Astral)

# Rust
rustup component add rust-analyzer

# Go
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest

# TypeScript/JavaScript
npm install -g typescript-language-server typescript prettier

# C/C++
# Install clangd (usually comes with LLVM/Clang)
brew install llvm  # macOS
# or: sudo apt install clangd  # Linux

# Markdown
brew install marksman  # macOS
# or: cargo install marksman

# TOML
cargo install taplo-cli --locked

# JSON
npm install -g vscode-langservers-extracted

# YAML
npm install -g yaml-language-server

# Bash
npm install -g bash-language-server
```

## Differences from Neovim Config

### Limitations

1. **GitHub Permalink**: Helix doesn't easily expose current file/line info to shell commands, so the permalink generator uses:
   - Process inspection to auto-detect files (best effort)
   - Manual input mode as fallback
   - Consider this a proof-of-concept; a proper Helix plugin would be better

2. **Buffer Navigation**: Helix doesn't have window navigation like Neovim's `Alt+h/j/k/l`. Use built-in navigation:
   - `Ctrl+w` for window commands
   - Or use splits with `Space k s/v`

3. **Hover Popup Interaction**: Helix cannot focus into hover popups to select text or follow links (unlike Neovim). You can only scroll with Ctrl+d/Ctrl+u. A workaround is to use `g d` to go to the source definition.

4. **Terminal Integration**: Helix doesn't have built-in terminal like Neovim's ToggleTerm. Scripts open terminals externally.

5. **Plugin Ecosystem**: Helix doesn't have a Lua plugin system like Neovim. Custom functionality requires:
   - Shell scripts (current approach)
   - Rust plugins (advanced, requires compilation)
   - External tools integration

### Advantages

1. **Performance**: Helix is incredibly fast and responsive
2. **Built-in Features**: Many features that require Neovim plugins are built into Helix
3. **Multiple Selections**: Helix's multiple selections are more powerful than Neovim's visual mode
4. **LSP Integration**: First-class LSP support out of the box

## Tips and Tricks

### Line Navigation (Vim-like)

The `0` and `$` keys now work exactly like Vim/Neovim in both normal and select mode:
- `0` - Jump to the first character of the line
  - Normal mode: Moves cursor to start of line
  - Select mode: Extends selection to start of line
- `$` - Jump to the last character of the line
  - Normal mode: Moves cursor to end of line
  - Select mode: Extends selection to end of line

These complement Helix's built-in navigation:
- `gh` - Go to line start (same as `0`)
- `gl` - Go to line end (same as `$`)
- `^` - Go to first non-whitespace character
- `w` / `b` - Word forward/backward
- `e` - End of word

### Documentation Popup (K key)

When you press `K` on a symbol (like a function or variable), Helix shows the hover popup with documentation.

**Scrolling the popup**:
- `Ctrl+d` - Scroll down (page down)
- `Ctrl+u` - Scroll up (page up)
- `Esc` - Close the popup

**Important limitation**: Unlike Neovim, Helix currently does **not** support focusing into the popup to select/copy text or follow links. This is a [known limitation](https://github.com/helix-editor/helix/issues/12206) with an [open PR](https://github.com/helix-editor/helix/pull/12208) adding a `goto_hover` command that would dump documentation into a scratch buffer for full interaction.

**Workaround for long documentation**:
If you need to interact with documentation (copy text, follow links):
1. Use `g d` to go to the definition
2. Read the docstring/comments directly in the source
3. Or wait for the `goto_hover` command to be merged (PR #12208)

## Tips and Tricks

### Using the Symbol Picker (LSP Tree/Outline)

The symbol picker (`Ctrl+s` or `Space l s`) provides a tree-like view of symbols in the current file:
- Functions, classes, variables, etc.
- Fuzzy search through symbols
- Quick navigation to any symbol

This is similar to Neovim's LSP outline/tree viewers.

### GitHub Permalink Workflow

Since Helix's GitHub permalink integration has limitations:

**Option 1**: Auto-detection (works ~80% of the time)
1. Position cursor or make selection
2. Press `Space g y`
3. Script attempts to detect file and generates permalink
4. Check terminal output for the URL

**Option 2**: Manual input (always works)
1. Press `Space g y`
2. If auto-detection fails, enter file path when prompted
3. Enter line numbers
4. Permalink copied to clipboard

**Option 3**: Use the script directly
```bash
~/.config/helix/scripts/github_permalink.sh /path/to/file.rs 42 45
```

### Working with LSP

Helix's LSP integration is excellent. Common workflows:

1. **Explore code**: `Ctrl+s` (symbol picker) → fuzzy search → Enter
2. **Go to definition**: `g d` or `Space l g g`
3. **Find references**: `g r` or `Space l R`
4. **Rename symbol**: `Space l r`
5. **Code actions**: `Space l a`
6. **Format**: `Space l f` (or auto-format on save if configured)
7. **View documentation**:
   - Press `K` (Shift+K) to show hover documentation
   - Use `Ctrl+d` / `Ctrl+u` to scroll within the popup
   - Press `Esc` to close the popup

### Multiple Cursors/Selections

Helix shines with multiple selections:
- `s` - Select/extend selection
- `Alt+s` - Split selection on newlines
- `C` - Duplicate cursor below
- `;` - Collapse to cursor
- `Alt+;` - Flip cursor direction

## Future Enhancements

Potential improvements for this setup:

1. **GitHub Permalink Plugin**: Create a proper Rust-based Helix plugin that has direct access to buffer info
2. **Better Terminal Integration**: Investigate Helix's ability to run persistent background processes
3. **Additional Scripts**: More git operations, project management, etc.
4. **Custom Theme**: Port Neovim's custom themes (cursor-dark, hexxa-dark) to Helix

## Troubleshooting

### LSP not working

1. Check if LSP server is installed: `which <lsp-server-name>`
2. Check Helix health: `hx --health <language>`
3. View LSP logs: `:log-open`

### Scripts not executing

1. Ensure scripts are executable: `chmod +x ~/.config/helix/scripts/*.sh`
2. Check script paths in `config.toml`
3. Verify dependencies (git, clipboard tools, etc.)

### GitHub permalink not working

1. Verify you're in a git repository
2. Ensure git remote is configured: `git remote -v`
3. Check if running on GitHub (not GitLab, etc.)
4. Try manual mode

## Resources

- [Helix Documentation](https://docs.helix-editor.com/)
- [Helix GitHub](https://github.com/helix-editor/helix)
- [LSP Servers List](https://microsoft.github.io/language-server-protocol/implementors/servers/)

## Migration from Neovim

If you're coming from the Neovim config in `~/.config/nvim/`, here's a quick reference:

| Neovim | Helix | Notes |
|--------|-------|-------|
| `<C-p>` | `Ctrl+p` | File picker |
| `<C-s>` | `Ctrl+s` | Symbol picker |
| `0` | `0` | Start of line |
| `$` | `$` | End of line |
| `K` (Shift+K) | `K` | Hover/documentation (Ctrl+d/Ctrl+u to scroll) |
| `<leader>gy` | `Space g y` | GitHub permalink |
| `<leader>gg` | `Space g g` | Lazygit |
| `<leader>ls` | `Space l s` | Document symbols |
| `<leader>lf` | `Space l f` | Format |
| `<leader>w` | `Space w` | Save |
| `<leader>q` | `Space q` | Quit |
| `<S-h>/<S-l>` | `H`/`L` | Buffer navigation |
| `gd` | `g d` | Go to definition |
| `gr` | `g r` | Go to references |
| `jk` (insert) | `jk` | Exit to normal mode |

Note: Helix uses `Space` as leader by default (not `,` or `\`).
