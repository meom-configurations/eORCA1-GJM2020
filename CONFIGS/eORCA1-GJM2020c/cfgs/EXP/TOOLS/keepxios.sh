#!/bin/bash

CONFIG=eORCA1
CASE=GJM2020c
JOBNAME=nemo_e2020c
freq=1d

CONFCASE=${CONFIG}-${CASE}
RDIR=$SDIR/$CONFIG/${CONFCASE}-R
CTLDIR=$PDIR/RUN_${CONFIG}/${CONFCASE}/CTL
SSDIR=$DDIR/${CONFIG}/${CONFCASE}-S/$freq

# is there running job ?
 squeue -u rcli002  -o  " %.15j %.8u %.2t" | grep "$JOBNAME " | grep -q 'R$'

if [ $? = 0 ] ; then
   RUN=1
else
   RUN=0
fi

if [ $RUN = 0 ] ; then
   seg=none
else
   seg=$( tail -1 $CTLDIR/${CONFCASE}.db | awk '{print $1}' )
   echo "     # Segment $seg of ${CONFCASE} actually running"
   echo
fi
   # check all XIOS dir in $DDIR
   seglist=()
   cd $DDIR
   for d in ${CONFCASE}-XIOS.* ; do
     zseg=$( echo $d | awk -F. '{print $NF}' )
     if [ $zseg != $seg ] ; then
        tmp=$( grep  "^$zseg" $CTLDIR/${CONFCASE}.db  | awk '{print $4}' )
        zyr=${tmp:0:4}
        echo Segment $zseg corresponds to year $zyr
        # check if this year is treated
        if [ -d $SSDIR/$zyr ] ; then
          sz=$( du -sh $SSDIR/$zyr | awk '{print $1}' )
          if [ $sz != 49G -a $sz != 50G ] ; then 
            todo=1
          else
            todo=0
            echo "erasing $DDIR/$d"
            rm -rf $DDIR/$d
          fi
        else
           todo=1
        fi
     else
       echo "#      Running segment $seg, skip $d"
       todo=0
     fi
     if [ $todo = 1 ] ; then
       # check if 1d_OUTPUT exists
       ls $d/1d_OUTPUT > /dev/null 2>&1
       if [ $? = 0 ] ; then
         # 1d_OUTPUT exists
         cd $d
         ../dcmtk_mvnc2s_mvfast
         cd ../
         
       else
          echo Segment $zseg for $CONFCASE must be mergedxios
          seglist=( ${seglist[@]} $zseg )
       fi
     fi
     
   done

cd $CTLDIR
  echo " List of segments to be rebuilt : ${seglist[@]}"
  n=${#seglist[@]}
  echo  " $n segments  to rebuild"
 if [ $n != 0 ] ; then
  seg1=${seglist[0]}
  seg2=${seglist[$(( n - 1 ))]}

  sbatch --qos=qos_cpu-dev mergxios.nnn.sh $seg1 $seg2 
fi
