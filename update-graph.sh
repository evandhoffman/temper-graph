#!/bin/bash

rrdtool graph /home/evan/temperature_graph.png \
-w 800 -h 600 -a PNG --slope-mode --start -1h --end now \
--title "Temperature" --watermark "`date`" --vertical-label "Temperature (F)" \
DEF:Temperature=/home/evan/temp.rrd:Temperature:MAX \
LINE1:Temperature#ff00ff:"Temp (F)"
