setwd("C:/Users/obihov/Documents/Illinois/GraduateProgramISU/2Semester/IT497PracticalResearch/R/RstudioWorkspace497/497projectRepo/OsemnBukky/Analysis")

#Read in the data
indian.obj <- read.csv("Data/Indian.csv")
chinese.obj <- read.csv("Data/Chinese.csv")

indian.obj$Name <- as.character(indian.obj$Name)
indian.obj$City <- as.character(indian.obj$City)
indian.obj$State <- as.character(indian.obj$State)
indian.obj$Country <- as.character(indian.obj$Country)
indian.obj$isClosed <- as.character(indian.obj$isClosed)
indian.obj$isClaimed <- as.character(indian.obj$isClaimed)
indian.obj$Ratings <- as.numeric(indian.obj$Ratings)
indian.obj$Reviews <- as.numeric(indian.obj$Reviews)

chinese.obj$Name <- as.character(chinese.obj$Name)
chinese.obj$City <- as.character(chinese.obj$City)
chinese.obj$State <- as.character(chinese.obj$State)
chinese.obj$Country <- as.character(chinese.obj$Country)
chinese.obj$isClosed <- as.character(chinese.obj$isClosed)
chinese.obj$isClaimed <- as.character(chinese.obj$isClaimed)
chinese.obj$Ratings <- as.numeric(chinese.obj$Ratings)
chinese.obj$Reviews <- as.numeric(chinese.obj$Reviews)


#Use grep to eliminate / select rows that are only required
indianCity <- indian.obj[grep("Chicago", indian.obj$City),]  
indianIsClosed <- indianCity[grep("FALSE", indianCity$isClosed),] 
indianIsClaimed <- indianIsClosed[grep("TRUE", indianIsClosed$isClaimed),]
 
chineseCity <- chinese.obj[grep("Chicago", chinese.obj$City),]  
chineseIsClosed <- chineseCity[grep("FALSE", chineseCity$isClosed),]  
chineseIsClaimed <- chineseIsClosed[grep("TRUE", chineseIsClosed$isClaimed),]
  

subChinese <- subset(chineseIsClaimed, Reviews >= 100 & Reviews <= 899)
subIndian <- subset(indianIsClaimed, Reviews >= 100 & Reviews <= 899)
 
selectChinese <- data.frame(subChinese$Name, subChinese$Ratings)
selectIndian <- data.frame(subIndian$Name, subIndian$Ratings)


library(plyr)
newChinese <- rename(selectChinese, replace=c("subChinese.Name"="Name", "subChinese.Ratings"="Ratings"))
newIndian <- rename(selectIndian, replace=c("subIndian.Name"="Name", "subIndian.Ratings"="Ratings"))

newChinese$Name <- as.character(newChinese$Name)
newIndian$Name <- as.character(newIndian$Name)

chinese.avg <- mean(newChinese$Ratings)
indian.avg <- mean(newIndian$Ratings)
average.Vector <- c(indian.avg, chinese.avg)
name.Vector <- c("Indian", "Chinese")
avg.matrix <- cbind(name.Vector, average.Vector)
avg.df <- as.data.frame(avg.matrix)
names(avg.df) <- c("Restaurant Type", "Average")

#format col data type
avg.df[,"Restaurant Type"] <- as.character(avg.df[,"Restaurant Type"])
avg.df[,"Average"] <- as.numeric(as.character(avg.df[,"Average"]))
class(avg.df[,"Average"])

#for the graph use
name.Indian <- avg.df[1,1]
name.Chinese <- avg.df[2,1]
average.Indian <- avg.df[1,2]
average.Chinese <- avg.df[2,2]

library(ggplot2)
categoryRestaurant <- factor(c(name.Indian,name.Chinese), levels=c("Indian","Chinese"))
dat <- data.frame(category = categoryRestaurant, average = c(average.Indian, average.Chinese))

knitr::kable(avg.df, digits = 2, caption = "Average Rating")

