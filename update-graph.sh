#!/bin/bash

COLOR_MOVING_AVG="#00ff00ff"
COLOR_AVG="#00ff00ff"
COLOR_TEMP="#005199"
COLOR_MIN="#58faf4cc"
COLOR_MAX="#ff0000cc"

IMG_PATH="/var/www/html/temperature/"
RRD_PATH="/opt/temper-graph/"

for i in 1h 3h 6h 12h 24h 3d 7d 30d 90d 1y; do

rrdtool graph $IMG_PATH/temperature_$i.png \
-w 500 -h 300 -a PNG --slope-mode --start -$i --end now \
--title "Temperature - $i - All °F" --watermark "`date`" --vertical-label "Temperature (F)" \
DEF:Temperature=$RRD_PATH/temp.rrd:Temperature:MAX \
CDEF:avg=Temperature,1800,TRENDNAN \
VDEF:last=Temperature,LAST \
VDEF:max=Temperature,MAXIMUM \
VDEF:min=Temperature,MINIMUM \
VDEF:avg1=Temperature,AVERAGE \
CDEF:t=Temperature \
CDEF:ccold=t,0,61.99,LIMIT \
CDEF:ccool=t,62,67.99,LIMIT \
CDEF:ccomfy=t,68,74.99,LIMIT \
CDEF:cwarm=t,75,79.99,LIMIT \
CDEF:chot=t,80,150,LIMIT \
AREA:ccold#0032ff66:"Cold" \
AREA:ccool#00fff466:"Cool" \
AREA:ccomfy#3eff0066:"Comfy" \
AREA:cwarm#ffdc0066:"Warm" \
AREA:chot#ff3c0066:"Hot" \
LINE1:Temperature$COLOR_TEMP:"Temp" \
GPRINT:last:"%6.2lf%s°F\\n" \
LINE1:Temperature#0000ffcc:"" \
COMMENT:"\\n" \
HRULE:avg1#cccc00cc:"Avg" \
GPRINT:avg1:"%6.2lf%s°F" \
COMMENT:"\\n" \
\
HRULE:min$COLOR_MIN:"Min" \
GPRINT:min:"%6.2lf%s°F" \
COMMENT:"\\n" \
\
HRULE:max$COLOR_MAX:"Max" \
GPRINT:max:"%6.2lf%s°F" \
COMMENT:"\\n" 

done
