# Neovim-config

This **Neovim** configuration is based on **LazyVim** + **lazy.nvim**, with the goal of providing an “IDE-like” environment for development and technical writing (code + LaTeX).

## What’s included

- **Plugin manager**: `lazy.nvim` (automatic bootstrap)
- **Base distro**: `LazyVim` (plugins, defaults, modular structure)
- **LSP** (via `nvim-lspconfig` + `mason.nvim`): Python, Julia, R, Rust, C/C++, Fortran, LaTeX, HTML, CSS (+ TS/Tailwind/Markdown extras)
- **DAP debugging**: Python (`debugpy`), C/C++/Rust (`codelldb`) with automatic UI
- **Testing**: `neotest` (Python + Rust adapters)
- **LaTeX**: `vimtex` + `latexmk` + SyncTeX, viewer **Okular**
- **Org mode**: `orgmode.nvim`
- **UI**: `neo-tree`, icons, `oasis.nvim` colorscheme, cursor beacon (`beacon.nvim`)
- **QoL**: consistent indentation, trim whitespace, auto-mkdir, auto-reload, safe format-on-save, terminal UX

---

## Requirements

- Recent **Neovim**
- **Git**
- **C/C++ compiler** (for Tree-sitter)
- **tree-sitter CLI**
- **Nerd Font** (optional, recommended)

### Recommended tools
- `ripgrep`, `fd`, `fzf`

### Language toolchains
- Python, Node/npm, Rust, Julia, R
- Debugging: `lldb`
- LaTeX: `latexmk`, TeX Live, **Okular**

---

## Installation

Place the config in `~/.config/nvim`. On first launch LazyVim and plugins are installed automatically.

---

## Configuration structure

(unchanged from the original)

---

## LSP, formatters, debugging, troubleshooting

See original sections — functionality is unchanged; only language has been translated.
