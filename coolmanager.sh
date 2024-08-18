#!/bin/bash
# Script: coolmanager.sh
# chmod -v +x coolmanager.sh
# ./coolmanager.sh
if [ "$1" == "-p" ]; then
   echo "$(date) @ $(hostname)"
   echo "-------------------------------------------"
fi
onTemp=53
offTemp=46
pin=15
sleepTime=5
tag="coolmanager"
while true
do
   cpuTemp=$(</sys/class/thermal/thermal_zone0/temp)
   tmp=$(pinctrl get $pin)
   pinStatus=${tmp:15:2}
   if [ $((cpuTemp/1000)) -ge $onTemp ]; then
      if [ "$1" == "-p" ]; then
         echo "Fan on => $((cpuTemp/1000))'C"
      fi
      if [ "$1" == "-l" ]; then
         echo "Fan on => $((cpuTemp/1000))'C"
         logger -t $tag "Fan on => $((cpuTemp/1000))'C"
      fi
      pinctrl set $pin op dh
   fi
   if [ $((cpuTemp/1000)) -le $offTemp ]; then
      if [ "$1" == "-p" ]; then
         echo "Fan off => $((cpuTemp/1000))'C"
      fi
      if [ "$1" == "-l" ]; then
         echo "Fan off => $((cpuTemp/1000))'C"
         logger -t $tag "Fan on => $((cpuTemp/1000))'C"
      fi
      pinctrl set $pin op dl
   fi
   if [ "$1" == "-p" ]; then
      echo "CPU => $((cpuTemp/1000))'C, pin status $pinStatus"
   fi
sleep $sleepTime
done