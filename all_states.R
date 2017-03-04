# Read data from file
dt<-read.csv("Processed_data.csv", header = T)


#Select only 4 columns that we need
dt<- select (dt, Provider.State, DRG.Definition, Average.Covered.Charges, 
             Average.Total.Payments)

# Aggregate 2 columns by grouping anothet two 
final<-aggregate(cbind(dt$Average.Covered.Charges,dt$Average.Total.Payments), 
                 by=list(dt$DRG.Definition,dt$Provider.State), FUN="mean")

#Plotting. For every different state we create seperate plot in corresponding file
par(mfrow=c(1,1))
for (i in unique(final$Group.2)){
    plot.new()
    dev.copy(png, file=paste(i, ".png",sep=""), width=480, height=480)
    with (subset(final, final$Group.2==i), 
          {plot (V1,V2, col=unique(Group.1), main=i, xlab="Average Covered Charges", 
                ylab="Average Total Payments" )
          legend("topleft", col=unique(final$Group.1), 
                   as.character(unique(final$Group.1)), lty=c(1,1) , cex=0.5)}
          )
    dev.off()
}


