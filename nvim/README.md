# Neovim Configuration Guide

This is a comprehensive Neovim setup with various plugins for enhanced development experience. Here's how to use the key features:

## Basic Navigation

- `j`/`k` - Smart line movement (handles wrapped lines)
- `Ctrl-u`/`Ctrl-d` - Scroll half page up/down (centered)
- `Ctrl-b`/`Ctrl-f` - Scroll full page up/down (centered)

## Leader Key Commands
The leader key is set to `Space`. Here are the main commands:

### File Operations
- `Space + w` - Save file
- `Space + s` - Source current file
- `Space + v` - Open Neovim config in Telescope
- `Space + m` - Run make
- `Space + o` - Open file explorer (Oil.nvim) in float mode

### Clipboard Operations
- `Space + y` - Copy to system clipboard
- `Space + Y` - Copy rest of line to system clipboard
- `Space + p` - Paste from system clipboard
- `Space + P` - Paste before cursor from system clipboard

### UI Features
- `Space + n` - Toggle No Neck Pain mode (centered editor)

## Plugin Features

### File Navigation (Oil.nvim)
- `Space + o` - Open file explorer
- `Ctrl-v` - Open in vertical split
- `Ctrl-s` - Open in horizontal split
- `Esc` - Close file explorer

### Code Formatting (conform.nvim)
Automatic formatting support for:
- Lua (stylua)
- Python (black)
- JavaScript/TypeScript (prettier)
- C++ (clang-format)
- Astro (prettier)

### Comments
- Uses Comment.nvim with context-aware commenting
- Supports multiple languages automatically

### LaTeX Support
The localleader key for LaTeX commands is `,` (comma). When editing LaTeX files:
- `,ll` - Start continuous compilation
- `,lk` - Stop compilation
- `,lv` - Open PDF viewer (Skim)
- `,lt` - Open table of contents
- `,le` - Show compilation errors

### Tailwind CSS Support
- `gK` - Show Tailwind CSS values
- Includes colorizer support for Tailwind classes

### Additional Features
- Line number display (relative + absolute)
- Smart case-sensitive search
- 2-space indentation by default
- No swap files
- Terminal color support
- Centered cursor line
- Visual whitespace indicators
- Remote development support (distant.nvim)

## Customization

The configuration is organized in the following structure:
- `lua/config/` - Core configurations
  - `options.lua` - Vim options
  - `mappings.lua` - Key mappings
  - `lazy.lua` - Plugin management
- `lua/plugins/` - Plugin-specific configurations

## Dependencies

Make sure you have these installed for full functionality:
- ripgrep (for search)
- A Nerd Font (for icons)
- Language servers (for LSP support)
- Formatters (black, prettier, stylua, etc.)

## Tips

1. Use `Space` as the leader key for general operations
2. Use `,` as the localleader for LaTeX-specific commands
3. The configuration automatically formats files on save
4. Clipboard operations are integrated with the system clipboard
5. File explorer uses Oil.nvim for a seamless experience

## Troubleshooting

If you encounter issues:
1. Check plugin health: `:checkhealth`
2. Ensure all dependencies are installed
3. Update plugins: `:Lazy update`
4. Check LSP status: `:LspInfo` 