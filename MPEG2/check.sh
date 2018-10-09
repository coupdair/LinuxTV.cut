#!/bin/bash

version=v0.1.1

#a few color in bash
TC_LightRed="\033[1;31m"
TC_LightGreen="\033[1;32m"
TC_LightCyan="\033[1;36m"
TC_clear="\033[0m"

for f in *.mpg
do
  fo=../MPEG4/`basename $f .mpg`.mp4
  echo $f $fo
  #probe duration
  d2=`ffprobe $f  2>&1 | grep Dur`
  if [ -e $fo ]
  then
    d4=`ffprobe $fo 2>&1 | grep Dur`
  else
    /bin/echo -e "${TC_LightRed}error:${TC_clear} $fo do not exist."
    continue
  fi

  #probe Video/Audio channels
  v2=`ffprobe $f  2>&1 | grep Stream | grep Video | wc -l`
  a2=`ffprobe $f  2>&1 | grep Stream | grep Audio | wc -l`
  v4=`ffprobe $fo 2>&1 | grep Stream | grep Video | wc -l`
  a4=`ffprobe $fo 2>&1 | grep Stream | grep Audio | wc -l`

  echo '  '$d2'  V/A: '$v2'/'$a2
  echo '  '$d4'  V/A: '$v4'/'$a4
  #convert duration to seconds
  today=`date +%Y/%m/%d`; s=`date -d $today +%s`
#echo 'today '$today $s
  ##duration mpeg2
  d=`echo $d2 | cut -d' ' -f2 | sed 's/,//g'`; ds=`date -d $d +%s`
#date -d $d +%Y/%m/%d,%Hh%Mmin%Ss
#echo 'hours '$d $ds
  ((d2=ds-s))
#echo $s $ds $d2
  ##duration mpeg4
  d=`echo $d4 | cut -d' ' -f2 | sed 's/,//g'`; ds=`date -d $d +%s`
  ((d4=ds-s))
#echo $s $ds $d4

  #duration difference
  ((d=d4-d2))
  abs=`echo $d | tr -d -`; d=$abs
  if (($d<12))
  then
    /bin/echo -e ${TC_LightGreen}"OK"${TC_clear}
  else
    m=`units $d's' minutes -t | cut -d'.' -f1`
    /bin/echo -e ${TC_LightRed}"KO: difference is around "$d" s, i.e. "$m"min."${TC_clear}
  fi
  if(($a2!=$a4))
  then
    /bin/echo -e ${TC_LightCyan}"warning: Video/Audio differs"${TC_clear}', i.e. MPG='$v2'/'$a2' =! MP4='$v4'/'$a4
  fi
done
