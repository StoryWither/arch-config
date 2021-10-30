#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

nitrogen --restore &
picom &

# Sempre
xrandr --output DisplayPort-2 --primary
xrandr --output HDMI-A-0 --right-of DisplayPort-2

# A San Potito
# xrandr --newmode "1920x1080_74.00" 217.75 1920 2064 2264 2608 1080 1083 1088 1129 -hsync +vsync 
# xrandr --addmode DisplayPort-2 1920x1080_74.00 
# xrandr --output DisplayPort-2 --mode 1920x1080_74.00

# A Gaeta
xrandr --output DisplayPort-2 --primary --mode 1920x1080 --rate 143.98
xrandr --newmode "1920x1080_60.00" 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
xrandr --addmode HDMI-A-0 1920x1080_60.00
xrandr --output HDMI-A-0 --mode 1920x1080_60.00
 
xset -dpms 
setterm -blank 0 -powersave off -powerdown 0 
xset s off
vibrant-cli HDMI-A-0 2
vibrant-cli DisplayPort-2 2 
exec dwm
