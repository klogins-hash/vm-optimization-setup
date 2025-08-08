#!/bin/bash

# Mac Keyboard Setup Script for Linux VM
# Configures Mac-style keyboard shortcuts and layout

set -e  # Exit on any error

echo "🍎 Setting up Mac-style keyboard layout for VM..."
echo "⚠️  This script will configure Mac keyboard shortcuts (Cmd+C, Cmd+V, etc.)"
echo ""

# Function to handle errors
handle_error() {
    echo "❌ Error occurred during Mac keyboard setup."
    exit 1
}

trap handle_error ERR

# Check if running as correct user
if [ "$USER" != "azureuser" ]; then
    echo "⚠️  Please run this script as azureuser"
    exit 1
fi

echo "📦 Step 1: Installing required packages..."
sudo apt update
sudo apt install -y xbindkeys xvkbd

echo "⌨️  Step 2: Creating Mac keyboard configuration files..."

# Create .xbindkeysrc for Mac shortcuts
cat > ~/.xbindkeysrc << 'EOF'
# Mac-style keyboard shortcuts for Linux VM
# Maps Cmd (Super) key to common Mac shortcuts

# Copy, Cut, Paste, Select All
"xvkbd -xsendevent -text '\Cc'"
  m:0x40 + c:54
  Mod4 + c

"xvkbd -xsendevent -text '\Cx'"
  m:0x40 + c:53
  Mod4 + x

"xvkbd -xsendevent -text '\Cv'"
  m:0x40 + c:55
  Mod4 + v

"xvkbd -xsendevent -text '\Ca'"
  m:0x40 + c:38
  Mod4 + a

# Undo, Redo
"xvkbd -xsendevent -text '\Cz'"
  m:0x40 + c:52
  Mod4 + z

"xvkbd -xsendevent -text '\C\Sz'"
  m:0x41 + c:52
  Mod4 + Shift + z

# Find, Save, New, Open, Print, Quit, Refresh
"xvkbd -xsendevent -text '\Cf'"
  m:0x40 + c:41
  Mod4 + f

"xvkbd -xsendevent -text '\Cs'"
  m:0x40 + c:39
  Mod4 + s

"xvkbd -xsendevent -text '\Cn'"
  m:0x40 + c:57
  Mod4 + n

"xvkbd -xsendevent -text '\Co'"
  m:0x40 + c:32
  Mod4 + o

"xvkbd -xsendevent -text '\Cp'"
  m:0x40 + c:33
  Mod4 + p

"xvkbd -xsendevent -text '\Cq'"
  m:0x40 + c:24
  Mod4 + q

"xvkbd -xsendevent -text '\Cr'"
  m:0x40 + c:27
  Mod4 + r

# Text formatting
"xvkbd -xsendevent -text '\Cb'"
  m:0x40 + c:56
  Mod4 + b

"xvkbd -xsendevent -text '\Ci'"
  m:0x40 + c:31
  Mod4 + i

"xvkbd -xsendevent -text '\Cu'"
  m:0x40 + c:30
  Mod4 + u

# Tab and window management
"xvkbd -xsendevent -text '\Ct'"
  m:0x40 + c:28
  Mod4 + t

"xvkbd -xsendevent -text '\Cw'"
  m:0x40 + c:25
  Mod4 + w

"xvkbd -xsendevent -text '\Cm'"
  m:0x40 + c:58
  Mod4 + m

"xvkbd -xsendevent -text '\Ch'"
  m:0x40 + c:43
  Mod4 + h
EOF

# Create .Xmodmap for key remapping
cat > ~/.Xmodmap << 'EOF'
! Mac keyboard layout for Linux VM
! Swap Alt and Super (Cmd) keys to match Mac layout

! Clear existing modifiers
clear Mod1
clear Mod4

! Map keys to match Mac layout
! Left Alt becomes Super (Cmd)
! Left Super becomes Alt (Option)
keycode 64 = Super_L
keycode 133 = Alt_L

! Right Alt becomes Super (Cmd) 
! Right Super becomes Alt (Option)
keycode 108 = Super_R
keycode 134 = Alt_R

! Set up modifiers properly
add Mod1 = Alt_L Alt_R
add Mod4 = Super_L Super_R

! Additional Mac-style mappings
! Make Caps Lock behave like Ctrl (common Mac preference)
keycode 66 = Control_L
add Control = Control_L
EOF

echo "🔧 Step 3: Setting up autostart..."
mkdir -p ~/.config/autostart

cat > ~/.config/autostart/mac-keyboard.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Mac Keyboard Layout
Comment=Apply Mac-style keyboard layout and shortcuts
Exec=/bin/bash -c 'sleep 3 && xmodmap ~/.Xmodmap && xbindkeys'
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF

echo "🎯 Step 4: Applying keyboard configuration..."
# Apply immediately if X is running
if [ -n "$DISPLAY" ]; then
    xmodmap ~/.Xmodmap 2>/dev/null || true
    killall xbindkeys 2>/dev/null || true
    xbindkeys 2>/dev/null || true
fi

echo ""
echo "✅ Mac Keyboard Setup Complete!"
echo ""
echo "🍎 Mac-Style Shortcuts Now Available:"
echo "   • Cmd+C = Copy"
echo "   • Cmd+V = Paste"
echo "   • Cmd+X = Cut"
echo "   • Cmd+A = Select All"
echo "   • Cmd+Z = Undo"
echo "   • Cmd+S = Save"
echo "   • Cmd+F = Find"
echo "   • Cmd+Q = Quit"
echo "   • And many more!"
echo ""
echo "🔄 Restart your VNC session to fully activate all shortcuts"
echo "📖 See README.md for complete list of available shortcuts"

echo ""
echo "📊 Configuration Status:"
echo "   • Keyboard shortcuts: ~/.xbindkeysrc"
echo "   • Key mappings: ~/.Xmodmap"
echo "   • Autostart: ~/.config/autostart/mac-keyboard.desktop"
