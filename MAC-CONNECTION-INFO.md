# Mac Connection Information for Azure VM

## Your Azure VM Details

- **VM Name:** PowerfulDevVM
- **Public IP:** 20.51.129.5
- **Username:** azureuser
- **SSH Port:** 22 (standard)

## Connection Methods from Your Mac

### 1. SSH Terminal Access (Primary Method)
```bash
# Basic SSH connection
ssh azureuser@20.51.129.5

# SSH with X11 forwarding (for GUI apps)
ssh -X azureuser@20.51.129.5
```

### 2. VS Code Remote SSH (Recommended for Development)
1. **Install VS Code Extension:**
   - Open VS Code
   - Install "Remote - SSH" extension

2. **Connect:**
   - Command Palette (Cmd+Shift+P)
   - Type: "Remote-SSH: Connect to Host"
   - Enter: `azureuser@20.51.129.5`

3. **Optional SSH Config Setup:**
```bash
# Edit SSH config on your Mac
nano ~/.ssh/config

# Add this configuration:
Host azure-vm
    HostName 20.51.129.5
    User azureuser
    Port 22
    ForwardX11 yes
    ForwardX11Trusted yes

# Then connect with: ssh azure-vm
```

### 3. VNC Connection (After Setup)
```bash
# Create secure SSH tunnel first
ssh -L 5901:localhost:5901 azureuser@20.51.129.5

# Then connect VNC Viewer to: localhost:5901
```

## Authentication Methods

### SSH Key (Recommended)
If you have SSH keys set up:
```bash
# Connect with key
ssh -i ~/.ssh/your-key.pem azureuser@20.51.129.5
```

### Password Authentication
- Use your Azure VM password when prompted
- Less secure than SSH keys

## Required Software on Your Mac

### For Basic SSH:
```bash
# SSH is built into macOS - no installation needed
ssh azureuser@20.51.129.5
```

### For VS Code Development:
```bash
# Install VS Code if not already installed
brew install --cask visual-studio-code

# Install Remote SSH extension from VS Code marketplace
```

### For VNC GUI Access:
```bash
# Install VNC Viewer
brew install --cask vnc-viewer

# Or download from: https://www.realvnc.com/en/connect/download/viewer/
```

## Network Requirements

- **Internet connection** required (VM is on Azure cloud)
- **No VPN needed** - direct internet access
- **Firewall:** Ensure your Mac can make outbound SSH connections (port 22)

## Security Notes

- **SSH connections are encrypted** by default
- **Use SSH keys** instead of passwords when possible
- **VNC should use SSH tunneling** for security
- **Keep your Mac's SSH client updated**

## Troubleshooting Connection Issues

### Test Basic Connectivity:
```bash
# Test if VM is reachable
ping 20.51.129.5

# Test SSH port
telnet 20.51.129.5 22
```

### Common Issues:
1. **Connection timeout:** Check your internet connection
2. **Permission denied:** Verify username and authentication method
3. **Host key verification failed:** Remove old host key with:
   ```bash
   ssh-keygen -R 20.51.129.5
   ```

## Quick Start Commands

```bash
# 1. Clone the setup repository
git clone https://github.com/klogins-hash/vm-optimization-setup.git

# 2. Connect to VM via SSH
ssh azureuser@20.51.129.5

# 3. Navigate to setup directory
cd /home/azureuser/CascadeProjects/vm-optimization-setup

# 4. Run VNC setup
./setup-vnc-server.sh

# 5. Create SSH tunnel (new terminal on Mac)
ssh -L 5901:localhost:5901 azureuser@20.51.129.5

# 6. Connect VNC Viewer to: localhost:5901
```

## No Azure CLI Required!

You **don't need Azure CLI** for this setup. Everything is done through:
- ✅ **SSH** for terminal access
- ✅ **VS Code Remote SSH** for development
- ✅ **VNC** for GUI access

Azure CLI is only needed for Azure resource management, not for connecting to existing VMs.

---

**Ready to connect and optimize your VM!** 🚀
