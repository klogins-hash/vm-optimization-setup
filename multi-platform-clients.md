# Multi-Platform Client Setup

VNC client setup instructions for different operating systems and devices.

## Mac (Primary)

### VNC Viewer (Recommended)
```bash
# Install via Homebrew
brew install --cask vnc-viewer

# Or download from: https://www.realvnc.com/en/connect/download/viewer/
```

### Built-in Screen Sharing
```bash
# Open Finder → Go → Connect to Server (Cmd+K)
# Enter: vnc://YOUR-VM-IP:5901
# Or: vnc://localhost:5901 (if using SSH tunnel)
```

### Connection Settings
- **Server:** localhost:5901 (with SSH tunnel) or YOUR-VM-IP:5901
- **Quality:** Automatic or High
- **Enable:** "Warn when sending clipboard"

## Windows

### RealVNC Viewer
1. Download from: https://www.realvnc.com/en/connect/download/viewer/windows/
2. Install and run VNC Viewer
3. Connect to: YOUR-VM-IP:5901 or localhost:5901

### TigerVNC (Open Source)
```powershell
# Download from: https://github.com/TigerVNC/tigervnc/releases
# Install and connect to: YOUR-VM-IP:5901
```

### SSH Tunnel on Windows
```powershell
# Using PowerShell or Command Prompt
ssh -L 5901:localhost:5901 azureuser@YOUR-VM-IP

# Or use PuTTY:
# - Host: YOUR-VM-IP
# - Connection → SSH → Tunnels
# - Source port: 5901
# - Destination: localhost:5901
# - Add tunnel, then connect
```

## Linux

### Install VNC Viewer
```bash
# Ubuntu/Debian
sudo apt install tigervnc-viewer

# CentOS/RHEL
sudo yum install tigervnc

# Arch Linux
sudo pacman -S tigervnc
```

### Connect
```bash
# Command line
vncviewer YOUR-VM-IP:5901

# Or with SSH tunnel
ssh -L 5901:localhost:5901 azureuser@YOUR-VM-IP
vncviewer localhost:5901
```

## Mobile Devices

### iOS (iPhone/iPad)
1. **VNC Viewer** app from App Store (by RealVNC)
2. Add connection: YOUR-VM-IP:5901
3. Enter VNC password when prompted

### Android
1. **VNC Viewer** app from Google Play (by RealVNC)
2. **bVNC** (alternative open-source option)
3. Connect to: YOUR-VM-IP:5901

### Mobile Tips
- Use landscape mode for better desktop experience
- Enable "Mouse pointer" mode for precise clicking
- Adjust quality settings for mobile data usage

## Web Browser (Universal)

### noVNC Setup (Optional)
If you want browser-based access, run this on your Azure VM:

```bash
# Install noVNC
sudo apt install novnc websockify

# Start web VNC service
websockify --web=/usr/share/novnc/ 6080 localhost:5901

# Access via browser: https://YOUR-VM-IP:6080/vnc.html
```

### Browser Compatibility
- ✅ Chrome/Chromium
- ✅ Firefox
- ✅ Safari
- ✅ Edge
- ⚠️ Internet Explorer (limited support)

## Security Considerations

### SSH Tunnel (Recommended for All Platforms)
```bash
# Create secure tunnel before connecting
ssh -L 5901:localhost:5901 azureuser@YOUR-VM-IP

# Then connect VNC client to: localhost:5901
```

### VPN Access
If you have a VPN to your Azure network:
- Connect to VPN first
- Use private IP address of VM
- No need for SSH tunnel within VPN

### Firewall Rules
For direct VNC access (less secure):
- Azure NSG: Allow inbound TCP 5901
- VM firewall: `sudo ufw allow 5901`

## Performance Optimization by Platform

### Mac
- Use "Adaptive" quality in VNC Viewer
- Enable "Detect display configuration automatically"
- For Apple Silicon Macs: Use native VNC Viewer (better performance)

### Windows
- Adjust color depth: 16-bit for slower connections
- Enable compression in client settings
- Use wired connection when possible

### Mobile
- Use "Fast" quality setting on cellular
- Enable "Scale to fit screen"
- Use "Touch pointer" mode for touch interfaces

### Web Browser
- Use Chrome/Firefox for best WebGL support
- Enable hardware acceleration in browser
- Close other browser tabs to free memory

## Troubleshooting by Platform

### Mac Issues
```bash
# If Screen Sharing fails
sudo killall ScreenSharingAgent
# Then try connecting again

# VNC Viewer connection issues
# Check System Preferences → Security & Privacy → Firewall
```

### Windows Issues
```powershell
# Test connectivity
telnet YOUR-VM-IP 5901

# Windows Firewall
# Allow VNC Viewer through Windows Defender Firewall
```

### Mobile Issues
- Ensure mobile device and VM are on same network (or use VPN)
- Check mobile data restrictions
- Try different VNC client apps

## Multi-User Scenarios

### Concurrent Access
- Multiple clients can connect to same VNC session
- All users see the same desktop
- Mouse/keyboard input from all users affects the session

### Separate Sessions
```bash
# Create additional VNC sessions on VM
vncserver :2  # Port 5902
vncserver :3  # Port 5903

# Connect different users to different sessions
# User 1: YOUR-VM-IP:5901
# User 2: YOUR-VM-IP:5902
```

## Best Practices

1. **Always use SSH tunnels** for connections over internet
2. **Set strong VNC passwords** (8 characters max, but use complex ones)
3. **Close VNC sessions** when not in use to save resources
4. **Monitor connection logs** for security
5. **Use VPN** when available for better security and performance

Perfect for teams with mixed operating systems! 🌐
