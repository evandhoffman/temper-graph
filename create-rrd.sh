
rrdtool create temp.rrd \
--step 60 \
DS:Temperature:GAUGE:120:0:200 \
RRA:MAX:0.5:1:525600
