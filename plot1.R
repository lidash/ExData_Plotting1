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

#create file "plot1.png" with plot 1
library(datasets)
png(filename = "plot1.png",width = 480, height = 480, units = "px")
with(df,hist(df$Global_active_power, main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red"))
dev.off()
