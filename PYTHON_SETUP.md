# Python Setup for Helix

Your Helix editor is configured with the latest and fastest Python tooling from Astral.

## Installed Tools

### 1. **ty** - Type Checker
- **Version**: 0.0.8 (installed)
- **Location**: `/Users/krshrimali/.local/bin/ty`
- **What it does**:
  - Extremely fast Python type checking (10x-60x faster than mypy/Pyright)
  - Go-to-definition, find references, auto-complete
  - Inlay hints for types
  - Semantic syntax highlighting
- **Released**: December 2025 (currently in beta)
- **From**: Astral (creators of ruff and uv)

### 2. **ruff** - Linter & Formatter
- **Version**: 0.14.10 (installed)
- **Location**: `/opt/homebrew/bin/ruff`
- **What it does**:
  - Lightning-fast linting (replaces flake8, pylint, pycodestyle)
  - Code formatting (replaces black)
  - Auto-fixes for many issues
  - Import sorting (replaces isort)

## Configuration

In `~/.config/helix/languages.toml`:

```toml
[[language]]
name = "python"
language-servers = ["ty", "ruff"]
formatter = { command = "ruff", args = ["format", "-"] }
auto-format = true

[language-server.ty]
command = "ty"
args = ["server"]

[language-server.ruff]
command = "ruff"
args = ["server", "--preview"]
```

## How They Work Together

Both LSP servers run simultaneously in Helix:

- **ty** provides:
  - Type checking diagnostics
  - Go-to-definition for typed code
  - Auto-completion with type information
  - Inlay type hints
  - Symbol renaming

- **ruff** provides:
  - Linting diagnostics (code style, unused imports, etc.)
  - Code formatting
  - Quick fixes for common issues
  - Import organization

## Using in Helix

### Type Checking
Position your cursor on any symbol and press `K` to see type information:
```python
def add(a: int, b: int) -> int:
    return a + b

result = add(1, 2)  # Press K on 'add' or 'result'
```

### Diagnostics
Both ty and ruff will show diagnostics inline:
- Red squiggles: Type errors (from ty)
- Yellow squiggles: Linting issues (from ruff)
- Press `Space l j` / `Space l k` to jump between diagnostics

### Formatting
- Auto-format on save: Enabled
- Manual format: `Space l f`

### Code Actions
Press `Space l a` on a diagnostic to see available fixes:
- Auto-import missing modules
- Remove unused imports
- Fix formatting issues
- Apply type narrowing suggestions

## Testing Your Setup

Check LSP server status:
```bash
hx --health python
```

Expected output:
```
Configured language servers:
  ✓ ty: /Users/krshrimali/.local/bin/ty
  ✓ ruff: /opt/homebrew/bin/ruff
Configured formatter:
  ✓ /opt/homebrew/bin/ruff
```

## Command Line Usage

### ty
```bash
# Type check a file
ty check myfile.py

# Type check entire project
ty check .

# Watch mode
ty check --watch .
```

### ruff
```bash
# Lint a file
ruff check myfile.py

# Format a file
ruff format myfile.py

# Auto-fix issues
ruff check --fix myfile.py
```

## Performance

Both tools are written in Rust and are extremely fast:

- **ty**: 10x-60x faster than Pyright, 500x faster than mypy on large codebases
- **ruff**: 10-100x faster than traditional Python linters

This means:
- Instant feedback as you type
- No lag when opening large Python files
- Fast project-wide type checking

## Troubleshooting

### ty not finding modules
If ty can't find your Python modules, make sure you're in the project root:
```bash
cd /path/to/your/project
hx myfile.py
```

### Virtual environment support
ty and ruff automatically detect virtual environments:
```bash
# Activate your venv first
source .venv/bin/activate
hx myfile.py
```

### Updating
```bash
# Update ty
uv tool upgrade ty

# Update ruff
brew upgrade ruff
```

## Resources

- [ty Documentation](https://docs.astral.sh/ty/)
- [ty GitHub](https://github.com/astral-sh/ty)
- [ruff Documentation](https://docs.astral.sh/ruff/)
- [Astral Blog: Announcing ty](https://astral.sh/blog/ty)

## Example: Type Error Detection

Create a file with a type error:
```python
def greet(name: str) -> str:
    return f"Hello, {name}!"

# This will show a ty error
result = greet(123)  # Expected str, got int
```

Open in Helix and you'll see:
1. Red squiggle under `123`
2. Press `K` to see: "Expected `str`, found `int`"
3. Press `Space l j` to jump to the diagnostic
4. Full error message in the status line

Enjoy lightning-fast Python development! ⚡
