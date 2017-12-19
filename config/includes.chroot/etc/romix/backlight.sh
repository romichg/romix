# Not using xbacklight due to a bug https://bugs.freedesktop.org/show_bug.cgi?id=96572
#[ -x "/usr/bin/xbacklight" ] || exit 1
[ -x "/usr/bin/notify-send" ] || exit 1
[ -f "/etc/romix/romix.conf" ] || exit 1

. /etc/romix/romix.conf

#Check to makes sure our deltas are sane
[ $BRIGHTNESS_DELTA -gt 0 ] && [ $BRIGHTNESS_DELTA -lt 100 ] || exit 2


#inspired by https://gist.github.com/andreafortuna/6eea255e1846c894d46c4b7d8b813878#file-brightness-sh 
setBacklight() {
   basedir="/sys/class/backlight/"
   # get the backlight handler - we only choose the first handler if there are more than one
   handler=$basedir$(ls  /sys/class/backlight/ | tr '\n' ' ' | sed 's/\s.*//')"/"
   # current brightness
   old_brightness=$(cat $handler"brightness")
   # max brightness
   max_brightness=$(cat $handler"max_brightness")

   case "$1" in
     delta)
      # current %
      old_brightness_p=$(( 100 * $old_brightness / $max_brightness ))
      # new % 
      new_brightness_p=$(($old_brightness_p $2))
      if [ $new_brightness_p -gt 100 ]
      then
         new_brightness_p=100
      fi
      if [ $new_brightness_p -lt 0 ]
      then
         new_brightness_p=0
      fi
      # new brightness value
      new_brightness=$(( $max_brightness * $new_brightness_p / 100 ))
     ;;
     set)
      #Check ot make sure we don't get passed anything bad
      [ $2 -eq $2 ] && [ $2 -ge 0 ] && [ $2 -le 100 ] || exit 4
      # new % 
      new_brightness_p=$2
      # new brightness value
      new_brightness=$(( $max_brightness * $2 / 100 ))
     ;;
   esac

   sudo /etc/romix/setBacklight.sh $new_brightness $handler
}

case "$1" in
  dec)
    setBacklight delta -$BRIGHTNESS_DELTA
    /etc/romix/notifyUser.sh "-h int:value:$new_brightness_p "%p""
  ;;
  inc)
    setBacklight delta +$BRIGHTNESS_DELTA
    /etc/romix/notifyUser.sh "-h int:value:$new_brightness_p "%p""
  ;;
  set)
    setBacklight set $2
    /etc/romix/notifyUser.sh "-h int:value:$new_brightness_p "%p""
  ;;
esac

