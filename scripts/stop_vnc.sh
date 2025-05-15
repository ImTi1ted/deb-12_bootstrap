#!/bin/bash
pkill x11vnc
pkill lxpanel
pkill lxqt-panel
pkill lxterminal
pkill pcmanfm-qt
pkill openbox
pkill Xvfb
ps -u $User
