# Helix Keybindings Quick Reference

## Navigation

### Line Movement (Vim-like)
- `0` - Start of line
- `$` - End of line
- `^` - First non-whitespace character
- `w` - Next word
- `b` - Previous word
- `e` - End of word

### Buffer Navigation
- `H` - Previous buffer
- `L` - Next buffer

### File Navigation
- `Ctrl+p` - File picker
- `Ctrl+s` - Symbol picker (LSP tree/outline)

## LSP Features

### Documentation
- `K` - Show hover/documentation
  - `Ctrl+d` - Scroll down in popup
  - `Ctrl+u` - Scroll up in popup
  - `Esc` - Close popup
  - **Note**: Cannot focus into popup (use `g d` to view source instead)

### Code Navigation
- `g d` - Go to definition
- `g r` - Go to references
- `Space l i` - Go to implementation
- `Space l t` - Go to type definition

### Code Editing
- `Space l f` - Format code
- `Space l a` - Code actions
- `Space l r` - Rename symbol
- `Space l j` - Next diagnostic
- `Space l k` - Previous diagnostic

## Git Operations

- `g b` - Git blame current line (quick inline blame)
- `Space g g` - Open Lazygit
- `Space g y` - Copy GitHub permalink (current line or selection)
- `Space g b` - Git blame entire file
- `Space g d` - Git diff current file
- `Space g s` - Git status

## File Operations

- `Space w` - Save file
- `Space q` - Quit
- `Space Q` - Force quit
- `Space f f` - Find files
- `Space f b` - Buffer picker

## Search

- `Space / /` - Global search (live grep)
- `/` - Search in file
- `n` / `N` - Next/previous match

## Editing

### Insert Mode
- `jk` - Exit to normal mode
- `Esc` - Exit to normal mode

### Visual/Select Mode
- `v` - Enter select mode
- `0` - Extend selection to line start
- `$` - Extend selection to line end
- `<` - Indent left (keep selection)
- `>` - Indent right (keep selection)

### Text Objects
- `+` - Increment number
- `-` - Decrement number

## Window/Splits

- `Space k s` - Horizontal split
- `Space k v` - Vertical split
- `Ctrl+w w` - Cycle between windows

## Buffers

- `Space b b` - Buffer picker
- `Space b d` - Close buffer
- `Space b n` - Next buffer
- `Space b p` - Previous buffer

## Options Toggle

- `Space o w` - Toggle soft wrap
- `Space o r` - Toggle line numbers
- `Space o l` - Toggle cursor line

## Diagnostics

- `Space d d` - Show diagnostics
- `Space d f` - File diagnostics
- `Space d w` - Workspace diagnostics

## Pro Tips

1. **Documentation Reading**: Press `K` to view hover docs, use `Ctrl+d`/`Ctrl+u` to scroll. For full interaction, use `g d` to jump to the definition source
2. **Symbol Navigation**: `Ctrl+s` opens a fuzzy-searchable symbol tree - great for exploring unfamiliar code
3. **GitHub Permalink**: Select lines in visual mode, then `Space g y` to copy a permalink with line range
4. **Quick Format**: `Space l f` formats the current file (or auto-format is enabled on save)
5. **Buffer Quick Switch**: `H` and `L` are much faster than `:buffer-next` for rapid buffer switching
