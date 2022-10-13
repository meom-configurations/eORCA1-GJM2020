# eORCA1-GJM2020 seried : numerical code
## Context

   * This code is based upon NEMO at realease 4.0.2 (https://forge.ipsl.jussieu.fr/nemo/svn/NEMO/releases/r4.0/r4.0.2) at rev 12591.
  * It uses the DCM framework (github.com:meom-group/DCM.git at commit 0ef6ef22bfe )
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


