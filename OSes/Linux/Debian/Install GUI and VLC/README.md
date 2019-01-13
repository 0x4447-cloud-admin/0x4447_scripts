Instan GUI plus VNC

- apt-get update
- apt-get upgrade
- apt-get install ubuntu-desktop
- apt-get install gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
- apt-get install tightvncserver
- vncserver (type desired vnc password, then again)
- vncserver -kill :1
- vncserver -geometry 1440x900
-

~/.vnc/xstartup

#!/bin/sh

export XKL_XMODMAP_DISABLE=1
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &

gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
gnome-terminal &
