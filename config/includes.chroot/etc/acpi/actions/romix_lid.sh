[ -x "/usr/sbin/pm-suspend" ] || exit 0
[ -x "/usr/bin/on_ac_power" ] || exit 0
[ -f "/etc/romix/romix.conf" ] || exit 0

. /etc/romix/romix.conf

#Check if we are configured for suspend
/usr/bin/on_ac_power
case "$?" in
  0)
    [ "$AC_LID_SUSPEND" = 0 ] && exit 
  ;;
  1)
    [ "$BATT_LID_SUSPEND" = 0 ] && exit
  ;;
esac 


case "$1" in
  button/lid)
     case "$3" in
       	 close)
	     /usr/sbin/pm-suspend &
	 ;;
     esac
  ;;
esac
