#!/bin/bash

COMMAND="/usr/bin/temperv14 -f"
RRDFILE="/home/evan/temp.rrd"


rrdtool update $RRDFILE --template Temperature N:`$COMMAND`
