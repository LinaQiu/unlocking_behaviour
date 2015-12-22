library(stringr)
library(readr)
suppressPackageStartupMessages(library("dplyr"))

data1 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-0da96b025ab3b4793bb734e1ed9ecad8a10c2019.csv",sep = ";",header=FALSE)
#Get the corresponding columns we care about out from the dataset
user1Data <- data1 %>% select(V1,V2,V7)
#Set proper column names to these 3 columns
colnames(user1Data) <- c("sesID","sesType","dateTime")
user1Data <- user1Data %>% mutate(date=as.Date(dateTime))
##find how many days were recorded in this dataset
range(user1Data$date)          ##2013-04-09 ---- 2013-12-30
beginDate <- user1Data$date %>% head(1)
endDate <- user1Data$date %>% tail(1)
recordDay <- as.numeric(endDate-beginDate)
	
user1LSES <- user1Data %>% filter(sesType=="LSES")
user1USES <- user1Data %>% filter(sesType=="USES")
user1OVERALL <- user1Data %>% filter(sesType %in% c("LSES","USES"))

##Compute average interactions per day for user1 here
avg_user1LSES <- nrow(user1LSES)/recordDay
avg_user1USES <- nrow(user1USES)/recordDay
avg_user1OVERALL <- nrow(user1OVERALL)/recordDay

##Seems like user2 never locked his phone, cut user2 out for now
#data2 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-0f88f6d072713402b0a74911fcce9f29db143095.csv",sep = ";",header = FALSE)

data3 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-77a930be572368d9b54de10adcfffacc6ce19a90.csv",sep = ";",header = FALSE)
user3Data <- data3 %>% select(V1,V2,V7)
colnames(user3Data) <- c("sesID","sesType","dateTime")
user3Data <- user3Data %>% mutate(date=as.Date(dateTime))

##find how many days were recorded in this dataset
range(user3Data$date)          ##2013-09-10 ---- 2014-01-01
beginDate <- user3Data$date %>% head(1)
endDate <- user3Data$date %>% tail(1)
recordDay <- as.numeric(endDate-beginDate)

user3LSES <- user3Data %>% filter(sesType=="LSES")
user3USES <- user3Data %>% filter(sesType=="USES")
user3OVERALL <- user3Data %>% filter(sesType %in% c("LSES","USES"))

##Compute average interactions per day for user3 here
avg_user3LSES <- nrow(user3LSES)/recordDay
avg_user3USES <- nrow(user3USES)/recordDay
avg_user3OVERALL <- nrow(user3OVERALL)/recordDay


data4 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-8926ff5477452ba9aea697f796e7d3570195576f.csv",sep = ";",header = FALSE)
user4Data <- data4 %>% select(V1,V2,V7)
colnames(user4Data) <- c("sesID","sesType","dateTime")
user4Data <- user4Data %>% mutate(date=as.Date(dateTime))

##find how many days were recorded in this dataset
range(user4Data$date)          ##2013-01-25 ---- 2014-12-31
beginDate <- user4Data$date %>% head(1)
endDate <- user4Data$date %>% tail(1)
recordDay <- as.numeric(endDate-beginDate)

user4LSES <- user4Data %>% filter(sesType=="LSES")
user4USES <- user4Data %>% filter(sesType=="USES")
user4OVERALL <- user4Data %>% filter(sesType %in% c("LSES","USES"))

##Compute average interactions per day for user4 here
avg_user4LSES <- nrow(user4LSES)/recordDay
avg_user4USES <- nrow(user4USES)/recordDay
avg_user4OVERALL <- nrow(user4OVERALL)/recordDay

data5 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-afaa80bdc9bc347754db7213056c0e00ba011e13.csv",sep = ";",header = FALSE)
user5Data <- data5 %>% select(V1,V2,V7)
colnames(user5Data) <- c("sesID","sesType","dateTime")
user5Data <- user5Data %>% mutate(date=as.Date(dateTime))

##find how many days were recorded in this dataset
range(user5Data$date)          ##2011-10-07 ---- 2013-08-16
beginDate <- user5Data$date %>% head(1)
endDate <- user5Data$date %>% tail(1)
recordDay <- as.numeric(endDate-beginDate)

user5LSES <- user5Data %>% filter(sesType=="LSES")
user5USES <- user5Data %>% filter(sesType=="USES")
user5OVERALL <- user5Data %>% filter(sesType %in% c("LSES","USES"))

##Compute average interactions per day for user5 here
avg_user5LSES <- nrow(user5LSES)/recordDay
avg_user5USES <- nrow(user5USES)/recordDay
avg_user5OVERALL <- nrow(user5OVERALL)/recordDay

data6 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-e654bb1e3f6f9340cee14dc4de24c8fe079a027d.csv",sep = ";",header = FALSE)
user6Data <- data6 %>% select(V1,V2,V7)
colnames(user6Data) <- c("sesID","sesType","dateTime")
user6Data <- user6Data %>% mutate(date=as.Date(dateTime))

##find how many days were recorded in this dataset
range(user6Data$date)          ##2013-09-17 ---- 2013-12-12
beginDate <- user6Data$date %>% head(1)
endDate <- user6Data$date %>% tail(1)
recordDay <- as.numeric(endDate-beginDate)

user6LSES <- user6Data %>% filter(sesType=="LSES")
user6USES <- user6Data %>% filter(sesType=="USES")
user6OVERALL <- user6Data %>% filter(sesType %in% c("LSES","USES"))

##Compute average interactions per day for user6 here
avg_user6LSES <- nrow(user6LSES)/recordDay
avg_user6USES <- nrow(user6USES)/recordDay
avg_user6OVERALL <- nrow(user6OVERALL)/recordDay

##Create a data frame to store all "avg_" stuff (e.g. avg_user1LSES, avg_user1USES, etc.)
avg_interactPerday <- data.frame(c(avg_user1OVERALL,avg_user3OVERALL,avg_user4OVERALL,avg_user5OVERALL,avg_user6OVERALL),
																 c(avg_user1LSES,avg_user3LSES,avg_user4LSES,avg_user5LSES,avg_user6LSES),
																 c(avg_user1USES,avg_user3USES,avg_user4USES,avg_user5USES,avg_user6USES))

##Give each column a meaningful name
colnames(avg_interactPerday) <- c("Overall","Locked","Unlocked")

##Draw a box plot for average number of interactions per day
boxplot(avg_interactPerday,ylab="Average nr of interactions per day")
##Compute mean of average nr interactions per day and then add mean points on boxplot
means <- c(mean(avg_interactPerday$Overall),mean(avg_interactPerday$Locked),mean(avg_interactPerday$Unlocked))
points(1:3,means,col="red")

dev.copy(png,'AverageInteractions.png')
dev.off()

