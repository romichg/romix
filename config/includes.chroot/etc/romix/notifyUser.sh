#!/bin/bash

ACTIVE_USER_SESS=$(loginctl show-session 1 | sed 's/\s/-/g' )
ACTIVE_USER=$(echo $ACTIVE_USER_SESS | sed 's/.*Name=//g' | sed 's/\s.*//g')
ACTIVE_TYPE=$(echo $ACTIVE_USER_SESS | sed 's/.*Type=//g' | sed 's/\s.*//g')
ACTIVE_DISPLAY=$(echo $ACTIVE_USER_SESS | sed 's/.*Display=//g' | sed 's/\s.*//g')


if [ -x "/usr/bin/notify-send" ] && [ $ACTIVE_TYPE = "x11" ]
then
   NOTIFY=true
fi

if [ $USER = $ACTIVE_USER ]
then
   USE_CURRENT=true
fi

[[ -n $NOTIFY ]] && [[ -z $USE_CURRENT ]]  && sudo -u $ACTIVE_USER DISPLAY=$ACTIVE_DISPLAY /usr/bin/notify-send $1
[[ -n $NOTIFY ]] && [[ -n $USE_CURRENT ]]  && /usr/bin/notify-send $1

