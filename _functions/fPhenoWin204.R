##select phenological phases for specific years and plants
setwd(file.path(W.DIR,PHASE.DIR))
ph.year1 <- mixedsort(list.files(pattern=paste("^(DOY_)",PLANT,".*",YEAR,"\\.tif$",sep="")),decreasing=TRUE)
ph.year2 <- mixedsort(list.files(pattern=paste("^(DOY_)",PLANT,".*",YEAR-1,"\\.tif$",sep="")),decreasing=TRUE)
ph.year <- ph.year2[grepl(paste("-",10,"_",collapse="|",sep=""), ph.year2)]
ph.year <- append(ph.year,ph.year2[grepl(paste("-",12,"_",collapse="|",sep=""), ph.year2)])
v.p <- c(15,18,21,24)
for(p in v.p){
  ph.year <- append(ph.year,ph.year1[grepl(paste("-",p,"_",collapse="|",sep=""), ph.year1)])  
}
ph.ct <- stack(ph.year)
ph.ct.v <- 1:length(ph.ct@layers)
##import testsite
s <- shapefile(file.path(W.DIR,RU.DIR,RU))  
#reprojection of shapefile
s = spTransform(s, crs(ph.ct))
##crop- and phase-specific DOY quantile calculation
#Initialize progress bar
pb <- txtProgressBar(min=1, max=length(ph.ct@layers), style=3)
#empty data frame
Q <- data.frame(Q=NULL)
#loop for cropping phase-specific DOY quantiles
for (i in ph.ct.v){
  setwd(file.path(W.DIR,PHASE.DIR))
  ph <- ph.ct@layers[[i]]
  #run functions in parallel
  ph.crop <- crop(ph, extent(s))
  #ph.crop <- mask(ph.crop,s)
  plot(ph.crop)
  #quantile calculation
  Q <- rbind(Q,round(quantile(ph.crop,na.rm=TRUE)[[1]],0))
  Q <- rbind(Q,round(quantile(ph.crop,na.rm=TRUE)[[2]],0))
  Q <- rbind(Q,round(quantile(ph.crop,na.rm=TRUE)[[3]],0))
  Q <- rbind(Q,round(quantile(ph.crop,na.rm=TRUE)[[4]],0))
  Q <- rbind(Q,round(quantile(ph.crop,na.rm=TRUE)[[5]],0))
  setTxtProgressBar(pb, i)
}
head(Q)
##plot phenological windows
CT.P <- c(10,12,15,18,21,24)
col.p <- c("#3288BD", #10
             "#e5f4e3", #12
             "#ABDDA4", #15
             "#66C2A5", #18
             "#FDAE61", #21
             "#F46D43", #24
             "#D53E4F") #AH
##data frame with all plant-specific quantiles, years and phases
Q$Q  <- rep(seq(0,100,25),length(ph.ct@layers))
Q$P  <- sort(rep(CT.P,length(seq(0,100,25))))

colnames(Q) <- c("DOY","Quantile","Phase")
write.csv2(Q,
           paste(W.DIR,OUT.DIR,RU,"_",PLANT,"_",YEAR,c(".csv"),sep=""),
           row.names = FALSE)
##split quantile table accorinding to phenologoical phases
Q.P <- split(Q,Q$P)
Q.P
##plot
setwd(file.path(W.DIR,OUT.DIR))
pdf(paste(RU,"_",PLANT,"_",YEAR,c(".pdf"),sep=""), 
          height=4.5,width=10.5)
DOY <- data.frame(DOY=((Q.P[[1]][1,1]-365)):((Q.P[[6]][5,1])),NDVI=-1)
DOY
plot(DOY,
     xaxt="n",
     yaxt="n",
     ylim=c(0,1),
     xlim=c((Q.P[[1]][1,1]-365)-100,Q.P[[6]][5,1])+50,
     ylab="",
     xlab=as.expression(bquote(italic(DOY))),
     cex.lab=1.4)
#axis
x1 <- seq((Q.P[[1]][1,1]-365)-30,Q.P[[6]][5,1]+30,10)
x2 <- seq((Q.P[[1]][1,1]-365)-30,Q.P[[6]][5,1]+30,2)
axis(1, at=x2, col.tick="grey", las=1,labels=FALSE,cex=1.2)
axis(1, at=x1, col.axis="black", las=1,cex=1.2)
#phenological windows
#before tillage
  rect(Q.P[[1]][1,1]-365-30,#min
       0,
       Q.P[[1]][1,1]-365,#max
       1,
       border = "white",
       col=col.p[7],
       density=100)
  rect(Q.P[[1]][1,1]-365,#min
       0,
       Q.P[[2]][2,1]-365,#max
       1,
       border = "white",
       col=col.p[1],
       density=100)
  #P12a
  rect(Q.P[[2]][2,1]-365,#min
       0,
       0,#max
       1,
       border = "white",
       col=col.p[2],
       density=100)
  #P12b
  rect(0,#min
       0,
       Q.P[[3]][1,1],#max
       1,
       border = "white",
       col=col.p[2],
       density=100)
  #P15
  rect(Q.P[[3]][1,1],#min
       0,
       Q.P[[4]][1,1],#max
       1,
       border = "white",
       col=col.p[3],
       density=100)
  #P18
  rect(Q.P[[4]][1,1],#min
       0,
       Q.P[[5]][1,1],#max
       1,
       border = "white",
       col=col.p[4],
       density=100)
  #P21
  rect(Q.P[[5]][1,1],#min
       0,
       Q.P[[6]][1,1],#max
       1,
       border = "white",
       col=col.p[5],
       density=100)
  #P24
  rect(Q.P[[6]][1,1],#min
       0,
       Q.P[[6]][5,1],#max
       1,
       border = "white",
       col=col.p[6],
       density=100)
  #After harvest or before tillage
  rect(Q.P[[6]][5,1],#min
       0,
       Q.P[[6]][5,1]+30,#max
       1,
       border = "white",
       col=col.p[7],
       density=100)
abline(v=0,col="grey",lwd=2)
legend("topright", title="PHASE",
       legend=c(paste(CT.P),"FL"),
       fill=col.p,bty="n")

dev.off()
