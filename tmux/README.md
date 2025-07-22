

# Tmux Navigation Guide

## 🚀 Getting Started

### Start/Stop Tmux
```bash
tmux                          # Start new session
tmux new-session -s <name>    # Start named session
tmux attach -t <name>         # Attach to existing session
tmux list-sessions            # List all sessions
tmux kill-session -t <name>   # Kill specific session
tmux kill-server              # Kill all sessions
```

### Exit Tmux
```bash
exit                          # Close current pane/window
Ctrl+b d                      # Detach from session (keeps running)
```

---

## 🔑 Essential Key Bindings

**Prefix Key:** `Ctrl+b` (press and release, then press the command key)

### 🪟 Window Management
```bash
Ctrl+b c                      # Create new window
Ctrl+b ,                      # Rename current window
Ctrl+b w                      # Show window list
Ctrl+b u                      # Switch to window 1
Ctrl+b i                      # Switch to window 2  
Ctrl+b o                      # Switch to window 3
Ctrl+b p                      # Switch to window 4
Ctrl+b m                      # Go to previous window
```

### 📱 Pane Management (Splits)
```bash
Ctrl+b |                      # Create vertical split (side by side)
Ctrl+b -                      # Create horizontal split (top/bottom)
Ctrl+b M                      # Zoom/unzoom current pane (fullscreen toggle)
```

### 🧭 Pane Navigation
```bash
# With vim-tmux-navigator (if installed):
Ctrl+h                        # Move to left pane
Ctrl+j                        # Move to bottom pane
Ctrl+k                        # Move to top pane
Ctrl+l                        # Move to right pane

# Alternative navigation:
Ctrl+b + Arrow Keys           # Navigate between panes
```

### 📏 Pane Resizing
```bash
Ctrl+b Left                   # Resize pane left
Ctrl+b Right                  # Resize pane right
Ctrl+b Up                     # Resize pane up
Ctrl+b Down                   # Resize pane down
```

### 🎯 Pane Layouts
```bash
Ctrl+b J                      # Even horizontal layout
Ctrl+b K                      # Even vertical layout
Ctrl+b Ctrl+j                 # Main horizontal layout
Ctrl+b Ctrl+k                 # Main vertical layout
```

---

## 🎮 Session Management

### 📋 Session Selector
```bash
Ctrl+b T                      # Open advanced session selector (sesh + fzf)
Ctrl+b s                      # Show session list (sorted by time)
Ctrl+b Space                  # Switch to last session
```

### 🔄 Session Navigation
```bash
Ctrl+b (                      # Switch to previous session
Ctrl+b )                      # Switch to next session
```

---

## 📝 Copy Mode (Visual Mode)

### Enter/Exit Copy Mode
```bash
Ctrl+b v                      # Enter copy mode
Escape                        # Exit copy mode
```

### Copy Mode Navigation
```bash
v                             # Start visual selection
y                             # Copy selection
gh                            # Go to beginning of line
gl                            # Go to end of line
/                             # Search forward
?                             # Search backward
```

---

## 🔧 Configuration & Utilities

### Reload Configuration
```bash
Ctrl+b r                      # Reload tmux configuration
```

### Synchronize Panes
```bash
Ctrl+b Q                      # Toggle pane synchronization (send commands to all panes)
```

### Command Mode
```bash
Ctrl+b :                      # Enter command mode
```

#### Useful Commands in Command Mode:
```bash
:split-window -h              # Create horizontal split
:split-window -v              # Create vertical split
:kill-pane                    # Kill current pane
:swap-pane -U                 # Swap with pane above
:swap-pane -D                 # Swap with pane below
```

---

## 🚀 Quick Sessionizer Shortcuts

*These are custom shortcuts from your configuration:*

```bash
Ctrl+b f                      # Open tmux sessionizer
Ctrl+b Ctrl+u                 # Quick access to dotfiles
Ctrl+b Ctrl+h                 # Quick access to home directory
```

---

## 💡 Pro Tips

1. **Check if you're in tmux:** Look for the status bar at the bottom of your terminal
2. **Prefix key timing:** Press `Ctrl+b`, release, then press the command key
3. **Pane indicators:** Use `Ctrl+b q` to show pane numbers
4. **Mouse support:** Click on panes to switch between them
5. **Status line:** Shows current session, window, and pane information

---

## 🐛 Troubleshooting

### Splits not working?
1. Make sure you're inside a tmux session (check for status bar)
2. Press `Ctrl+b`, release completely, then press `|` or `-`
3. Try using command mode: `Ctrl+b :split-window -h`

### Key bindings not working?
1. Check if tmux config is loaded: `Ctrl+b r`
2. Verify you're in the right session: `tmux list-sessions`
3. Test with default bindings: `Ctrl+b %` (horizontal) or `Ctrl+b "` (vertical)

### Can't see tmux status bar?
- Your terminal might not be tall enough
- Try resizing the terminal window
- Check if you're actually in a tmux session: `echo $TMUX`

---

## 📚 Additional Resources

- **Configuration file:** `~/.tmux.conf`
- **Session management:** Use the session selector (`Ctrl+b T`) for advanced session switching
- **Custom layouts:** Check `tmux/layouts/` directory for predefined layouts
- **Scripts:** See `tmux/tools/` for additional tmux utilities

---

*This guide is based on your custom tmux configuration. Some shortcuts may differ from default tmux installations.*
