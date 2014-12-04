[ -f "/etc/romix/romix.conf" ] || exit 0
. /etc/romix/romix.conf

[ -d "/tmp/romix" ] || mkdir /tmp/romix
echo $USER >> /tmp/romix/x-current-user

[ "$SCREEN_LOCK_MIN" = 0 ] || xautolock -time $SCREEN_LOCK_MIN -locker "/etc/romix/screen-lock.sh" -detectsleep -secure &
