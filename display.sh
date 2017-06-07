#!/bin/bash

#----------------------------
#----------START-------------
#----------------------------

echo -en “\e[?25l”
while [ true ]
    do
    clear
    echo -en “\e[31m”
    date
    echo -en “\n\e[33mCPU Temperature: “
    cat /sys/class/thermal/thermal_zone0/temp
    echo -en “\n\e[32mBattery State:\n\n”
    cat /proc/acpi/battery/BAT0/state
    echo -en “\e[0m”
    if ! read -sn 1 -t 1 cmd ; then
        continue
    fi
    if [ $cmd == 'q' ] ; then
       break
    fi
done
echo -en “\e[?25h”
exit
