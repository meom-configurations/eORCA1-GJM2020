#!/bin/bash


CONFIG=eORCA1
CASE=GJM2020b
JOBNAME=nemo_e2020b

CONFCASE=${CONFIG}-${CASE}
RDIR=$SDIR/$CONFIG/${CONFCASE}-R
CTLDIR=$PDIR/RUN_${CONFIG}/${CONFCASE}/CTL

# is there running job ?
 squeue -u rcli002  -o  " %.15j %.8u %.2t" | grep "$JOBNAME " | grep -q 'R$'

if [ $? = 0 ] ; then
   RUN=1
else
   RUN=0
fi

if [ $RUN = 0 ] ; then
   # check all RST dir in $DDIR
   cd $DDIR
   for d in ${CONFCASE}-RST.* ; do
     if [ ! -f $RDIR/$d.tar ] ; then
       echo create $RDIR/$d.tar
       tar cf $RDIR/$d.tar $d
     else
       echo $RDIR/$d.tar exists ... skip 
     fi
   done
else   # one job is running which one
   seg=$( tail -1 ${CONFCASE}.db | awk '{print $1}' )
   cd $DDIR
   for d in ${CONFCASE}-RST.* ; do
     zseg=$( echo $d | awk -F. '{print $NF}' )
     if [ $zseg != $seg ] ; then
     if [ ! -f $RDIR/$d.tar ] ; then
       echo create $RDIR/$d.tar
       tar cf $RDIR/$d.tar $d
     else
       echo $RDIR/$d.tar exists ... skip 
     fi
     fi
   done
fi

cd $CTLDIR
   

