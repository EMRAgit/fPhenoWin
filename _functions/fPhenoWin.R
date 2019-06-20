#######################################################################################################
#######################################################################################################
#######################################################################################################
#function for plotting  phase- and plant-specific phenological windows
#######################################################################################################
#######################################################################################################
#######################################################################################################
#packages
#######################################################################################################
loadandinstall <- function(mypkg) {if (!is.element(mypkg,
                                                   installed.packages()[,1])){install.packages(mypkg)};
  library(mypkg, character.only=TRUE)}

pk <- c("raster",
        "rgdal",
        "pheno",
        "maptools",
        "RColorBrewer",
        "classInt",
        "snow",
        "parallel",
        "gtools")
for(i in pk){loadandinstall(i)}
#######################################################################################################
#######################################################################################################
#select phenological raster folder
#######################################################################################################
#DWD PLANT TYPE
#202 - Winter Wheat
#204 - Winter Barley
#205 - Rapeseed
#215 - Maize
#253 - Sugar Beet 
#######################################################################################################
#PhenoWin parameters
#######################################################################################################
#pheno.dir -> directory of interpolated phenological phases
#ts.dir -> directory of test sites
#result.dir -> directory of results 
#YEAR
#PLANT -> DWD plant type
#TS  <- shape file of test site
#EPSG <- epsg code (see http://spatialreference.org)
#######################################################################################################
#PhenoWin function
#######################################################################################################
fPhenoWin <- function(W.DIR,
                     RU.DIR,
                     PHASE.DIR,
                     OUT.DIR,
                     YEAR,
                     PLANT,
                     RU){

#----------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------
##plant-specific  phenological windows
#----------------------------------------------------------------------------------------------
setwd(file.path(W.DIR,RU.DIR))
setwd(file.path(W.DIR,PHASE.DIR))
ph.year <- mixedsort(list.files(pattern=paste("^(DOY_)",PLANT,".*",YEAR,"\\.tif$",sep="")),decreasing=TRUE)

if(PLANT == 202){source(file.path(W.DIR,FUNC.DIR,"fPhenoWin202.R"))}
if(PLANT == 204){source(file.path(W.DIR,FUNC.DIR,"fPhenoWin204.R"))}
if(PLANT == 205){source(file.path(W.DIR,FUNC.DIR,"fPhenoWin205.R"))}
}
