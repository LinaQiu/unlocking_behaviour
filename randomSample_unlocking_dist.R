##Randomly choose 300 data points from original unlocking_time data, and then analyze
##its distribution.

library(MASS)
library(fitdistrplus)
library(logspline)

#Read orginal unlocking_time data first
user1=read.csv("/Users/lina/Documents/CPEN442/unlocking/unlocking_behaviour/user 1 .csv",header = TRUE)
user2=read.csv("/Users/lina/Documents/CPEN442/unlocking/unlocking_behaviour/user 2 .csv",header = TRUE)
user3=read.csv("/Users/lina/Documents/CPEN442/unlocking/unlocking_behaviour/user 3 .csv",header = TRUE)
user4=read.csv("/Users/lina/Documents/CPEN442/unlocking/unlocking_behaviour/user 4 .csv",header = TRUE)
user5=read.csv("/Users/lina/Documents/CPEN442/unlocking/unlocking_behaviour/user 5 .csv",header = TRUE)

#Random choose 300 data points from orginal data sample, without replacement
randomSample_unlocking_user1 <- sample(user1$unlockingTime,300,replace = FALSE)
randomSample_unlocking_user2 <- sample(user2$unlockingTime,300,replace = FALSE)
randomSample_unlocking_user3 <- sample(user3$unlockingTime,300,replace = FALSE)
randomSample_unlocking_user4 <- sample(user4$unlockingTime,300,replace = FALSE)
randomSample_unlocking_user5 <- sample(user5$unlockingTime,300,replace = FALSE)

#Fit distribution to the sub-dataset
randomSample_user1_dist=descdist(log(randomSample_unlocking_user1),discrete = FALSE)
randomSample_user2_dist=descdist(log(randomSample_unlocking_user2),discrete = FALSE)
randomSample_user3_dist=descdist(log(randomSample_unlocking_user3),discrete = FALSE)
randomSample_user4_dist=descdist(log(randomSample_unlocking_user4),discrete = FALSE)
randomSample_user5_dist=descdist(log(randomSample_unlocking_user5),discrete = FALSE)

print(randomSample_user1_dist)
print(randomSample_user2_dist)
print(randomSample_user3_dist)
print(randomSample_user4_dist)
print(randomSample_user5_dist)


