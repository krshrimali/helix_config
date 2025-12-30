# Git Integration in Helix

Complete guide to Git operations configured in your Helix setup.

## Available Git Commands

### 1. Quick Git Blame (Current Line)
**Keybinding**: `g b`

Shows who last modified the line under your cursor.

```
Command: :sh git blame -L %{cursor_line},+1 %{buffer_name}
```

**Output example**:
```
^ba3558e (Kushashwa Ravi Shrimali 2024-09-05 20:25:39 +0530 1) -- Modes
```

**When to use**: Quick check of who/when a specific line was modified.

---

### 2. Git Blame (Entire File)
**Keybinding**: `Space g b`

Shows git blame for the entire current file.

```
Command: :sh git blame %{buffer_name}
```

**Output**: Full blame output showing all lines with their authors and dates.

**When to use**: Understanding the full history of a file.

---

### 3. Git Diff (Current File)
**Keybinding**: `Space g d`

Shows git diff for the current file.

```
Command: :sh git diff %{buffer_name}
```

**Output**: Diff showing changes in the current file (unstaged changes).

**When to use**: Review changes before committing.

---

### 4. Git Status
**Keybinding**: `Space g s`

Shows git status for the repository.

```
Command: :sh git status
```

**Output**: Standard git status output.

**When to use**: Check overall repository status.

---

### 5. GitHub Permalink
**Keybinding**: `Space g y` (Normal and Select mode)

Generates a GitHub permanent link for the current line or selection.

```
Command: :sh ~/.config/helix/scripts/github_permalink.sh %{buffer_name} %{selection_line_start} %{selection_line_end}
```

