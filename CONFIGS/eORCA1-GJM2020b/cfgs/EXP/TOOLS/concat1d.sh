#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --ntasks-per-node=40
#SBATCH --threads-per-core=1
#SBATCH -A cli@cpu
#SBATCH --hint=nomultithread
#SBATCH -J CONCAT1d
#SBATCH -e zconcat1d.e%j
#SBATCH -o zconcat1d.o%j
#SBATCH --time=2:00:00
##SBATCH --exclusive

CONFIG=eORCA1
CASE=GJM2020b
freq=1d

y1=2012
y2=2019
ny=$(( y2 - y1 + 1 ))

CONFCASE=${CONFIG}-${CASE}

ROOTDIR=$DDIR/$CONFIG
SSDIR=$ROOTDIR/${CONFCASE}-S/$freq
TGTDIR=$SDIR/$CONFIG/${CONFCASE}-S/$freq

cd $SSDIR
for y in $(seq $y1 $y2 ) ; do
  ( mkdir -p $TGTDIR/${y}-concat

  cd $y
   for typ in $( ls *m01d01* | awk -F_ '{print $NF}' ) ; do
      ncrcat ${CONFCASE}_y${y}m??d??.${freq}_$typ  $TGTDIR/${y}-concat/${CONFCASE}_y${y}.1d_$typ
   done
  cd ../ ) &
done 
wait
