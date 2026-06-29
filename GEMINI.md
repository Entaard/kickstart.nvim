# Neovim Configuration (kickstart.nvim based)

## Project Overview

This directory contains a personal Neovim configuration, built upon `kickstart.nvim`. It serves as a lightweight and modular starting point for a customized Neovim setup, rather than a full-fledged distribution. The configuration is primarily written in Lua and leverages `lazy.nvim` for efficient plugin management.

The structure is organized into `xubi.core` for fundamental Neovim settings and `xubi.lazy` for defining and loading plugins.

## Building and Running

This is a Neovim configuration, so there isn't a traditional "build" process. To use this configuration:

1.  **Install Neovim:** Ensure you have the latest stable or nightly version of Neovim installed. Refer to the project's `README.md` for detailed installation instructions and external dependencies (e.g., `git`, `make`, `ripgrep`, Nerd Font).
2.  **Clone the Configuration:** Place this entire directory into your Neovim configuration path, typically `~/.config/nvim` on Linux/macOS or `%localappdata%\nvim\` on Windows. If you are forking this repository, clone your fork.
    ```sh
    git clone <your_fork_url> "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
    ```
3.  **Launch Neovim:** Open your terminal and run `nvim`. `lazy.nvim` will automatically install all defined plugins on the first launch.

## Development Conventions

*   **Language:** All configuration is written in Lua.
*   **Plugin Management:** `lazy.nvim` is used for declarative and performant plugin management. Plugins are defined in `lua/xubi/plugins/` and `lua/xubi/plugins/lsp/`.
*   **Modularity:** The configuration is split into logical modules under `lua/xubi/core/` for core settings (e.g., `options.lua`, `keymaps.lua`, `auto-cmd.lua`, `custom-commands.lua`) and `lua/xubi/plugins/` for plugin definitions.
*   **Leader Key:** The `<Space>` key is set as the leader key (`vim.g.mapleader = ' '`).
*   **Styling:** The `.stylua.toml` file indicates the use of `stylua` for Lua code formatting.
