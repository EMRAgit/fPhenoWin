# fPhenoWin
R functions for the derivation of annual crop-specific phenological windows
* fPhenoWin() is excecuted by calling "call_fPhenoWin.R" by defining the following inputs:
** W.DIR - working directory
** RU.DIR - direction with reference unit shape file
** RU - name of reference unit shape file (without ".shp")
** PHASE.DIR - direction with interpolated phenological observations
** OUT.DIR - direction for output files 
** YEAR - year,
** PLANT - crop type ()
#-----------------------------------------------------------------------------------------------------
print("Working directory, data and settings")
#-----------------------------------------------------------------------------------------------------
W.DIR <- "..."
FUNC.DIR <- "_fPhenoWin/_functions/"
#-----------------------------------------------------------------------------------------------------
print("Import functions")
#-----------------------------------------------------------------------------------------------------
source(file.path(W.DIR,FUNC.DIR,"fPhenoWin.R"))
#-----------------------------------------------------------------------------------------------------
print("Call function")
#-----------------------------------------------------------------------------------------------------
PLANT <- 202
YEAR <- 2018
RU.DIR = "_fPhenoWin/_input/"
PHASE.DIR = "_fPhase/_output/"
OUT.DIR <- "_fPhenoWin/_output/"
RU = "VG250_KRS_UCKERMARK_epsg25832"

setwd(file.path(W.DIR,OUT.DIR))
pdf(paste(RU,"_",PLANT,"_",YEAR,c(".pdf"),sep=""), 
    height=3.5,width=10)
fPhenoWin(W.DIR,
          RU.DIR,
          PHASE.DIR,
          OUT.DIR,
          YEAR,
          PLANT,
          RU)
dev.off()
