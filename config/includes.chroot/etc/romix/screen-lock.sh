#!/bin/sh

[ -f "/etc/romix/romix.conf" ] || exit 1
. /etc/romix/romix.conf

/usr/bin/i3lock -i $LOCK_IMG -t
