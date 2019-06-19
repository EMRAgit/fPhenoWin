# fPhenoWin
R functions for the derivation of annual crop-specific phenological windows
* fPhenoWin() is developed and tested for Windows 8/10 and R-3.4.3
* fPhenoWin() is excecuted by calling "call_fPhenoWin.R" by defining the following inputs:
  * W.DIR - working directory
  * RU.DIR - direction with reference unit shape file
  * RU - name of reference unit shape file (without ".shp")
  * PHASE.DIR - direction with interpolated phenological observations
  * OUT.DIR - directory storing output files
  * YEAR - year,
  * PLANT - crop type (https://github.com/EMRAgit/fPhenoWin/blob/master/_input/AvailablePhases.txt)
