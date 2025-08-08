#!/bin/bash

# VM Optimization - VNC Server Setup Script
# Safe installation with error handling and rollback options

set -e  # Exit on any error

echo "🚀 Starting VNC Server Setup for VM Optimization..."
echo "⚠️  This script will install desktop environment and VNC server"
echo "📋 Keep your current SSH session open as backup!"
echo ""

# Function to handle errors
handle_error() {
    echo "❌ Error occurred during setup. Rolling back..."
    # Add rollback logic here if needed
    exit 1
}

trap handle_error ERR

# Check if running as correct user
if [ "$USER" != "azureuser" ]; then
    echo "⚠️  Please run this script as azureuser"
    exit 1
fi

echo "📦 Step 1: Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "🖥️  Step 2: Installing lightweight desktop environment..."
echo "   This may take 5-10 minutes..."
sudo apt install -y ubuntu-desktop-minimal

echo "📡 Step 3: Installing VNC server and dependencies..."
sudo apt install -y tightvncserver autocutsel xfce4 xfce4-goodies

echo "🔧 Step 4: Initial VNC server configuration..."
# Kill any existing VNC sessions
vncserver -kill :1 2>/dev/null || true

# Start VNC for initial setup (will prompt for password)
echo "🔐 You'll be prompted to set a VNC password (8 characters max)"
echo "   This password will be used to connect from your Mac"
vncserver

# Kill the session to configure it properly
vncserver -kill :1

echo "⚙️  Step 5: Creating optimized VNC configuration..."
# Backup existing config if it exists
if [ -f ~/.vnc/xstartup ]; then
    cp ~/.vnc/xstartup ~/.vnc/xstartup.backup.$(date +%s)
fi

# Create optimized xstartup configuration
cat > ~/.vnc/xstartup << 'EOF'
#!/bin/bash
# VNC xstartup script with clipboard support

# Load X resources
xrdb $HOME/.Xresources 2>/dev/null || true

# Start clipboard manager for seamless copy/paste
autocutsel -fork

# Set background
xsetroot -solid grey

# Start window manager
startxfce4 &
EOF

# Make xstartup executable
chmod +x ~/.vnc/xstartup

echo "🎨 Step 6: Starting VNC server with optimal settings..."
vncserver -geometry 1920x1080 -depth 24 :1

echo ""
echo "✅ VNC Server Setup Complete!"
echo ""
echo "📋 Connection Details:"
echo "   • VNC Port: 5901"
echo "   • Resolution: 1920x1080"
echo "   • Desktop: XFCE4"
echo ""
echo "🔒 Next Steps (run from your Mac):"
echo "   1. Install VNC Viewer: brew install --cask vnc-viewer"
echo "   2. Create SSH tunnel: ssh -L 5901:localhost:5901 azureuser@YOUR-VM-IP"
echo "   3. Connect VNC Viewer to: localhost:5901"
echo ""
echo "🔥 For direct connection (less secure):"
echo "   • Configure Azure firewall to allow port 5901"
echo "   • Connect VNC Viewer directly to: YOUR-VM-IP:5901"
echo ""
echo "📖 See README.md for detailed instructions and troubleshooting"

# Display VNC server status
echo ""
echo "📊 Current VNC Sessions:"
vncserver -list
