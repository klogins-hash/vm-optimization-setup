#!/bin/bash

# SSH Tunnel Helper Script for Secure VNC Connection
# Run this on your Mac to create encrypted VNC connection

# Configuration
VM_IP="YOUR-VM-IP-HERE"
VM_USER="azureuser"
LOCAL_PORT="5901"
REMOTE_PORT="5901"

echo "🔒 Creating secure SSH tunnel for VNC connection..."
echo "   Local port: $LOCAL_PORT"
echo "   Remote: $VM_USER@$VM_IP:$REMOTE_PORT"
echo ""

# Check if VM_IP is still placeholder
if [ "$VM_IP" = "YOUR-VM-IP-HERE" ]; then
    echo "⚠️  Please edit this script and replace YOUR-VM-IP-HERE with your actual VM IP"
    echo "   Example: VM_IP=\"203.0.113.123\""
    exit 1
fi

# Create SSH tunnel
echo "🚇 Starting SSH tunnel..."
echo "   After tunnel is established:"
echo "   1. Open VNC Viewer"
echo "   2. Connect to: localhost:$LOCAL_PORT"
echo "   3. Enter your VNC password"
echo ""
echo "   Press Ctrl+C to close tunnel when done"
echo ""

ssh -L $LOCAL_PORT:localhost:$REMOTE_PORT $VM_USER@$VM_IP

echo "🔒 SSH tunnel closed."
