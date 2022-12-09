# eORCA1-GJM2020 : a Low resolution configuration, comparable with eORCA12.L75-GJM2020

## Overview
eORCA1-GJM2020 experiments were performed with similar setting than eORCA12.L75-GJM2020, for comparison of the mixed layer physics. At low resolution, parametrizations for missing eddies effects are available in NEMO:
   * Eddy Induced Velocity ( eiv) (aka Gent Mc Williams 90 or GM90 for short).
   * Mixed Layer Eddies (mle) (aka Fox-Kemper 2016 or FK16 for short).

In a series of experiments the impacts of eiv and mle are explored.

## Experiments
### **eORCA1-GJM2020 :** base line
  * This configuration uses the standard settings of eORCA1 configuration
    * **eiv** GM90
    * **No mle** no FK16
  * Forced by JRA55, 3-hourly fields
  * Use NCAR bulk formulae (aka CORE).
  * Use TEOS-10 equation of state, hence:
    * Temperatures are Conservative temperatures (CT) [deg C].
    * Salinity are Absolute Salinity (SA) [g/kg]
  * Run starts in 1979 from WOA13 initial TS conditions at rest.
  * Period : 1979-2019

  ```
!-----------------------------------------------------------------------
&namtra_eiv    !   eddy induced velocity param.                         (default: OFF)
!-----------------------------------------------------------------------
   ln_ldfeiv   = .true.   ! use eddy induced velocity parameterization
      !
      !                        !  Coefficients:
      nn_aei_ijk_t    = 0           !  space/time variation of eddy coefficient:
      !                             !   =-20 (=-30)    read in eddy_induced_velocity_2D.nc (..._3D.nc) file
      !                             !   =  0           constant
      !                             !   = 10 F(k)      =ldf_c1d
      !                             !   = 20 F(i,j)    =ldf_c2d
      !                             !   = 21 F(i,j,t)  =Treguier et al. JPO 1997 formulation
      !                             !   = 30 F(i,j,k)  =ldf_c2d * ldf_c1d
      !                        !  time invariant coefficients:  aei0 = 1/2  Ue*Le
      rn_Ue        = 0.02           !  lateral diffusive velocity [m/s] (nn_aht_ijk_t= 0, 10, 20, 30)
      rn_Le        = 200.e+3        !  lateral diffusive length   [m]   (nn_aht_ijk_t= 0, 10)
      !
      ln_ldfeiv_dia =.false.   ! diagnose eiv stream function and velocities
/
!-----------------------------------------------------------------------
&namtra_mle    !   mixed layer eddy parametrisation (Fox-Kemper)       (default: OFF)
!-----------------------------------------------------------------------
   ln_mle      = .false.   ! (T) use the Mixed Layer Eddy (MLE) parameterisation
...
/
  ```

### **eORCA1-GJM2020b :** Same as base line  + Fox Kemper (mle)
  * **eiv** 
  * **mle** Fox-Kemper parametrization
  * Run starts from GJM2020 restart files 01.01.2000
  * Period: 2000-2019

   ```
!-----------------------------------------------------------------------
&namtra_eiv    !   eddy induced velocity param.                         (default: OFF)
!-----------------------------------------------------------------------
   ln_ldfeiv   = .true.   ! use eddy induced velocity parameterization
      !
      !                        !  Coefficients:
      nn_aei_ijk_t    = 0           !  space/time variation of eddy coefficient:
      !                             !   =-20 (=-30)    read in eddy_induced_velocity_2D.nc (..._3D.nc) file
      !                             !   =  0           constant
      !                             !   = 10 F(k)      =ldf_c1d
      !                             !   = 20 F(i,j)    =ldf_c2d
      !                             !   = 21 F(i,j,t)  =Treguier et al. JPO 1997 formulation
      !                             !   = 30 F(i,j,k)  =ldf_c2d * ldf_c1d
      !                        !  time invariant coefficients:  aei0 = 1/2  Ue*Le
      rn_Ue        = 0.02           !  lateral diffusive velocity [m/s] (nn_aht_ijk_t= 0, 10, 20, 30)
      rn_Le        = 200.e+3        !  lateral diffusive length   [m]   (nn_aht_ijk_t= 0, 10)
      !
      ln_ldfeiv_dia =.false.   ! diagnose eiv stream function and velocities
/
!-----------------------------------------------------------------------
&namtra_mle    !   mixed layer eddy parametrisation (Fox-Kemper)       (default: OFF)
!-----------------------------------------------------------------------
   ln_mle      = .true.   ! (T) use the Mixed Layer Eddy (MLE) parameterisation
   rn_ce       = 0.06      ! magnitude of the MLE (typical value: 0.06 to 0.08)
   nn_mle      = 1         ! MLE type: =0 standard Fox-Kemper ; =1 new formulation
   rn_lf       = 5.e+3     ! typical scale of mixed layer front (meters)                      (case rn_mle=0)
   rn_time     = 172800.   ! time scale for mixing momentum across the mixed layer (seconds)  (case rn_mle=0)
   rn_lat      = 20.       ! reference latitude (degrees) of MLE coef.                        (case rn_mle=1)
   nn_mld_uv   = 0         ! space interpolation of MLD at u- & v-pts (0=min,1=averaged,2=max)
   nn_conv     = 0         ! =1 no MLE in case of convection ; =0 always MLE
   rn_rho_c_mle = 0.01      ! delta rho criterion used to calculate MLD for FK
/
   ```

