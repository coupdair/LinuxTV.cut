#!/bin/bash

map="-map 0:0 -map 0:1 -map 0:3"
map="-map 0:0 -map 0:2 -map 0:3"
map="-map 0:1 -map 0:2 -map 0:3 -map 0:4 "
#map="-map 0:1 -map 0:2 -map 0:3"
#map="-map 0:1 -map 0:2"
#map="-map 0:0 -map 0:1"
#map="-map 0"

#crop="-vf cropdetect -ss 1234"
crop="-vf crop=1920:800:0:140"
#crop=

f=$1
shift
fo=../MPEG4/`basename $f .mpg`.mp4
#deinterlace="-filter:v yadif"

if [ "$*" != "" ]
then
  crop=$*
fi

#echo $f $map $crop $deinterlace
#exit

#info
frames=`../MPEG2/mpg_time.sh $f`
echo $f' has '$frames

#convert
ffmpeg -i $f $crop $deinterlace -vb 2048k -acodec ac3 $map -y $fo
