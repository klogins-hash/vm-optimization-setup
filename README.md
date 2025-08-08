# VM Optimization Setup - VNC & Remote Access

Complete setup guide for optimizing Azure Linux VM access from Mac with seamless clipboard integration and GUI access.

## Overview

This repo contains all scripts and instructions to set up:
- VNC server with GUI desktop environment
- Seamless clipboard sharing between Mac and VM
- Cross-platform access (Mac, Windows, mobile)
- Secure SSH tunneling
- VS Code Remote SSH integration

## Quick Start

### 1. VNC Server Setup (Run on Azure VM)
```bash
# Make setup script executable and run
chmod +x setup-vnc-server.sh
./setup-vnc-server.sh
```

### 2. Mac Client Setup
```bash
# Install VNC Viewer
brew install --cask vnc-viewer

# Or download from: https://www.realvnc.com/en/connect/download/viewer/
```

### 3. Connect Securely
```bash
# Create SSH tunnel (recommended)
ssh -L 5901:localhost:5901 azureuser@YOUR-VM-IP

# Then connect VNC Viewer to: localhost:5901
```

## Files Included

- `setup-vnc-server.sh` - Automated VNC server installation
- `vnc-config/xstartup` - Optimized VNC startup configuration
- `security/ssh-tunnel.sh` - SSH tunnel helper script
- `vscode-setup.md` - VS Code Remote SSH setup guide
- `troubleshooting.md` - Common issues and solutions
- `multi-platform-clients.md` - Client setup for Windows, mobile, etc.

## Features

✅ **Seamless Clipboard Integration**
- Copy on Mac → Paste in VM
- Copy in VM → Paste on Mac
- Works with all applications

✅ **Cross-Platform Access**
- Mac (VNC Viewer)
- Windows (VNC Viewer)
- Web browser (noVNC option)
- Mobile devices

✅ **Persistent Sessions**
- VM runs 24/7 even when Mac sleeps
- Switch between devices seamlessly
- Long-running tasks continue uninterrupted

✅ **Secure Access**
- SSH tunnel encryption
- VNC password protection
- Azure firewall configuration

## Connection Details

- **VNC Port:** 5901
- **Resolution:** 1920x1080 (configurable)
- **Color Depth:** 24-bit
- **Desktop Environment:** XFCE4 (lightweight)

## Safety Notes

- Keep your current SSH session open during setup
- Use VS Code Remote SSH as backup access method
- Test VNC connection before closing other sessions
- All scripts include error handling and rollback options

## Support

If you encounter issues:
1. Check `troubleshooting.md`
2. Verify Azure firewall settings
3. Test SSH connectivity first
4. Use backup access methods

---

**Ready to optimize your VM workflow!** 🚀
