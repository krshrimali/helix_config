# Helix Quick Start Guide

Get productive in Helix in 5 minutes.

## 🚀 Essential Keybindings (Memorize These First)

### Basic Movement
```
h/j/k/l - Left/Down/Up/Right (like Vim)
w       - Next word
b       - Previous word
0       - Start of line
$       - End of line
gg      - Top of file
G       - End of file
```

### Editing
```
i       - Insert mode
a       - Append (insert after cursor)
o       - Open line below
O       - Open line above
c       - Change (delete and enter insert mode)
d       - Delete
y       - Yank (copy)
p       - Paste
u       - Undo
U       - Redo
```

### Exiting Insert Mode
```
Esc     - Exit to normal mode
jk      - Exit to normal mode (fast!)
```

### Selection (Helix's Superpower)
```
v       - Enter select mode
x       - Select line
%       - Select entire file
s       - Select (search and select matches)
Alt+s   - Split selections
```

### File Operations
```
Ctrl+p     - File picker (fuzzy find)
Space w    - Save file
Space q    - Quit
Space Q    - Force quit
Ctrl+e     - Open config
```

### Search
```
/       - Search forward
?       - Search backward
n       - Next match
N       - Previous match
```

## 🎯 Power Features (Try These Next)

### Multiple Cursors
```
1. Search: /foo<Enter>
2. Split: Alt+s
3. Edit: c (change all at once)
```

### Text Objects (Game Changer!)
```
miw     - Select inside word
mi(     - Select inside parentheses
maf     - Select around function
cif     - Change inside function
da"     - Delete around quotes
```

### Surround
```
ms"     - Surround selection with "
mr(]    - Change () to []
md{     - Delete surrounding {}
```

### Jump List
```
Space j - Jump backward
Space J - Jump forward
gd      - Go to definition (creates jump)
gr      - Go to references
```

## 📋 Common Workflows

### 1. Edit Multiple Instances
```
1. % (select all)
2. s old_name<Enter> (select pattern)
3. c new_name<Esc> (change all)
```

### 2. Navigate Code
```
1. Ctrl+s (symbol picker)
2. Type function name
3. Enter (jump to it)
4. gd (go to definition if needed)
5. Space j (jump back)
```

### 3. Copy GitHub Link
```
1. Position cursor or select lines (v)
2. Space g y (copy permalink)
3. Paste anywhere (Cmd+V)
```

### 4. Format & Fix
```
Space l f   - Format code
Space l a   - Code actions (auto-fix)
Space l j   - Next diagnostic
```

## 🎨 Customization

### Change Theme
```
:theme gruvbox_transparent
:theme gruvbox_dark_hard_transparent
:theme dracula_transparent
```

### Toggle Options
```
Space o w   - Toggle word wrap
Space o r   - Toggle relative numbers
Space o d   - Toggle inlay hints
```

## 🐍 Python Specific

With ty + ruff configured:

```
K           - Show documentation
gd          - Go to definition
gr          - Find all references
Space l r   - Rename symbol
Space l f   - Format with ruff
Space l a   - Auto-fix issues
```

## 📝 Tips for Vim Users

### What's Different?
1. **Selection first**: Select, then act (not verb-then-noun)
2. **Multiple selections**: Native, not a plugin
3. **Tree-sitter**: Smart, syntax-aware selections
4. **No plugins**: Everything built-in

### Common Vim → Helix
```
Vim         Helix       Action
ci(         mi( then c  Change inside ()
vw          miw         Select word
dd          xd          Delete line
yy          xy          Copy line
}           ]p          Next paragraph
{           [p          Previous paragraph
:w          Space w     Save
:q          Space q     Quit
```

## 🎓 Learn More

- **PRODUCTIVITY.md** - Advanced features and workflows
- **KEYBINDINGS.md** - Complete keybinding reference
- **GIT_INTEGRATION.md** - Git workflows
- **README.md** - Full documentation

## ⚡ Challenge Yourself

Try these to get comfortable:

1. ✅ Open a file with `Ctrl+p`
2. ✅ Jump to a function with `Ctrl+s`
3. ✅ Select a word with `miw`
4. ✅ Surround it with quotes: `ms"`
5. ✅ Find all "foo" and change to "bar": `%` → `s foo` → `c bar`
6. ✅ Copy a GitHub permalink: `Space g y`
7. ✅ Use multiple cursors: Search `/pattern` → `Alt+s` → edit

## 🚨 Getting Stuck?

### Most Common Issues

**Can't exit insert mode?**
- Press `Esc` or `jk`

**Changes not saving?**
- `Space w` to save
- Check bottom status bar

**Can't find a file?**
- `Ctrl+p` then type partial name
- Fuzzy search works: "filea" matches "my_file_abc.py"

**LSP not working?**
- Check `:lsp-status`
- Verify language server installed: `hx --health python`

**Keybinding not working?**
- Check mode (Normal/Insert/Select)
- Look at bottom-left corner for mode

## 🎉 You're Ready!

You now know enough to be productive. The more you use Helix, the more muscle memory you'll build.

**Remember**: Helix is designed to have good defaults. You don't need to configure everything - just start coding!

Happy coding! 🚀
