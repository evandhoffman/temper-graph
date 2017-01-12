#!/bin/bash

COMMAND="/usr/bin/temperv14 -f"
RRDFILE="/home/evan/temp.rrd"

n=0
until [ $n -ge 5 ]
do 
	TEMP=`$COMMAND` && break
	n=$[n+1]
	sleep 1
done

rrdtool update $RRDFILE --template Temperature N:$TEMP
