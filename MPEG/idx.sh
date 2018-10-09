#!/bin/bash

dvbcut='nice -10 ionice -c 3 /home/xubuntu/code.dvb/dvbcut-0.5.4+svn178/bin/dvbcut'
dvbcut='dvbcut '

f=NexoKnights2_20171001.mpeg
fb=NexoKnights2_20171001

f=$1
fo=../MPEG/`basename $f .mpeg`.idx

$dvbcut -generateidx -idx $fo $f
