#!/bin/bash

COLOR_MOVING_AVG="#00ff00ff"
COLOR_AVG="#00ff00ff"
COLOR_TEMP="#51009933#00519933"
COLOR_MIN="#58faf4cc"
COLOR_MAX="#ff0000cc"

for i in 1h 3h 6h 12h 24h 3d 7d ; do

rrdtool graph /home/evan/temperature_$i.png \
-w 400 -h 200 -a PNG --slope-mode --start -$i --end now \
--title "Temperature - $i - All Degrees Fahrenheit" --watermark "`date`" --vertical-label "Temperature (F)" \
DEF:Temperature=/home/evan/temp.rrd:Temperature:MAX \
CDEF:avg=Temperature,1800,TRENDNAN \
VDEF:last=Temperature,LAST \
VDEF:max=Temperature,MAXIMUM \
VDEF:min=Temperature,MINIMUM \
VDEF:avg1=Temperature,AVERAGE \
AREA:Temperature$COLOR_TEMP:"Temp" \
GPRINT:last:"%6.2lf%sDegrees\\n" \
LINE1:Temperature#0000ffcc:"" \
COMMENT:"\\n" \
HRULE:avg1#cccc00cc:"Avg" \
GPRINT:avg1:"%6.2lf%sDegrees" \
COMMENT:"\\n" \
\
HRULE:min$COLOR_MIN:"Min" \
GPRINT:min:"%6.2lf%sDegrees" \
COMMENT:"\\n" \
\
HRULE:max$COLOR_MAX:"Max" \
GPRINT:max:"%6.2lf%sDegrees" \
COMMENT:"\\n" \
LINE2:avg$COLOR_MOVING_AVG:"30-minute Average\\n" 

done
