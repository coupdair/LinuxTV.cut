#!/bin/bash

f=$1
fo=../MPEG/`basename $f .ts`.mpeg

start="-ss 456"
start=
map="-map 0:0 -map 0:1 -map 0:2"
map="-map 0"

#info
frames=`../MPEG2/mpg_time.sh $f`
echo $f' has '$frames

#convert
which avconv; if(($?==0)) ; then avconv=avconv ; else avconv=ffmpeg; fi
$avconv -i $f -vcodec mpeg2video -s 720x576  -r 25 -acodec mp2 -ac 2 -f mpegts -vb 4096k $map -y $fo

#DVBcut index
../MPEG/idx.sh $fo
