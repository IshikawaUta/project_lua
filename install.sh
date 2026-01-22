#!/bin/bash
# Auto-Installer for Terminal_Dev

echo "Starting Installation..."
sudo apt update
sudo apt install -y lua5.4 luarocks build-essential

echo "Installing Pegasus Engine..."
sudo luarocks install pegasus

echo "Done! Run the server using: lua app.lua"