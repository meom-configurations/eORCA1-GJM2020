#!/bin/bash
#SBATCH -J mergxios-d
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --ntasks-per-node=40
#SBATCH --time=2:00:00
#SBATCH -e zmergxios.e%j
#SBATCH -o zmergxios.o%j
#SBATCH -A cli@cpu
#SBATCH --exclusive


CONFIG=eORCA1
CASE=GJM2020d
CONFCASE=${CONFIG}-${CASE}

seg1=$1
seg2=$2
for seg in $( seq $seg1 $seg2) ; do 
        ulimit -s unlimited
      . /gpfswork/rech/cli/rcli002/DEVGIT/DCM_4.0.2/RUNTOOLS/lib/function_4.sh
      . /gpfswork/rech/cli/rcli002/DEVGIT/DCM_4.0.2/RUNTOOLS/lib/function_4_all.sh
         DDIR=/gpfsscratch/rech/cli/rcli002
         zXIOS=/gpfsscratch/rech/cli/rcli002/${CONFCASE}-XIOS.$seg
         mergeprog=mergefile_mpp4.exe
         cd $zXIOS
         # deal with scalar files
         ls *scalar*0000.nc > /dev/null  2>&1
         if [ $? = 0 ] ; then
            mkdir -p SCALAR
            mv *scalar*.nc SCALAR
            cd SCALAR
              for f in *scalar*_0000.nc ; do
                 CONFCASE=$( echo $f | awk -F_ '{print $1}' )
                 freq=$( echo $f | awk -F_ '{print $2}' )
                 freq_unit=${freq:1}
                 tag=$( echo $f | awk -F_ '{print $5}' | awk -F- '{print $1}' )

                 case  $freq_unit  in
                 ('m') date=y${tag:0:4}m${tag:4:2} ;;
                 ('y') date=y${tag:0:4} ;;
                 ( * ) date=y${tag:0:4}m${tag:4:2}d${tag:6:2} ;;
                 esac

                 typ=$(echo $f | awk -F_ '{ print $3}')
                 case $typ in
                 ( 'SBC' ) filext='icescalar' ;;
                 ( 'FWB' ) filext='fwbscalar' ;;
                 ( *     ) filext='unkscalar' ;;
                 esac

                 g=${CONFCASE}_${date}.${freq}_${filext}.nc
                 OUTDIR=../${freq}_OUTPUT
                 mkdir -p $OUTDIR
                 cp $f $OUTDIR/$g

              done
            cd  $zXIOS

         # end scalar file
         fi
         ln -sf /gpfswork/rech/cli/rcli002/bin/mergefile_mpp4.exe ./
             runcode 40 ./$mergeprog -F -c eORCA1_domain_cfg.nc -r
done
