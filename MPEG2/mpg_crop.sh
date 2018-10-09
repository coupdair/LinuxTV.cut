#!/bin/bash

#usage: ./mpg_crop.sh video.mpg 1234

f=$1
fb=`basename $f .mpg`
ss=$2

if [ "$ss" == "" ]
then
  ss=1234
fi

#a few color in bash
TC_LightRed="\033[1;31m"
TC_LightGreen="\033[1;32m"
TC_LightCyan="\033[1;36m"
TC_clear="\033[0m"

#original
ffmpeg -ss $ss -t 1 -i $f -y $fb'_'%06d.png
#crop detect
crop=`ffmpeg -ss $ss -t 1 -i $f -vf cropdetect -y $fb'_'%06d'_crop.png' 2>&1 | grep crop | tail -n 1 | rev | cut -d' ' -f1 | rev`
#crop="crop=720:416:0:80"; /bin/echo -e ${TC_LightCyan}"warning: forced crop !"${TC_clear}
#crop
ffmpeg -ss $ss -t 1 -i $f -vf $crop -y $fb'_'%06d'_crop.png'

ft=$fb'_'`printf %06d 12`
identify $ft.png
identify $ft'_crop.png'

#no crop if standard size SD or HD
if [ "$crop" == "crop=720:576:0:0" ]
then
  crop=NoCropNeeded
fi
if [ "$crop" == "crop=1920:1080:0:0" ]
then
  crop=NoCropNeeded
fi

foo=$fb'_original'.png
foc=$fb'_'$crop.png
mv $ft.png $foo
mv $ft'_crop.png' $foc

echo 'display '$foo' & display '$foc
#exit

#clean
rm $fb'_'??????.png $fb'_'??????'_crop.png'
