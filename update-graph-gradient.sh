#!/bin/bash

COLOR_MOVING_AVG="#00ff00ff"
COLOR_AVG="#00ff00ff"
COLOR_TEMP="#51009933#00519933"
COLOR_MIN="#58faf4cc"
COLOR_MAX="#ff0000cc"

IMG_PATH="/var/www/html/temperature/"
RRD_PATH="/opt/temper-graph/"

for i in 1h 3h 6h 12h 24h 3d 7d 30d 90d 1y; do

rrdtool graph $IMG_PATH/temperature_$i.png \
-w 500 -h 300 -a PNG --slope-mode --start -$i --end -1min \
--title "Temperature - $i - All °F" --watermark "EH Tempbot `date`" --vertical-label "Temperature (°F)" \
DEF:Temperature=$RRD_PATH/temp.rrd:Temperature:MAX \
CDEF:avg=Temperature,7200,TRENDNAN \
CDEF:predict=172800,86400,2,1800,Temperature,PREDICT \
VDEF:last=Temperature,LAST \
VDEF:max=Temperature,MAXIMUM \
VDEF:min=Temperature,MINIMUM \
VDEF:avg1=Temperature,AVERAGE \
GPRINT:last:"%6.2lf%s°F\\n" \
COMMENT:"\\n" \
HRULE:avg1#cccc00cc:"Avg" \
GPRINT:avg1:"%6.2lf%s°F" \
COMMENT:"\\n" \
\
CDEF:t=Temperature \
CDEF:shading89=t,89,LT,t,89,IF AREA:shading89#FF8200 \
CDEF:shading88=t,88,LT,t,88,IF AREA:shading88#FF8c00 \
CDEF:shading87=t,87,LT,t,87,IF AREA:shading87#FF9600 \
CDEF:shading86=t,86,LT,t,86,IF AREA:shading86#FFa000 \
CDEF:shading85=t,85,LT,t,85,IF AREA:shading85#FFaa00 \
CDEF:shading84=t,84,LT,t,84,IF AREA:shading84#FFb400 \
CDEF:shading83=t,83,LT,t,83,IF AREA:shading83#FFbe00 \
CDEF:shading82=t,82,LT,t,82,IF AREA:shading82#FFc800 \
CDEF:shading81=t,81,LT,t,81,IF AREA:shading81#FFd200 \
CDEF:shading80=t,80,LT,t,80,IF AREA:shading80#FFdc00 \
CDEF:shading79=t,79,LT,t,79,IF AREA:shading79#FFe600 \
CDEF:shading78=t,78,LT,t,78,IF AREA:shading78#FFf000 \
CDEF:shading77=t,77,LT,t,77,IF AREA:shading77#FFfa00 \
CDEF:shading76=t,76,LT,t,76,IF AREA:shading76#fdff00 \
CDEF:shading75=t,75,LT,t,75,IF AREA:shading75#d7ff00 \
CDEF:shading74=t,74,LT,t,74,IF AREA:shading74#b0ff00 \
CDEF:shading73=t,73,LT,t,73,IF AREA:shading73#65ff00 \
CDEF:shading72=t,72,LT,t,72,IF AREA:shading72#17ff00 \
CDEF:shading71=t,71,LT,t,71,IF AREA:shading71#00ff36 \
CDEF:shading70=t,70,LT,t,70,IF AREA:shading70#00ff83 \
CDEF:shading69=t,69,LT,t,69,IF AREA:shading69#00ffa8 \
CDEF:shading68=t,68,LT,t,68,IF AREA:shading68#00ffd0 \
CDEF:shading67=t,67,LT,t,67,IF AREA:shading67#00fff4 \
CDEF:shading66=t,66,LT,t,66,IF AREA:shading66#00e4ff \
CDEF:shading65=t,65,LT,t,65,IF AREA:shading65#00d4ff \
CDEF:shading64=t,64,LT,t,64,IF AREA:shading64#00c4ff \
CDEF:shading63=t,63,LT,t,63,IF AREA:shading63#00b4ff \
CDEF:shading62=t,62,LT,t,62,IF AREA:shading62#00a4ff \
CDEF:shading61=t,61,LT,t,61,IF AREA:shading61#0094ff \
CDEF:shading60=t,60,LT,t,60,IF AREA:shading60#0084ff \
CDEF:shading59=t,59,LT,t,59,IF AREA:shading59#0074ff \
\
HRULE:min$COLOR_MIN:"Min" \
GPRINT:min:"%6.2lf%s°F" \
COMMENT:"\\n" \
\
HRULE:max$COLOR_MAX:"Max" \
GPRINT:max:"%6.2lf%s°F" \
COMMENT:"\\n" \

done
