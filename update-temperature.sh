#!/bin/bash

COMMAND="/usr/bin/temperv14 -f"
RRDFILE="/root/temper-graph/temp.rrd"

n=0
until [ $n -ge 5 ]
do 
	TEMP=`$COMMAND` && break
	n=$[n+1]
	sleep 1
done

logger -t usb_temp Current temperature is $TEMP
rrdtool update $RRDFILE --template Temperature N:$TEMP
