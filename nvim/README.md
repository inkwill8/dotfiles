# Neovim Configuration

A modern Neovim setup managed by `lazy.nvim`. This configuration is designed for a streamlined development experience, with a focus on LSP integration, autocompletion, and efficient file navigation.

## Features

-   **Plugin Manager**: Uses `lazy.nvim` for plugin management.
-   **LSP**: Full Language Server Protocol support via `nvim-lspconfig` for diagnostics, code actions, and more.
-   **Autocompletion**: Code completion provided by `nvim-cmp`.
-   **Debugging**: Integrated debugging support with `nvim-dap`.
-   **File Explorer**: A clean and functional file explorer with `neo-tree.nvim`.
-   **Fuzzy Finder**: `telescope.nvim` for quickly finding files, text, and more.
-   **Syntax Highlighting**: Enhanced syntax highlighting with `nvim-treesitter`.
-   **Statusline**: A minimal and informative statusline from `lualine.nvim`.
-   **Diagnostics**: `trouble.nvim` provides a pretty list for diagnostics.
-   **Colorscheme**: Includes `everforest` and a disabled `catppuccin`.

## Keybindings

Here is a list of the main keybindings for your reference. The leader key is `space`.

| Keybinding      | Mode   | Description                                |
| --------------- | ------ | ------------------------------------------ |
| `<C-n>`         | Normal | Toggle file explorer (Neo-tree)            |
| `<leader>ff`    | Normal | Find files (Telescope)                     |
| `<leader>fg`    | Normal | Live grep (Telescope)                      |
| `<leader>fb`    | Normal | List open buffers (Telescope)              |
| `<leader>fh`    | Normal | Search help tags (Telescope)               |
| `gd`            | Normal | Go to definition (LSP)                     |
| `gD`            | Normal | Go to declaration (LSP)                    |
| `gi`            | Normal | Go to implementation (LSP)                 |
| `gr`            | Normal | Show references (LSP)                      |
| `K`             | Normal | Show hover documentation (LSP)             |
| `<space>ca`     | Normal | Show code actions (LSP)                    |
| `<space>rn`     | Normal | Rename symbol (LSP)                        |
| `<space>f`      | Normal | Format code (LSP)                          |
| `<leader>xx`    | Normal | Toggle diagnostics list (Trouble)          |
| `<leader>xw`    | Normal | Toggle workspace diagnostics (Trouble)     |
| `<leader>xd`    | Normal | Toggle document diagnostics (Trouble)      |
| `<leader>db`    | Normal | Toggle breakpoint (DAP)                    |
| `<leader>dc`    | Normal | Continue execution (DAP)                   |
| `<leader>di`    | Normal | Step into (DAP)                            |
| `<leader>dj`    | Normal | Step over (DAP)                            |
| `<leader>dk`    | Normal | Step out (DAP)                             |
| `<Tab>`         | Insert | Select next completion item                |
| `<S-Tab>`       | Insert | Select previous completion item            |
| `<CR>`          | Insert | Confirm completion                         |
| `<C-Space>`     | Insert | Trigger completion                         |
