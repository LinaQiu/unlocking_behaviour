library(stringr)
library(readr)
suppressPackageStartupMessages(library("dplyr"))

data1 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-0da96b025ab3b4793bb734e1ed9ecad8a10c2019.csv",sep = ";",header=FALSE)
data3 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-77a930be572368d9b54de10adcfffacc6ce19a90.csv",sep = ";",header = FALSE)
data4 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-8926ff5477452ba9aea697f796e7d3570195576f.csv",sep = ";",header = FALSE)
data5 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-afaa80bdc9bc347754db7213056c0e00ba011e13.csv",sep = ";",header = FALSE)
data6 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-e654bb1e3f6f9340cee14dc4de24c8fe079a027d.csv",sep = ";",header = FALSE)

data <- list(data1,data3,data4,data5,data6)

##Create a matrix to store the result(avg_userLSES,avg_userUSES,avg_userOVERALL) we compute in the for loop
avg_interactPerday <- matrix(0,length(data),3)

for (i in 1:length(data))       ## for each data frame in list data, in other words, we run the for loop for each participant
{
	#Get the corresponding columns we care about out from the dataset
	userData <- as.data.frame(data[i]) %>% select(V1,V2,V7)
	#Set proper column names to these 3 columns
	colnames(userData) <- c("sesID","sesType","dateTime")
	userData <- userData %>% mutate(date=as.Date(dateTime))
	##find how many days were recorded in this dataset
	range(userData$date)          ##2013-04-09 ---- 2013-12-30
	beginDate <- userData$date %>% head(1)
	endDate <- userData$date %>% tail(1)
	recordDay <- as.numeric(endDate-beginDate)
	
	userLSES <- userData %>% filter(sesType=="LSES")
	userUSES <- userData %>% filter(sesType=="USES")
	userOVERALL <- userData %>% filter(sesType %in% c("LSES","USES"))
	
	##Compute average interactions per day for the ith user here
	avg_userLSES <- nrow(userLSES)/recordDay
	avg_userUSES <- nrow(userUSES)/recordDay
	avg_userOVERALL <- nrow(userOVERALL)/recordDay
	
	avg_interactPerday[i,] <- c(avg_userOVERALL,avg_userLSES,avg_userUSES)
}

## Convert matrix avg_interactPerday into a data frame
avg_interactPerday <- data.frame(avg_interactPerday)

##Give each column a meaningful name
colnames(avg_interactPerday) <- c("Overall","Locked","Unlocked")

##Draw a box plot for average number of interactions per day
boxplot(avg_interactPerday,ylab="Average nr of interactions per day")
##Compute mean of average nr interactions per day and then add mean points on boxplot
means <- c(mean(avg_interactPerday$Overall),mean(avg_interactPerday$Locked),mean(avg_interactPerday$Unlocked))
points(1:3,means,col="red")

dev.copy(png,'AverageInteractions.png')
dev.off()


