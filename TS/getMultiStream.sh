#!/bin/bash

#a few color in bash
TC_LightRed="\033[1;31m"
TC_LightGreen="\033[1;32m"
TC_LightCyan="\033[1;36m"
TC_clear="\033[0m"

for f in *.ts
do
  #probe Video Stream(s)
  n=`ffprobe $f  2>&1 | grep Stream | grep Video | wc -l`
  if((n>1))
  then
    /bin/echo -e "${TC_LightCyan}"$f"${TC_clear}"
    echo $n' Video Stream(s)'
    ffprobe $f  2>&1 | grep Stream
  fi
done
