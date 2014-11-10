[ -f "/etc/romix/romix.conf" ] || exit 0
. /etc/romix/romix.conf

[ -d "/tmp/romix" ] || mkdir /tmp/romix
echo $USER >> /tmp/romix/x-current-user

[ "$AC_INACT_SUSPEND" = 0 ] || xautolock -time $AC_INACT_SUSPEND -locker "/etc/romix/suspend-on-timeout.sh AC" -detectsleep -noclose 
[ "$BATT_INACT_SUSPEND" = 0 ] || xautolock -time $BATT_INACT_SUSPEND -locker "/etc/romix/suspend-on-timeout.sh BATT" -detectsleep -noclose
[ "$SCREEN_LOCK_MIN" = 0 ] || xautolock -time $SCREEN_LOCK_MIN -locker "/etc/romix/screen-lock.sh" -detectsleep -noclose -secure


