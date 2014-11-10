 #!/bin/sh
[ -f "/tmp/romix/x-current-user" ] || exit 0
 
 username=`cat /tmp/romix/x-current-user`
 userhome=/home/$username
 export XAUTHORITY="$userhome/.Xauthority"
 export DISPLAY=":0"

 su $username -c "/usr/bin/i3lock -i /etc/skel/.config/wallpaper/noanchors.png" &
