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

#create file "plot2.png" with plot 2
library(datasets)
png(filename = "plot2.png",width = 480, height = 480, units = "px")
with(df,plot(datatime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))
dev.off()