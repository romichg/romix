#!/bin/bash

[ -x "/usr/bin/notify-send" ] || exit 1
[ -f "/etc/romix/romix.conf" ] || exit 1

. /etc/romix/romix.conf

[ $AC_BRIGHTNESS -eq $AC_BRIGHTNESS ] && [ $AC_BRIGHTNESS -ge 0 ] &&  [ $AC_BRIGHTNESS -le 100 ] || exit 2
[ $BATT_BRIGHTNESS -eq $BATT_BRIGHTNESS ] && [ $BATT_BRIGHTNESS -ge 0 ] &&  [ $BATT_BRIGHTNESS -le 100 ] || exit 2


case "$1" in
  batcritical )
    /etc/romix/notifyUser.sh 'BATTERY CRITICAL'
    logger "Battery Critical"
    if [ $HIBERNATE_ON_CRITICAL -eq 1 ] 
    then
       systemctl hibernate
    else 
       systemctl suspend
    fi
  ;;
  batlow)
    /etc/romix/notifyUser.sh 'BATTERY LOW'
    logger "Battery Low"
    [ -x "/usr/bin/beep" ] && /usr/bin/beep -f 800 -r 5 -d 100 -l 400
  ;;
  ac)
    /etc/romix/backlight.sh set $AC_BRIGHTNESS
  ;;
  battery)
    /etc/romix/backlight.sh set $BATT_BRIGHTNESS
  ;;
esac

exit 0
