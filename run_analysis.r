# The purpose of this program is to demonstrate the ability 
# to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. 

#install.packages("dplyr")
#install.packages("plyr")
library(dplyr)
library(plyr)
library(stringr)

# This funtion will import and start merging the Test and Train Data for X and Y

  # Read Test Data
  x_test <- read.table("./wear_data/test/X_test.txt")
  y_test <- read.table("./wear_data/test/y_test.txt")
  subj_test <- read.table("./wear_data/test/subject_test.txt")
  # Read Train Data
  x_train <- read.table("./wear_data/train/X_train.txt")
  y_train <- read.table("./wear_data/train/y_train.txt")
  subj_train <- read.table("./wear_data/train/subject_train.txt")
  # Merge Test & Train X datasets
  x_merged <- rbind(x_test, x_train)
  # Merge Test & Train Y datasets
  y_merged <- rbind(y_test, y_train)
  # Merge Test & Train Subject datasets
  subj_merged <- rbind(subj_test, subj_train)
  #Combine all merged datasets
  data_temp <- cbind(y_merged,x_merged)
  tidy_data <- cbind(subj_merged,data_temp)

# This function will extract on the Mean and Standard Deviation related data

  features <- read.table("./wear_data/features.txt")
  names(tidy_data) <- c("Subject", "Activity", as.character(features$V2))
  sd_mean <- features$V2[grep("-mean\\(\\)|-std\\(\\)", features[, 2])]
  colnames <- c("Subject", "Activity", as.character(sd_mean))
  tidy_data <- subset(tidy_data, select = colnames)

# This function will clean up the Variable names as well as
# Replace the activity codes with understandable terms then
# Output the tidy data to a text file.

  tidy_data$Activity <- mapvalues(tidy_data$Activity, from = c("1", "2", "3", "4", "5", "6"), 
                           to = c("Walking", "WalkingUpStairs", "WalkingDownStairs", "Sitting", "Standing", "Lying"))
  names(tidy_data) <- str_replace_all(names(tidy_data), "[.][.]", "")
  names(tidy_data) <- str_replace_all(names(tidy_data), "BodyBody", "Body")
  names(tidy_data) <- str_replace_all(names(tidy_data), "tBody", "Body")
  names(tidy_data) <- str_replace_all(names(tidy_data), "fBody", "FFTBody")
  names(tidy_data) <- str_replace_all(names(tidy_data), "tGravity", "Gravity")
  names(tidy_data) <- str_replace_all(names(tidy_data), "fGravity", "FFTGravity")
  names(tidy_data) <- str_replace_all(names(tidy_data), "Acc", "Acceleration")
  names(tidy_data) <- str_replace_all(names(tidy_data), "Gyro", "AngularVelocity")
  names(tidy_data) <- str_replace_all(names(tidy_data), "Mag", "Magnitude")
  for(i in 3:68) {if (str_detect(names(tidy_data)[i], "[.]std")) 
    + {names(tidy_data)[i] <- paste0("StandardDeviation", str_replace(names(tidy_data)[i], "[.]std", ""))}}
  for(i in 3:68) {if (str_detect(names(tidy_data)[i], "[.]mean")) 
    + {names(tidy_data)[i] <- paste0("Mean", str_replace(names(tidy_data)[i], "[.]mean", ""))}}
  names(tidy_data) <- str_replace_all(names(tidy_data), "[.]X", "XAxis")
  names(tidy_data) <- str_replace_all(names(tidy_data), "[.]Y", "YAxis")
  names(tidy_data) <- str_replace_all(names(tidy_data), "[.]Z", "ZAxis")
  
# Write Tidy Data to a CSV file
  
  write.csv(tidy_data, "UCI_HAR_tidy_data.csv", row.names=FALSE)

# Data Cleanup in Global Environment
  rm(data_temp)
  rm(features)
  rm(subj_merged)
  rm(subj_test)
  rm(subj_train)
  rm(x_merged)
  rm(x_test)
  rm(x_train)
  rm(y_merged)
  rm(y_test)
  rm(y_train)
  rm(colnames)
  rm(i)
  rm(sd_mean)

