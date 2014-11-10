#! /bin/sh

[ -x "/usr/bin/on_ac_power" ] || exit 0


/usr/bin/on_ac_power
case "$?" in
  0)
   /usr/sbin/pm-powersave false &   
  ;;

  1)
   /usr/sbin/pm-powersave true &
  ;;
esac
