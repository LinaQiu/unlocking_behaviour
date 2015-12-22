library(stringr)
library(readr)
library(ggplot2)
suppressPackageStartupMessages(library("dplyr"))

data1 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-0da96b025ab3b4793bb734e1ed9ecad8a10c2019.csv",sep = ";",header=FALSE)
data3 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-77a930be572368d9b54de10adcfffacc6ce19a90.csv",sep = ";",header = FALSE)
data4 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-8926ff5477452ba9aea697f796e7d3570195576f.csv",sep = ";",header = FALSE)
data5 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-afaa80bdc9bc347754db7213056c0e00ba011e13.csv",sep = ";",header = FALSE)
data6 <- read.csv("/Users/lina/Perforce/lersse/projects/active/unlocking_behavior/data/out-e654bb1e3f6f9340cee14dc4de24c8fe079a027d.csv",sep = ";",header = FALSE)

data <- list(data1,data3,data4,data5,data6)

for (i in 1:length(data)){
	#Get the corresponding columns we care about out from the dataset
	userData <- as.data.frame(data[i]) %>% select(V1,V2,V3,V4)
	#Set proper column names to these 3 columns
	colnames(userData) <- c("sesID","sesType","sesPart1Len","sesPart2Len")
	
	##Extract unlocking session data, which we can use to compute unlocking time 
  ##(unlocking time = self.current_unlocked_session_begin - self.current_authentication_begin)
	userUSES <- userData %>% filter(sesType=="USES")
	
	##Compute "unlockingTime" in seconds, then mutate it to the original unlocking session dataset "userUSES"
	userUSES <- userUSES %>% mutate(unlockingTime=(sesPart2Len-sesPart1Len)/1000) 
	##Define outliers as those unlocking attempts that are longer than 20 seconds, and filter those outliers
	userUSES <- userUSES %>% filter(unlockingTime<=20)
	
	##use paste to create the figure name
	figureTitle <- paste("unlockingTime Distribution for user",i)
	
	##use normal distribution to fit the unlockingTime data points
	##add four vertical lines into the density plot
	##the blue dashed line represent the mean value of unlockingTime for each user
	##the three red straight vertical lines locate at 1.7s,2.5s and 4.1s respectively
	##according to Ahmed's paper, 1.7s refers to the unlockingTime for DAS, 2.5s refers to PIN, and 4.1s refers to Password
	p <- userUSES %>% 
		ggplot(aes(unlockingTime))+
		geom_density(kernel = "gaussian")+
		geom_vline(aes(xintercept=mean(unlockingTime)),color="blue",linetype="dashed",size=1)+
		geom_vline(aes(xintercept=1.7),color="red")+
		geom_vline(aes(xintercept=2.5),color="red")+
		geom_vline(aes(xintercept=4.1),color="red")+
		labs(title=figureTitle,x="unlockingTime in seconds",y="Density")
	print(p)
}