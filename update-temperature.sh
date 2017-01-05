#!/bin/bash

COMMAND="/usr/bin/temperv14 -f"
RRDFILE="/root/temper-graph/temp.rrd"


rrdtool update $RRDFILE --template Temperature N:`$COMMAND`
