# Mac Keyboard Setup for Linux VM

Complete guide for configuring Mac-style keyboard shortcuts and layout in your Linux VM via VNC.

## Overview

This setup transforms your Linux VM to use Mac-style keyboard shortcuts, making it feel natural for Mac users. All familiar shortcuts like Cmd+C, Cmd+V, Cmd+S work exactly as expected.

## Quick Setup

### Automatic Installation
```bash
# Run the automated setup script
chmod +x setup-mac-keyboard.sh
./setup-mac-keyboard.sh
```

### Manual Installation
```bash
# 1. Install required packages
sudo apt install -y xbindkeys xvkbd

# 2. Copy configuration files
cp mac-keyboard/.xbindkeysrc ~/
cp mac-keyboard/.Xmodmap ~/
cp mac-keyboard/mac-keyboard.desktop ~/.config/autostart/

# 3. Apply immediately (if in X session)
xmodmap ~/.Xmodmap
xbindkeys
```

## Mac Shortcuts Available

### Core Operations
| Mac Shortcut | Function | Linux Equivalent |
|--------------|----------|------------------|
| `Cmd+C` | Copy | `Ctrl+C` |
| `Cmd+V` | Paste | `Ctrl+V` |
| `Cmd+X` | Cut | `Ctrl+X` |
| `Cmd+A` | Select All | `Ctrl+A` |
| `Cmd+Z` | Undo | `Ctrl+Z` |
| `Cmd+Shift+Z` | Redo | `Ctrl+Shift+Z` |

### File Operations
| Mac Shortcut | Function | Linux Equivalent |
|--------------|----------|------------------|
| `Cmd+S` | Save | `Ctrl+S` |
| `Cmd+O` | Open | `Ctrl+O` |
| `Cmd+N` | New | `Ctrl+N` |
| `Cmd+P` | Print | `Ctrl+P` |
| `Cmd+Q` | Quit | `Ctrl+Q` |

### Navigation & Search
| Mac Shortcut | Function | Linux Equivalent |
|--------------|----------|------------------|
| `Cmd+F` | Find | `Ctrl+F` |
| `Cmd+R` | Refresh | `Ctrl+R` |
| `Cmd+T` | New Tab | `Ctrl+T` |
| `Cmd+Shift+T` | Reopen Tab | `Ctrl+Shift+T` |

### Text Formatting
| Mac Shortcut | Function | Linux Equivalent |
|--------------|----------|------------------|
| `Cmd+B` | Bold | `Ctrl+B` |
| `Cmd+I` | Italic | `Ctrl+I` |
| `Cmd+U` | Underline | `Ctrl+U` |

### Window Management
| Mac Shortcut | Function | Linux Equivalent |
|--------------|----------|------------------|
| `Cmd+W` | Close Window | `Ctrl+W` |
| `Cmd+M` | Minimize | `Ctrl+M` |
| `Cmd+H` | Hide | `Ctrl+H` |

## Key Remapping Details

### Physical Key Changes
- **Left Alt** → **Super (Cmd)** key
- **Left Super** → **Alt (Option)** key  
- **Right Alt** → **Super (Cmd)** key
- **Right Super** → **Alt (Option)** key
- **Caps Lock** → **Control** key (optional Mac preference)

### How It Works
1. **xmodmap** remaps physical keys to match Mac layout
2. **xbindkeys** captures Cmd+key combinations and converts them to Ctrl+key
3. **Autostart** ensures configuration loads automatically with VNC session

## Configuration Files

### `~/.xbindkeysrc`
Contains all Mac-style keyboard shortcut mappings. Maps Super (Cmd) key combinations to their Control equivalents.

### `~/.Xmodmap`
Remaps physical keys to match Mac keyboard layout. Swaps Alt and Super keys.

### `~/.config/autostart/mac-keyboard.desktop`
Autostart file that applies keyboard configuration when VNC session starts.

## Integration with VNC

The Mac keyboard setup is automatically integrated into your VNC startup process via the updated `xstartup` script:

```bash
# Apply Mac keyboard layout and shortcuts
sleep 2
xmodmap $HOME/.Xmodmap &
xbindkeys &
```

## Troubleshooting

### Shortcuts Not Working
```bash
# Check if xbindkeys is running
ps aux | grep xbindkeys

# Restart xbindkeys
killall xbindkeys
xbindkeys
```

### Key Mapping Issues
```bash
# Reapply key mappings
xmodmap ~/.Xmodmap

# Check current key mappings
xmodmap -pm
```

### Reset to Default
```bash
# Kill xbindkeys
killall xbindkeys

# Reset key mappings
setxkbmap -layout us

# Remove autostart
rm ~/.config/autostart/mac-keyboard.desktop
```

## Compatibility

- ✅ **XFCE4** - Full compatibility
- ✅ **GNOME** - Full compatibility  
- ✅ **KDE** - Full compatibility
- ✅ **Most Applications** - Firefox, LibreOffice, VS Code, etc.
- ✅ **Terminal** - Works in terminal applications

## Advanced Configuration

### Adding Custom Shortcuts
Edit `~/.xbindkeysrc` to add new shortcuts:

```bash
# Example: Cmd+E for file manager
"thunar"
  m:0x40 + c:26
  Mod4 + e
```

### Modifier Key Reference
- `m:0x40` = Super (Cmd) key
- `m:0x41` = Super + Shift
- `m:0x44` = Super + Control
- `m:0x48` = Super + Alt

## Benefits

🍎 **Natural Mac Experience** - All muscle memory works  
⚡ **Seamless Workflow** - No mental context switching  
🔄 **Persistent** - Survives VNC reconnections  
🎯 **System-wide** - Works in all applications  
🛠️ **Customizable** - Easy to modify and extend  

## Support

If you encounter issues:
1. Check that `xbindkeys` and `xvkbd` are installed
2. Verify VNC session is using the updated `xstartup` script
3. Test key mappings with `xev` command
4. See main `troubleshooting.md` for VNC-related issues

---

**Enjoy your Mac-optimized Linux VM experience!** 🍎✨
