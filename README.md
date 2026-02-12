# Dotfiles

This repository contains my personal dotfiles for various applications, including Hyprland and Neovim.

## Hyprland Configuration

My Hyprland setup is organized for clarity and ease of management. The main configuration is split into several files, each handling a specific aspect of the environment.

-   `hyprland.conf`: The main entry point for the Hyprland configuration.
-   `hypridle.conf`: Configuration for `hypridle`, which manages session idling.
-   `hyprlock.conf`: Defines the look and behavior of the screen lock.
-   `hyprsunset.conf`: Configuration for `hyprsunset` to adjust screen temperature.
-   `mocha.conf`: Catppuccin Mocha theme colors.
-   `wallpaper-switcher.sh`: A script to manage and switch wallpapers.

The core configuration is further modularized in the `configs/` directory:

-   `aesthetics.conf`: Theming and visual settings.
-   `autostart.conf`: Applications and scripts to run on startup.
-   `environment-variables.conf`: Environment variables for the session.
-   `input.conf`: Input device settings (keyboard, mouse, touchpad).
-   `keybinds.conf`: Global keybindings for Hyprland.
-   `monitors.conf`: Monitor layout and resolution settings.
-   `permissions.conf`: D-Bus permissions for services like screen sharing.
-   `variables.conf`: General variables used throughout the configuration.
-   `window-rules.conf`: Rules for specific application windows.

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


## Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/dotfiles.git ~/.config/nvim
    ```

2.  **Install plugins**:
    Launch Neovim. `lazy.nvim` will automatically install all the plugins.

    ```bash
    nvim
    ```

## Customization

You can customize the configuration by editing the Lua files in the `lua/plugins/` directory. To add a new plugin, create a new file in this directory with the plugin's configuration.

For example, to add a new plugin `foo.nvim`:

```lua
-- lua/plugins/foo.lua
return {
  "user/foo.nvim",
  config = function()
    -- Your configuration for foo.nvim
  end,
}
```

To disable a plugin, you can either delete its file or add `.disabled` to the end of the filename (e.g., `catppuccin.lua.disabled`).
