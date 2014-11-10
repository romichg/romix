[ -x "/usr/sbin/pm-suspend" ] || exit 0
[ -x "/usr/bin/on_ac_power" ] || exit 0
[ -f "/etc/romix/romix.conf" ] || exit 0

. /etc/romix.conf

case "$1" in
  AC)
    [ "$AC_INACT_SUSPEND" = 0 ] && exit 
    [ "/usr/bin/on_ac_power" = 0 ] && sudo /usr/sbin/pm-suspend &
  ;;
  BATT)
    [ "$BATT_INACT_SUSPEND" = 0 ] && exit 
    [ "/usr/bin/on_ac_power" = 1 ] && sudo /usr/sbin/pm-suspend &
  ;;
esac 
