# Troubleshooting Guide

Common issues and solutions for VNC and remote access setup.

## VNC Connection Issues

### "Connection Refused" Error
```bash
# Check if VNC server is running
vncserver -list

# If no sessions, start VNC server
vncserver -geometry 1920x1080 -depth 24 :1

# Check if port is listening
netstat -tlnp | grep :5901
```

### "Authentication Failed" Error
```bash
# Reset VNC password
vncpasswd

# Restart VNC server
vncserver -kill :1
vncserver -geometry 1920x1080 -depth 24 :1
```

### Black Screen or No Desktop
```bash
# Check xstartup file
cat ~/.vnc/xstartup

# Recreate xstartup with correct permissions
cp vnc-config/xstartup ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Restart VNC
vncserver -kill :1
vncserver -geometry 1920x1080 -depth 24 :1
```

## Clipboard Issues

### Clipboard Not Syncing
```bash
# Check if autocutsel is running
ps aux | grep autocutsel

# Install clipboard tools if missing
sudo apt install autocutsel xclip

# Restart VNC with clipboard support
vncserver -kill :1
vncserver -geometry 1920x1080 -depth 24 :1
```

### Copy/Paste Only Works One Direction
```bash
# Test clipboard tools manually
echo "test" | xclip -selection clipboard
xclip -selection clipboard -o

# Restart clipboard manager
pkill autocutsel
autocutsel -fork
```

## Network and Firewall Issues

### Cannot Connect from Mac
```bash
# Test SSH connection first
ssh azureuser@YOUR-VM-IP

# Check Azure Network Security Group
# Allow inbound rule for port 5901 (TCP)

# Test VNC port connectivity
telnet YOUR-VM-IP 5901
```

### SSH Tunnel Issues
```bash
# Test SSH tunnel creation
ssh -L 5901:localhost:5901 -v azureuser@YOUR-VM-IP

# Check if local port is bound
netstat -an | grep :5901

# Try different local port if 5901 is busy
ssh -L 5902:localhost:5901 azureuser@YOUR-VM-IP
# Then connect VNC to localhost:5902
```

## Performance Issues

### Slow VNC Performance
```bash
# Use lower color depth
vncserver -kill :1
vncserver -geometry 1920x1080 -depth 16 :1

# Use compression in VNC client
# Enable "Adaptive" quality in VNC Viewer settings
```

### High CPU Usage
```bash
# Check running processes
htop

# Use lighter desktop environment
sudo apt install lxde-core
# Edit ~/.vnc/xstartup to use: startlxde &
```

## Installation Issues

### Desktop Environment Installation Fails
```bash
# Check available disk space
df -h

# Clean package cache
sudo apt clean
sudo apt autoremove

# Try minimal installation
sudo apt install --no-install-recommends ubuntu-desktop-minimal
```

### Permission Errors
```bash
# Ensure correct ownership of VNC files
chown -R azureuser:azureuser ~/.vnc/

# Check VNC directory permissions
chmod 700 ~/.vnc/
chmod 600 ~/.vnc/passwd
chmod +x ~/.vnc/xstartup
```

## Recovery Options

### If VNC Setup Breaks SSH Access
```bash
# Use Azure Serial Console (from Azure Portal)
# Or use Azure Cloud Shell to connect

# Remove VNC and desktop packages
sudo apt remove --purge ubuntu-desktop-minimal tightvncserver
sudo apt autoremove
sudo apt autoclean
```

### Reset to Clean State
```bash
# Stop all VNC sessions
vncserver -kill :1
vncserver -kill :2

# Remove VNC configuration
rm -rf ~/.vnc/

# Restart setup process
./setup-vnc-server.sh
```

## Testing Checklist

### Before Connecting
- [ ] VNC server is running (`vncserver -list`)
- [ ] Port 5901 is listening (`netstat -tlnp | grep :5901`)
- [ ] SSH connection works (`ssh azureuser@YOUR-VM-IP`)
- [ ] Azure firewall allows port 5901 (if direct connection)

### After Connecting
- [ ] Desktop environment loads
- [ ] Can open applications (terminal, file manager)
- [ ] Copy text on Mac → paste in VM works
- [ ] Copy text in VM → paste on Mac works
- [ ] Mouse and keyboard input responsive

## Getting Help

### Log Files to Check
```bash
# VNC server logs
ls ~/.vnc/*.log
tail -f ~/.vnc/YOUR-VM-NAME:1.log

# System logs
sudo journalctl -u ssh
sudo tail -f /var/log/syslog
```

### Useful Commands for Support
```bash
# System information
uname -a
lsb_release -a

# Network configuration
ip addr show
ss -tlnp

# VNC process information
ps aux | grep vnc
ps aux | grep Xvnc
```

If issues persist, check the GitHub Issues section or create a new issue with the output of the diagnostic commands above.
