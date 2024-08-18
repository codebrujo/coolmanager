#!/bin/bash
# Script: monitor.sh
# chmod -v +x monitor.sh
# ./monitor.sh
echo "$(date) @ $(hostname)"
echo "-------------------------------------------"
pin=15
sleepTime=5
onTemp=53
offTemp=46
while true
do
   cpuTemp=$(</sys/class/thermal/thermal_zone0/temp)
   tmp=$(pinctrl get $pin)
   pinStatus=${tmp:15:2}
   if [ $((cpuTemp/1000)) -ge $onTemp ]; then
      echo "Trigger 1 => $((cpuTemp/1000))'C"
   fi
   if [ $((cpuTemp/1000)) -le $offTemp ]; then
      echo "Trigger 2 => $((cpuTemp/1000))'C"
   fi
   echo "CPU => $((cpuTemp/1000))'C, pin status $pinStatus"
sleep $sleepTime
done