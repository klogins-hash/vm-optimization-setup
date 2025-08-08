# VS Code Remote SSH Setup Guide

Use VS Code as a backup access method and for seamless development on your Azure VM.

## Installation

### On Your Mac:
```bash
# Install VS Code if not already installed
brew install --cask visual-studio-code

# Or download from: https://code.visualstudio.com/
```

### Install Remote SSH Extension:
1. Open VS Code
2. Go to Extensions (Cmd+Shift+X)
3. Search for "Remote - SSH"
4. Install the official Microsoft extension

## Configuration

### 1. Set up SSH Config (Optional but Recommended)
```bash
# Edit SSH config file
nano ~/.ssh/config

# Add this configuration:
Host azure-vm
    HostName YOUR-VM-IP-HERE
    User azureuser
    Port 22
    ForwardX11 yes
    ForwardX11Trusted yes
```

### 2. Connect to VM
1. **Command Palette:** Cmd+Shift+P
2. **Type:** "Remote-SSH: Connect to Host"
3. **Enter:** `azureuser@YOUR-VM-IP` or `azure-vm` (if using config)
4. **Select:** Linux as the platform
5. **Enter:** Your SSH password/key

## Features You Get

✅ **Full VS Code Experience**
- All extensions work on the remote VM
- Integrated terminal runs on VM
- File explorer shows VM files
- Built-in clipboard synchronization

✅ **Perfect for Development**
- Code editing with full IntelliSense
- Git integration
- Debugging capabilities
- Extension marketplace access

✅ **Backup Access Method**
- If VNC fails, you still have terminal access
- Can troubleshoot VNC issues from VS Code terminal
- Multiple terminal sessions

## Usage Tips

### Opening Files/Folders
```bash
# In VS Code terminal (running on VM)
code .                    # Open current directory
code filename.py          # Open specific file
code /path/to/project     # Open specific folder
```

### Terminal Management
- **New Terminal:** Ctrl+Shift+`
- **Split Terminal:** Cmd+\
- **Switch Terminals:** Ctrl+Shift+5

### File Transfer
- **Drag & Drop:** Files from Mac Finder to VS Code
- **Copy/Paste:** Works seamlessly between Mac and VM
- **SFTP Extension:** For advanced file management

## Troubleshooting

### Connection Issues
```bash
# Test SSH connection first
ssh azureuser@YOUR-VM-IP

# Check SSH key permissions
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```

### Performance Optimization
```bash
# In VS Code settings (Cmd+,), search for:
# - "remote.SSH.connectTimeout": 60
# - "remote.SSH.keepAlive": true
```

### Extension Sync
- Extensions install automatically on the remote VM
- Settings sync between local and remote VS Code
- Some extensions may need manual installation

## Security Notes

- Uses same SSH connection as terminal access
- All traffic encrypted through SSH
- No additional ports needed (unlike VNC)
- Can be used alongside VNC setup

## Integration with VNC Setup

1. **Use VS Code for setup:** Run VNC installation scripts
2. **Monitor progress:** Watch installation in VS Code terminal  
3. **Test VNC:** Verify VNC server status
4. **Dual access:** Keep both VS Code and VNC available

Perfect for developers who want both GUI (VNC) and code editor (VS Code) access!
