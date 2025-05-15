#!/bin/bash

set -e

# Install packages
apt update
apt install -y \
  openbox lxpanel lxterminal x11vnc xvfb feh \
  obconf lxappearance arc-theme papirus-icon-theme

# Move wallpaper
mkdir -p ~/Photos
if [ -f ~/Photos/debian-wallpaper.jpg ]; then
  mv ~/Photos/debian-wallpaper.jpg ~/
else
  echo "WARNING: ~/Photos/debian-wallpaper.jpg not found. Please copy it manually."
fi

# Generate ~/.fehbg
echo "feh --bg-scale ~/debian-wallpaper.jpg" > ~/.fehbg
chmod +x ~/.fehbg

# Create vnc.sh
cat > ~/vnc.sh << 'EOF'
#!/bin/bash
export DISPLAY=:1
export XAUTHORITY=$HOME/.Xauthority

## Virtual Display
Xvfb :1 -screen 0 1280x720x16 &
sleep 1

## X Auth
xauth generate :1 . trusted

## Window Manager
openbox &

## Wallpaper
~/.fehbg &

## Panel and Terminal
lxpanel &
lxterminal &

## VNC
x11vnc -display :1 -auth $XAUTHORITY -nopw -forever -nolookup -noipv6 &
EOF

chmod +x ~/vnc.sh

# Create stop script
cat > ~/stop_vnc.sh << 'EOF'
#!/bin/bash
pkill x11vnc
pkill lxpanel
pkill lxterminal
pkill openbox
pkill Xvfb
EOF

chmod +x ~/stop_vnc.sh

# Notify user
echo -e "\nSetup complete!"
echo "Run your desktop with: ./vnc.sh"
echo "Stop it with: ./stop_vnc.sh"
echo "Don't forget to run:\n lxappearance & \n obconf &"
