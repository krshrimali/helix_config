# Helix Productivity Guide

Based on latest Helix features (25.07+) and community best practices.

## 🎯 New Features Added to Your Config

### 1. **Relative Line Numbers**
```toml
line-number = "relative"
```

**Why**: Jump to any line quickly with `<number>j` or `<number>k`
**Example**: `15j` jumps 15 lines down

### 2. **Scrolloff (Context Lines)**
```toml
scrolloff = 8
```

**Why**: Keeps 8 lines visible above/below cursor for better context
**Benefit**: Never lose track of where you are in the file

### 3. **Rulers (Column Guides)**
```toml
rulers = [80, 120]
```

**Why**: Visual guides at 80 and 120 columns
**Use**: Keep line lengths in check (80 for docstrings, 120 for code)

### 4. **Smart Search**
```toml
[editor.search]
smart-case = true
wrap-around = true
```

**Smart-case**: Case-insensitive unless you type uppercase
- `/foo` matches `foo`, `Foo`, `FOO`
- `/Foo` matches only `Foo`

**Wrap-around**: Search wraps to beginning when reaching end

### 5. **Auto-Pairs**
```toml
[editor.auto-pairs]
'(' = ')'
'{' = '}'
```

**What**: Automatically closes brackets, quotes, etc.
**Tip**: Type `(` and it adds `)` automatically

### 6. **Improved Indent Guides**
```toml
skip-levels = 1
```

**What**: Skips first indent level for cleaner appearance
**Benefit**: Less visual clutter while maintaining structure

---

## 🔥 Essential Productivity Keybindings

### Jump List Navigation (New!)
```
Space j - Jump backward (previous location)
Space J - Jump forward (next location)
```

**When to use**:
- After going to definition (`g d`), jump back with `Space j`
- Navigate through your editing history
- Works across files!

### File Explorer / Picker
```
Space e - File picker (fuzzy search files)
Space E - Open current directory in Finder/file manager
Ctrl+p  - File picker (alternative, like Neovim)
```

### View Mode (Sticky) - New!
```
Z z - Center view on cursor
Z t - Align cursor to top
Z b - Align cursor to bottom
Z j - Scroll down
Z k - Scroll up
```

**Why "Sticky"**: Stays in view mode until you press Escape
**Use case**: Reading code without accidentally editing

### Quick Config Access
```
Ctrl+e - Open config.toml directly
```

### Toggle Options
```
Space o w - Toggle soft wrap
Space o r - Toggle relative line numbers
Space o l - Toggle cursorline
Space o d - Toggle inlay hints
Space o i - Toggle indent guides
```

---

## 💡 Helix Power Features You Should Know

### 1. Multiple Cursors (Game Changer!)

**Basic Usage**:
```
C - Add cursor below
Alt+C - Add cursor above
s - Select matches (creates cursor for each)
Alt+s - Split selection on newlines
```

**Workflow Example**:
```
1. Search for "foo": /foo
2. Press Alt+s to split each match into separate selection
3. Now you have multiple cursors on each "foo"
4. Type to edit all at once!
```

**More Advanced**:
```
% - Select entire file
s - Enter search pattern
Alt+s - Split selections
c - Change (delete and enter insert mode)
```

### 2. Text Objects

**Syntax**: `<operator><i/a><object>`

**Objects**:
- `w` - word
- `(`, `)` - parentheses
- `{`, `}` - braces
- `[`, `]` - brackets
- `"`, `'` - quotes
- `f` - function
- `c` - class/comment
- `p` - paragraph

**Examples**:
```
mi( - Select inside parentheses
ma{ - Select around braces (includes braces)
mif - Select inside function
mac - Select around class
ci" - Change inside quotes
da( - Delete around parentheses
```

### 3. Surround

**Add surround**:
```
ms<char> - Surround selection with <char>
```

**Examples**:
```
1. Select word: miw
2. Press ms(
3. Word is now surrounded: (word)
```

**Change surround**:
```
mr<old><new> - Replace old surround with new
```

**Delete surround**:
```
md<char> - Delete surrounding <char>
```

**Examples**:
```
"hello" → cursor inside
md"     → hello (removed quotes)

(foo)   → cursor inside
mr()    → [foo] (changed () to [])
```

### 4. Registers

**What**: Named storage for yanked/deleted text

**Syntax**: `"<register><command>`

**Examples**:
```
"ay  - Yank to register 'a'
"ap  - Paste from register 'a'
"hy  - Yank to register 'h'
"md  - Delete to register 'm'
```

**Special registers**:
- `"` - Default register
- `+` - System clipboard
- `*` - Primary selection (Linux)
- `/` - Last search pattern

**Use case**: Copy multiple things without losing them
```
1. Select first thing, "ay
2. Select second thing, "by
3. Paste first: "ap
4. Paste second: "bp
```

### 5. Repeat Last Motion
```
Alt+. - Repeat last f, F, t, T motion
```

**Example**:
```
fi  - Find next 'i'
;   - Find next 'i' (built-in repeat)
,   - Find previous 'i'
```

### 6. Advanced Selection

**Expand/shrink selection**:
```
Alt+p - Expand selection to parent (tree-sitter aware)
Alt+o - Expand to outer object
Alt+i - Shrink to inner object
```

**Align selections**:
```
& - Align selections (useful with multiple cursors)
```

