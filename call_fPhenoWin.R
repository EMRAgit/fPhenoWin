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
fPhenoWinSeason(W.DIR,
          RU.DIR,
          PHASE.DIR,
          OUT.DIR,
          YEAR,
          PLANT,
          RU)
dev.off()
