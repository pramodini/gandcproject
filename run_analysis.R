if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
setInternet2(use = TRUE)
download.file(fileUrl, destfile = "./data/Dataset.zip", method = "internal")
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")
 
path <- file.path("./data", "UCI HAR Dataset")
files <- list.files(path, recursive = TRUE)
files

## Read activity files

DataActivityTest <- read.table(file.path(path, "test", "Y_test.txt"), header = FALSE)
DataActivityTrain <- read.table(file.path(path, "train", "Y_train.txt"), header = FALSE)

## Read Subject files

DataSubjectTest <- read.table(file.path(path, "test", "subject_test.txt"), header = FALSE)
DataSubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"), header = FALSE)

## Read Features files

DataFeaturesTest <- read.table(file.path(path, "test", "X_test.txt"), header = FALSE)
DataFeaturesTrain <- read.table(file.path(path, "train","X_train.txt"), header = FALSE)

## str(DataActivityTest)
## str(DataActivityTrain)
## str(DataActivityTest)
## str(DataSubjectTrain)
## str(DataFeaturesTest)
## str(DataFeaturesTrain)

## Merges the training and the test sets to create one data set.

DataSubject <- rbind(DataSubjectTrain, DataSubjectTest)
DataActivity <- rbind(DataActivityTrain, DataActivityTest)
DataFeatures <- rbind(DataFeaturesTrain, DataFeaturesTest)

## setting names to variables
names(DataSubject) <- c("Subject")
names(DataActivity) <- c("Activity")
Data_Features_Names <- read.table(file.path(path, "features.txt"),head = FALSE)
names(DataFeatures) <- Data_Features_Names$V2

## Merging columns to a data frame named Data

CombinedData <- cbind(DataSubject, DataActivity)
Data <- cbind(DataFeatures, CombinedData)

##Extracts only the measurements on the mean and standard deviation for each measurement. 

Sub_Data_Features_Names <- Data_Features_Names$V2[grep("mean\\(\\)|std\\(\\)", Data_Features_Names$V2)]

 ##subsetting the data frame here Data by selected names of features
 df <- c(as.character(Sub_Data_Features_Names), "Subject", "Activity")
Data <- subset(Data, select=df)

##str(Data)

##Uses descriptive activity names to name the activities in the data set
 
Activity_Labels <- read.table(file.path(path, "activity_labels.txt"), header = FALSE)

## factorize the variable 
Data$Activity[Data$Activity == 1] <- "Walking"
Data$Activity[Data$Activity == 2] <- "Walking Upstairs"
Data$Activity[Data$Activity == 3] <- "Walking Downstairs"
Data$Activity[Data$Activity == 4] <- "Sitting"
Data$Activity[Data$Activity == 5] <- "Standing"
Data$Activity[Data$Activity == 6] <- "Laying"
Data$Activity <- as.factor(Data$Activity)



head(Data$Activity,10)

names(Data) <- gsub("Acc", "Accelerometer", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("^t", "Time", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))
names(Data) <- gsub("^f", "Frequency", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))

names(Data)

##From the data set in step 4, creates a second, independent tidy data set with the average of each 
##variable for each activity and each subject.

library(plyr)

New_Data <- aggregate(.~Subject + Activity, Data, mean)

New_Data <- New_Data[order(New_Data$Subject, New_Data$Activity),]

write.table(New_Data, file = "tidydata.txt", row.name=FALSE)