**Features**:
- Uses current commit SHA (permanent link, won't break if file changes)
- Supports single line or line range selection
- Automatically copies to clipboard
- Works with both SSH and HTTPS remotes

**Output example**:
```
https://github.com/krshrimali/neovim/blob/f52bd796280d3b2b580793945d32d3ef90721c5e/lua/user/keymaps.lua#L42-L45
```

**Usage**:
1. **Single line**: Position cursor and press `Space g y`
2. **Line range**: Select lines (visual mode with `v`, then navigate) and press `Space g y`

**When to use**: Sharing code snippets, documenting issues, code reviews.

---

### 6. Lazygit
**Keybinding**: `Space g g`

Opens Lazygit in a new terminal window.

```
Command: :sh ~/.config/helix/scripts/git_lazygit.sh
```

**Features**:
- Full interactive git interface
- Opens in iTerm2 or Terminal.app (macOS)
- Starts in the repository root

**When to use**: Complex git operations (staging, committing, merging, rebasing).

---

## How It Works

### Helix Shell Expansions

Helix provides special variables that can be used in shell commands:

- `%{buffer_name}` - Current file path (relative to working directory)
- `%{cursor_line}` - Current line number (1-indexed)
- `%{selection_line_start}` - Start line of selection
- `%{selection_line_end}` - End line of selection

These are expanded before running the shell command.

**Example**:
```toml
":sh git blame -L %{cursor_line},+1 %{buffer_name}"
```

If cursor is on line 42 in `src/main.rs`, this expands to:
```bash
git blame -L 42,+1 src/main.rs
```

### GitHub Permalink Script

Location: `~/.config/helix/scripts/github_permalink.sh`

**What it does**:
1. Takes three arguments: file path, start line, end line
2. Finds git repository root
3. Gets current commit SHA
4. Extracts GitHub remote URL
5. Constructs permalink with SHA and line numbers
6. Copies to clipboard (using `pbcopy` on macOS)

**Why use commit SHA?**
Permanent links use the commit SHA instead of branch name, so the link will always point to the exact version of the code, even if the file changes later.

---

## Usage Examples

### Example 1: Quick Line Blame
```
1. Open file: hx src/main.rs
2. Navigate to line 42
3. Press: g b
4. See: ^abc123d (John Doe 2024-01-15) some code
```

### Example 2: Share Code Snippet
```
1. Open file: hx README.md
2. Navigate to line 10
3. Select lines 10-15 (press v, then move down)
4. Press: Space g y
5. Paste link: https://github.com/.../README.md#L10-L15
```

### Example 3: Review Changes
```
1. Edit some files
2. Press: Space g d (to see diff)
3. Press: Space g s (to see status)
4. Press: Space g g (to open Lazygit for staging/committing)
```

---

## Troubleshooting

### "Not in a git repository"
**Issue**: Git commands fail with "not a git repository" error.

**Solution**: Ensure you're editing a file inside a git repository. Helix uses the current file's directory to find the git root.

### "No such remote"
**Issue**: GitHub permalink fails because no remote is configured.

**Solution**:
```bash
cd /path/to/repo
git remote add origin git@github.com:user/repo.git
```

### Blame shows "^" prefix
The `^` prefix in git blame indicates the line was in the initial commit of the file.

### Permalink not copied
**Issue**: Permalink generated but not in clipboard.

**Check**:
1. On macOS: `pbcopy` should be available (built-in)
2. On Linux: Install `xclip` or `wl-clipboard`
3. Verify: Run `pbpaste` (macOS) or `xclip -o` (Linux) to check clipboard

### Git commands show in statusline but no output
This is normal for Helix. The command output appears in the statusline briefly. For longer output (like full blame), you might want to run in a terminal:

```bash
cd /path/to/repo
git blame file.rs | less
```

---

## Tips & Tricks

### 1. Blame with Context
Instead of `g b` (one line), use `Space g b` to see full file blame for more context.

### 2. Diff Before Commit
Always run `Space g d` before committing to review your changes.

### 3. Permalink Workflow
- Review code
- Find interesting section
- Press `Space g y`
- Paste in PR comment/documentation

### 4. Lazygit for Complex Operations
Use `Space g g` to open Lazygit for:
- Interactive staging (stage specific lines)
- Commit with detailed messages
- Interactive rebase
- Merge conflict resolution
- Branch management

### 5. Compare with Remote
```bash
# In terminal
git diff origin/main HEAD
```

Then switch to Helix to navigate and edit.

---

## Configuration

All git keybindings are defined in `~/.config/helix/config.toml`:

```toml
# Quick git blame on current line
[keys.normal.g]
b = ":sh git blame -L %{cursor_line},+1 %{buffer_name}"

# Git operations with Space leader
[keys.normal.space.g]
g = ":sh ~/.config/helix/scripts/git_lazygit.sh"
b = ":sh git blame %{buffer_name}"
d = ":sh git diff %{buffer_name}"
s = ":sh git status"
y = ":sh ~/.config/helix/scripts/github_permalink.sh %{buffer_name} %{selection_line_start} %{selection_line_end}"

# Also works in select mode
[keys.select.space.g]
y = ":sh ~/.config/helix/scripts/github_permalink.sh %{buffer_name} %{selection_line_start} %{selection_line_end}"
```

---

## Comparison with Neovim Setup

| Feature | Neovim | Helix | Notes |
|---------|--------|-------|-------|
| Git blame line | `glb` | `g b` | Helix version shows inline |
| Git blame file | `<leader>glf` | `Space g b` | Both show full blame |
| GitHub permalink | `<leader>gy` | `Space g y` | Helix uses native variables |
| Lazygit | `<leader>gg` | `Space g g` | Both open in new terminal |
| Git diff | Various | `Space g d` | Helix simpler |
| Git status | Various | `Space g s` | Helix simpler |

---

## Resources

- [Helix Command Line Documentation](https://docs.helix-editor.com/command-line.html) - Shell expansions
- [Helix Commands](https://docs.helix-editor.com/commands.html) - Available commands
- [Git Blame Documentation](https://git-scm.com/docs/git-blame) - Git blame options

---

## Testing Your Setup

Create a test file in a git repository and try all commands:

```bash
# 1. Create test file
cd ~/your-git-repo
echo "test line 1" > test.txt
git add test.txt && git commit -m "test"

# 2. Open in Helix
hx test.txt

# 3. Test commands:
# - Press g b (should show blame for line 1)
# - Press Space g b (should show full blame)
# - Press Space g y (should copy permalink)
# - Paste to verify: Cmd+V
# - Press Space g g (should open Lazygit)
```

All commands should work without errors. If any fail, check the troubleshooting section above.
