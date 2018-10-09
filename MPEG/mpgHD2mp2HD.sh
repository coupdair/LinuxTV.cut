#!/bin/bash

f=$1
fo=../MPEG/`basename $f .ts`.mpeg
map="-map 0:0 -map 0:1 -map 0:2 -map 0:3"
map="-map 0"

#info
frames=`../MPEG2/mpg_time.sh $f`
echo $f' has '$frames

#convert
ffmpeg -i $f -vcodec mpeg2video -r 25 -acodec mp2 -ac 2 -f mpegts -vb 8192k $map -y $fo

#DVBcut index
../MPEG/idx.sh $fo

