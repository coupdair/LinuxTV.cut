#!/bin/bash

convert=../MPEG/mpgHD2mp2.sh
#convert=../MPEG/mpgHD2mp2HD.sh

#for f in *.ts
for f in $*
do
  fh=`basename $f .ts`.out
  echo $fh
  nohup $convert $f 2>&1 > $fh &
done
