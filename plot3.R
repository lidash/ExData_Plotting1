##read file
con <- file("household_power_consumption.txt")
B<-readLines(con,n=1)
B1<-strsplit(B,";")
A<-grep('^[1-2]/2/2007',readLines(con),value=TRUE)
tf<-tempfile()
writeLines(A,tf)
df<-read.csv(tf,sep=";",head=FALSE,dec=".",stringsAsFactors=FALSE)
unlink(tf)

##insert appropriate names of columns
for(i in 1:length(df)){
        names(df)[i]<-B1[[1]][i]
}

##create new column for axis x
aa1<-df[,1]
bb1<-df[,2]
df$datatime<-strptime(paste(aa1,bb1,sep=" "),format="%d/%m/%Y %H:%M:%S")

#create file "plot3.png" with plot 3
library(datasets)
png(filename = "plot3.png",width = 480, height = 480, units = "px")
with(df,{
        plot(datatime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="",ylim=c(min(df[,7:9]),max(df[,7:9])))
        par(new=TRUE)
        plot(datatime,Sub_metering_2,type="l", col="red",ylim=c(min(df[,7:9]),max(df[,7:9])),ylab="",xlab="")
        par(new=TRUE)
        plot(datatime,Sub_metering_3,type="l", col="blue",ylim=c(min(df[,7:9]),max(df[,7:9])),ylab="",xlab="")
        legend("topright",lty=1,col=c("black", "red","blue"),legend=names(df[7:9]))
})
dev.off()  