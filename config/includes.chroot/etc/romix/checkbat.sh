#!/bin/bash

while (true)
do       
    STATUS=($(/usr/bin/acpi -b | awk -F'[,:%]' '{print $2, $3}'))
    status=${STATUS[0]}
    capacity=${STATUS[1]}

    echo $status $capacity

      if [ "$status" = Discharging -a "$capacity" -lt 10 ]
      then
         /etc/romix/power.sh batlow
      fi
      if [ "$status" = Discharging -a "$capacity" -lt 4 ]
      then
         /etc/romix/power.sh batcritical
      fi
      if [ "$status" = Charging -a "$capacity" -gt 15 ]
      then
        break 
      fi
   
   sleep 30
done
