#!/bin/bash

#a few color in bash
TC_LightRed="\033[1;31m"
TC_LightGreen="\033[1;32m"
TC_LightCyan="\033[1;36m"
TC_clear="\033[0m"

for f in *.ts
do
  fo=../MPEG/`basename $f .ts`.mpeg
  /bin/echo -e "${TC_LightCyan}"$f $fo"${TC_clear}"
  #probe duration
  d2=`ffprobe $f  2>&1 | grep Dur`
  if [ -e $fo ]
  then
    d4=`ffprobe $fo 2>&1 | grep Dur`
  else
    /bin/echo -e "${TC_LightRed}error:${TC_clear} $fo do not exist."
    continue
  fi
  echo '  '$d2
  echo '  '$d4
  #convert duration to seconds
  today=`date +%Y/%m/%d`; s=`date -d $today +%s`
  ##duration TS
  d=`echo $d2 | cut -d' ' -f2 | sed 's/,//g'`; ds=`date -d $d +%s`
  ((d2=ds-s))
  ##duration mpeg
  d=`echo $d4 | cut -d' ' -f2 | sed 's/,//g'`; ds=`date -d $d +%s`
  ((d4=ds-s))
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
done