### **eORCA1-GJM2020c :** Same as base line but NO eiv, NO mle
  * **NO eiv** 
  * **NO mle** 
  * Run starts from GJM2020 restart files 01.01.2000
  * Period: 2000-2019

  ```
!-----------------------------------------------------------------------
&namtra_eiv    !   eddy induced velocity param.                         (default: OFF)
!-----------------------------------------------------------------------
   ln_ldfeiv   = .false.   ! use eddy induced velocity parameterization
/
!-----------------------------------------------------------------------
&namtra_mle    !   mixed layer eddy parametrisation (Fox-Kemper)       (default: OFF)
!-----------------------------------------------------------------------
   ln_mle      = .false.   ! (T) use the Mixed Layer Eddy (MLE) parameterisation
/

  ```

### **eORCA1-GJM2020d :** Same as base line but NO eiv,  mle
  * **NO eiv** 
  * **mle** 
  * Run starts from GJM2020 restart files 01.01.2000
  * Period: 2000-2019

  ```
!-----------------------------------------------------------------------
&namtra_mle    !   mixed layer eddy parametrisation (Fox-Kemper)       (default: OFF)
!-----------------------------------------------------------------------
   ln_mle      = .true.   ! (T) use the Mixed Layer Eddy (MLE) parameterisation
   rn_ce       = 0.06      ! magnitude of the MLE (typical value: 0.06 to 0.08)
   nn_mle      = 1         ! MLE type: =0 standard Fox-Kemper ; =1 new formulation
   rn_lf       = 5.e+3     ! typical scale of mixed layer front (meters)                      (case rn_mle=0)
   rn_time     = 172800.   ! time scale for mixing momentum across the mixed layer (seconds)  (case rn_mle=0)
   rn_lat      = 20.       ! reference latitude (degrees) of MLE coef.                        (case rn_mle=1)
   nn_mld_uv   = 0         ! space interpolation of MLD at u- & v-pts (0=min,1=averaged,2=max)
   nn_conv     = 0         ! =1 no MLE in case of convection ; =0 always MLE
   rn_rho_c_mle = 0.01      ! delta rho criterion used to calculate MLD for FK
/
!-----------------------------------------------------------------------
&namtra_eiv    !   eddy induced velocity param.                         (default: OFF)
!-----------------------------------------------------------------------
   ln_ldfeiv   = .false.   ! use eddy induced velocity parameterization
      !
      !                        !  Coefficients:
      nn_aei_ijk_t    = 0           !  space/time variation of eddy coefficient:
      !                             !   =-20 (=-30)    read in eddy_induced_velocity_2D.nc (..._3D.nc) file
      !                             !   =  0           constant
      !                             !   = 10 F(k)      =ldf_c1d
      !                             !   = 20 F(i,j)    =ldf_c2d
      !                             !   = 21 F(i,j,t)  =Treguier et al. JPO 1997 formulation
      !                             !   = 30 F(i,j,k)  =ldf_c2d * ldf_c1d
      !                        !  time invariant coefficients:  aei0 = 1/2  Ue*Le
      rn_Ue        = 0.02           !  lateral diffusive velocity [m/s] (nn_aht_ijk_t= 0, 10, 20, 30)
      rn_Le        = 200.e+3        !  lateral diffusive length   [m]   (nn_aht_ijk_t= 0, 10)
      !
      ln_ldfeiv_dia =.false.   ! diagnose eiv stream function and velocities
/
  ```


## Results:

