#!/bin/bash

map="-map 0:0 -map 0:1 -map 0:3"
map="-map 0:0 -map 0:2 -map 0:3"
map="-map 0:1 -map 0:2 -map 0:3 -map 0:4 -map 0:5"
map="-map 0:1 -map 0:2 -map 0:3 -map 0:4"
map="-map 0:1 -map 0:2 -map 0:3"
#map="-map 0:1 -map 0:2"
#map="-map 0:0 -map 0:1 -map 0:2 -map 0:4"
#map="-map 0"

#crop="-vf cropdetect -ss 1234"
crop="-vf crop=720:432:0:72"
#crop="-vf crop=720:560:0:8"
crop="-vf crop=720:416:0:80"
#crop="-vf crop=720:544:0:16"
#crop="-vf crop=544:400:0:90"
crop=

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
ffmpeg -i $f $crop $deinterlace -vb 1024k -acodec ac3 $map -y $fo
