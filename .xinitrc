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

# exec xrandr --output DP-4 --auto --output HDMI-0 --auto --left-of DP-4 &
nitrogen --restore &
picom &
xbindkeys
setxkbmap -option caps:escape
setxkbmap -layout us,es -option grp:win_space_toggle
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/mac_laptop
PATH="/home/sergio/.local/bin:$PATH"
# exec qtile start
exec i3

