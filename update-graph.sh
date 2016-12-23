#!/bin/bash



for i in 1h 3h 6h 12h 24h 3d 7d ; do

rrdtool graph /home/evan/temperature_$i.png \
-w 800 -h 300 -a PNG --slope-mode --start -$i --end now \
--title "Temperature" --watermark "`date`" --vertical-label "Temperature (F)" \
DEF:Temperature=/home/evan/temp.rrd:Temperature:MAX \
CDEF:avg=Temperature,1200,TRENDNAN \
LINE1:Temperature#ff00ff:"Temp (F)" \
LINE1:avg#00FF00:"Moving avg"

done