**Example** (aligning assignments):
```
foo = 1
longname = 2
x = 3

1. Select lines
2. Press s, type =
3. Press &
Result:
foo      = 1
longname = 2
x        = 3
```

---

## 🚀 Workflow Examples

### Workflow 1: Refactor Function Name

```
1. /old_name<Enter>  - Search for function
2. %                  - Select all content
3. s                  - Start selection
4. old_name<Enter>    - Pattern to select
5. c                  - Change
6. new_name<Esc>      - Type new name and exit
```

### Workflow 2: Add Quotes to Multiple Lines

```
1. Select lines (v + j/k)
2. ms"  - Surround with quotes
```

### Workflow 3: Delete All Comments in Selection

```
1. Select region (v + movement)
2. s//  - Search for //.*  (regex)
3. d    - Delete all matches
```

### Workflow 4: Navigate Large Codebase

```
1. Ctrl+s          - Symbol picker (find class/function)
2. Type "MyClass"  - Fuzzy search
3. Enter           - Jump to definition
4. gd              - Go to definition from usage
5. Space j         - Jump back
6. gr              - See all references
```

### Workflow 5: Multi-Cursor Editing

```
# Add console.log to multiple lines
1. %               - Select all
2. s^<Enter>       - Select start of each line
3. ilog.debug(""); - Insert at all cursors
4. Esc, b, ms"     - Move back and surround with quotes
```

---

## 📊 Performance Tips

### 1. Use Relative Line Numbers
Instead of `20j`, see the number and jump: `15j`

### 2. Use Tree-sitter Objects
`mif` selects entire function faster than manual selection

### 3. Use Registers for Complex Operations
Store intermediate results in registers instead of copy-paste-copy-paste

### 4. Use Multiple Cursors
One operation on 10 places instead of repeating 10 times

### 5. Use Surround
`ms"` faster than `i"<Esc>A"<Esc>`

---

## 🎨 Customization Ideas

### Color Scheme Switching

Add to config:
```toml
[keys.normal.space.t]
"1" = ":theme gruvbox_transparent"
"2" = ":theme gruvbox_dark_hard_transparent"
"3" = ":theme dracula_transparent"
```

Then `Space t 1` switches themes instantly

### Project-Specific Settings

Create `.helix/config.toml` in project root:
```toml
# Project-specific settings
[editor]
rulers = [100]  # Different ruler for this project
auto-format = false  # Don't auto-format in this project
```

### Language-Specific Keybindings

For Python projects, add to `languages.toml`:
```toml
[[language]]
name = "python"
# ... other settings ...

[language.keybindings.normal]
# Python-specific keybindings here
```

---

## 🔧 Advanced LSP Features

### Inlay Hints
```
Space o d - Toggle type hints
```

Shows inline type annotations (if LSP supports it)

### Symbol Navigation
```
Ctrl+s - Document symbols
gd     - Go to definition
gr     - Go to references
gi     - Go to implementation
gy     - Go to type definition
```

### Diagnostics
```
Space d d - Show all diagnostics
]d        - Next diagnostic
[d        - Previous diagnostic
Space l j - Next diagnostic (alternative)
Space l k - Previous diagnostic (alternative)
```

---

## 📚 Learning Resources

- [Helix Documentation](https://docs.helix-editor.com/)
- [Multiple Cursors Tutorial](https://github.com/helix-editor/helix/wiki/2.-Tutorial:-Multiple-Cursors)
- [Text Objects Guide](https://docs.helix-editor.com/textobjects.html)
- [Surround Usage](https://docs.helix-editor.com/surround.html)
- [Registers Documentation](https://docs.helix-editor.com/registers.html)

---

## 🎯 Challenge: Try These Today

1. **Use relative line numbers**: Jump 10 lines down with `10j`
2. **Use multiple cursors**: Change all instances of a variable in a function
3. **Use surround**: Add quotes to 5 strings at once
4. **Use registers**: Store 3 different things and paste them later
5. **Use text objects**: `mif` to select entire function, then `y` to copy
6. **Use jump list**: Navigate forward and back through your editing history

---

## 💪 Power User Combos

### Combo 1: Extract Variable
```
1. Select expression: v + movement
2. "ay (yank to register 'a')
3. c (change)
4. variable_name<Esc>
5. Go to top of function
6. O (open line above)
7. variable_name = <Ctrl+r>a
```

### Combo 2: Rename All in Function
```
1. mif (select function)
2. s old_name<Enter>
3. c new_name<Esc>
```

### Combo 3: Align Columns
```
1. Select lines
2. s pattern<Enter>
3. &
```

---

## 🌟 Coming Soon (Future Helix)

Based on current development:
- Plugin system (in discussion)
- `goto_hover` command (PR #12208)
- More LSP features
- Better multi-file editing

---

## Summary: Top 10 Productivity Boosters

1. ✅ **Relative line numbers** - Jump anywhere fast
2. ✅ **Scrolloff** - Better context while editing
3. ✅ **Multiple cursors** - Edit multiple locations at once
4. ✅ **Text objects** - Select intelligently (functions, classes, etc.)
5. ✅ **Surround** - Add/change/delete surrounding characters
6. ✅ **Registers** - Store multiple clipboards
7. ✅ **Jump list** - Navigate editing history (Space j/J)
8. ✅ **Smart search** - Case-smart, wrap-around
9. ✅ **Auto-pairs** - Automatic bracket closing
10. ✅ **Tree-sitter objects** - Language-aware selection

Master these and you'll be 10x more productive! 🚀
