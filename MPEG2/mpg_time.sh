#!/bin/bash

mpeg=les_comperes__Film.mpg
mpeg=$1

which avprobe; if(($?==0)) ; then probe=avprobe ; else probe=ffprobe; fi
duration='('`$probe $mpeg 2>&1 | grep Duration | cut -d' ' -f4 | cut -d'.' -f1 | sed 's/:/hour+/;s/:/min+/'`'s)*25s^-1'

#echo $duration

frames=`units -t "$duration"`' frames'

echo -e '\033[1;32m'$frames'\033[0m'
