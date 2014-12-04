 #!/bin/sh

[ -f "/tmp/romix/x-current-user" ] || exit 0
 
 username=`cat /tmp/romix/x-current-user`
 userhome=/home/$username
 
if [ $username = $USER ]
then
 /usr/bin/i3lock -i /etc/skel/.config/wallpaper/noanchors.png -t &
 exit 0
fi


 export XAUTHORITY="$userhome/.Xauthority"
 export DISPLAY=":0"

 su $username -c "/usr/bin/i3lock -i /etc/skel/.config/wallpaper/noanchors.png -t" &
