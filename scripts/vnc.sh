#!/bin/bash
export DISPLAY=:1
export XAUTHORITY=$HOME/.Xauthority

## Virt Disp
Xvfb :1 -screen 0 1280x720x16 &
sleep 1

## Xauth
xauth generate :1 . trusted

## WM
openbox &

## WP
~/.fehbg &

## Panels & Term
lxpanel &
lxterminal &

## Old Panels
# lxqt-panel &
# pcmanfm-qt --desktop &

## VNC
x11vnc -display :1 -auth $XAUTHORITY -nopw -forever -nolookup -noipv6 &
