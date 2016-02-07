library(MASS)
library(fitdistrplus)
library(logspline)

#user1=read.csv("/Users/lina/Documents/CPEN442/unlocking/Data/user 1 _20.csv",header = TRUE)
#user2=read.csv("/Users/lina/Documents/CPEN442/unlocking/Data/user 2 _20.csv",header = TRUE)
#user3=read.csv("/Users/lina/Documents/CPEN442/unlocking/Data/user 3 _20.csv",header = TRUE)
#user4=read.csv("/Users/lina/Documents/CPEN442/unlocking/Data/user 4 _20.csv",header = TRUE)
#user5=read.csv("/Users/lina/Documents/CPEN442/unlocking/Data/user 5 _20.csv",header = TRUE)

user1=read.csv("/Users/lina/Documents/CPEN442/unlocking/unlocking_behaviour/user 1 .csv",header = TRUE)
user2=read.csv("/Users/lina/Documents/CPEN442/unlocking/unlocking_behaviour/user 2 .csv",header = TRUE)
user3=read.csv("/Users/lina/Documents/CPEN442/unlocking/unlocking_behaviour/user 3 .csv",header = TRUE)
user4=read.csv("/Users/lina/Documents/CPEN442/unlocking/unlocking_behaviour/user 4 .csv",header = TRUE)
user5=read.csv("/Users/lina/Documents/CPEN442/unlocking/unlocking_behaviour/user 5 .csv",header = TRUE)

user1=user1$unlockingTime
user2=user2$unlockingTime
user3=user3$unlockingTime
user4=user4$unlockingTime
user5=user5$unlockingTime

user1_dist=descdist(user1,discrete = FALSE)
user2_dist=descdist(user2,discrete = FALSE)
user3_dist=descdist(user3,discrete = FALSE)
user4_dist=descdist(user4,discrete = FALSE)
user5_dist=descdist(user5,discrete = FALSE)

print(user1_dist)
print(user2_dist)
print(user3_dist)
print(user4_dist)
print(user5_dist)

#loguser1_dist=descdist(log(user1),discrete = FALSE)
#loguser2_dist=descdist(log(user2),discrete = FALSE)
#loguser3_dist=descdist(log(user3),discrete = FALSE)
#loguser4_dist=descdist(log(user4),discrete = FALSE)
#loguser5_dist=descdist(log(user5),discrete = FALSE)

#print(loguser1_dist)
#print(loguser2_dist)
#print(loguser3_dist)
#print(loguser4_dist)
#print(loguser5_dist)
