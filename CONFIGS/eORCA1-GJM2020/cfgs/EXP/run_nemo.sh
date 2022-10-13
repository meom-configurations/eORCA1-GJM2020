#!/bin/bash
date
set -x
##############################################
#  wrapper for submitting nemo4 
##############################################

if [ ! $PDIR ] ; then
   echo "You must set up your environment for DCM before using the RUN_TOOLS"
   echo PDIR environment variable not set
   exit 1
fi
CONFIG=eORCA1
CASE=GJM2020
CONFCASE=${CONFIG}-${CASE}

set +x
. ./includefile.sh   # define SUBMIT command according to the machine

echo " All required tools and scripts copied on the home of production machine"
echo " submitting ${SUBMIT_SCRIPT} "

rm -f $TMPDIR/STOP*

$SUBMIT  ./${SUBMIT_SCRIPT}
#source  ./${SUBMIT_SCRIPT}
