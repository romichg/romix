[ -x "/usr/bin/xbacklight" ] || exit 1
[ -x "/usr/bin/notify-send" ] || exit 1
[ -f "/etc/romix/romix.conf" ] || exit 1

. /etc/romix/romix.conf

case "$1" in
  dec)
    /usr/bin/xbacklight -dec $BRIGHTNESS_DELTA
    [ -x "/usr/bin/notify-send" ] && /usr/bin/notify-send `/usr/bin/xbacklight -get`
  ;;
  inc)
    /usr/bin/xbacklight -inc $BRIGHTNESS_DELTA
    [ -x "/usr/bin/notify-send" ] && /usr/bin/notify-send `/usr/bin/xbacklight -get`
  ;;
esac

