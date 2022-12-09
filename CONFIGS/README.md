# eORCA1-GJM2020 series : numerical code
## Context

   * This code is based upon NEMO at realease 4.0.2 (https://forge.ipsl.jussieu.fr/nemo/svn/NEMO/releases/r4.0/r4.0.2) at rev 12591.
  * It uses the DCM from https://github.com/meom-group/DCM.git at commit 0ef6ef22bfe )
    * CPP keys are :
    
    ```
    key_iomput
    key_mpp_mpi
    key_netcdf4
    key_si3
    key_drakkar
    ```

    * key_drakkar forces to use some DRAKKAR improvements, mainly regarding the management of the simulations (restart files, ouptut files etc...). 
  * This config is intended to be as close as possible to the high resolution eORCA12.L75-GJM2020, but :
    * No explicit iceberg calving is used
    * Iceberg melting climatology is used instead, as part of the runoff.
  * **Code is identical for all experiments**
    * The only differences are passed through the namelist parameters.

## Organisation of the directories
  * There is a directory for each configuration.
  * The code is only given for eORCA1-GJM2020 (identical for all other).
  * In cfgs/EXP subdirectory, the namelists, XIOS xml files are given as well as the used running scripts and tools.
  * Input files ( grid, initial conditions, weight files etc...) can be obtained using :

  ```
     wget --no-check-certificate https://ige-meom-opendap.univ-grenoble-alpes.fr/thredds/fileServer/meomopendap/extract/eORCA1/eORCA1-I.tgz
  ```
## Technical details for the implementation on Jean-Zay@idris
  * NEMO : 240 cores on 6 computing nodes (40 cores each)
    * 3 annual segments per submitted job (in about 1:30 elapsed). 
  * XIOS : 8 cores on 1 computing node (depopulated )
    * produce daily outout in `multiple_file` mode.
    * recombination in global files performed together with chunking and compressing (netcdfF/HDF5, deflation level : 1 ).
  * overall cost for these simulations : ( 81 years )
    * nemo+xios : 11734 CPUH  --> 144.8 h/yrs
    * recombine :   120 CPUH
  * Size of the data set:
    * GJM2020  : 1.9 Tb
    * GJM2020b : 0.9 Tb
    * GJM2020c : 0.9 Tb
