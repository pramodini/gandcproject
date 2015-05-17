## The file describes the variables

 1) The values of the variables :

 * activity consist of data from " Y _ train.txt "
   and " Y _ test.txt ".

 * subject consists of data from  " subject _ train.txt" and " subject _ test.txt ".
 
 * features consists of data from " X _ train.txt "and "X _ test.txt ".

 Names of the variable features come from " features.txt ".

Levels of variable activity come from " activity _ labels.txt "

2) Reading the data from the files into the variables :

  * DataActivityTest
  * DataActivityTrain
  * DataSubjectTest
  * DataSubjectTrain
  * DataFeaturesTest
  * DataFeaturesTrain
  
3) Merges the training and the test sets to create one data set :

  Concatenating the data tables by rows using the variables :

  * DataSubject
  * DataActivity
  * DataFeatures
  
  setting names to variables :
  
    names(DataSubject) <- c("Subject")
    names(DataActivity) <- c("Activity")
    Data_Features_Names <- read.table(file.path(path, "features.txt"),head = FALSE)
    names(DataFeatures) <- Data_Features_Names$V2

  Merging columns to a data frame named Data

    CombinedData <- cbind(DataSubject, DataActivity)
    Data <- cbind(DataFeatures, CombinedData)

4) Extracts only the measurements on the mean and standard deviation for each measurement by using the variable name :

      Sub_Data_Features_Names

  subsetting the data frame here Data by selected names of features

     df <- c(as.character(Sub_Data_Features_Names), "Subject", "Activity")
     Data <- subset(Data, select=df)

 5) Uses descriptive activity names to name the activities in the data set and factorizing the variable activity in the data frame Data using descriptive activity names :

    Data$Activity[Data$Activity == 1] <- "Walking"
    Data$Activity[Data$Activity == 2] <- "Walking Upstairs"
    Data$Activity[Data$Activity == 3] <- "Walking Downstairs"
    Data$Activity[Data$Activity == 4] <- "Sitting"
    Data$Activity[Data$Activity == 5] <- "Standing"
    Data$Activity[Data$Activity == 6] <- "Laying"
    Data$Activity <- as.factor(Data$Activity)


    names(Data) <- gsub("Acc", "Accelerometer", names(Data))
    names(Data) <- gsub("Mag", "Magnitude", names(Data))
    names(Data) <- gsub("^t", "Time", names(Data))
    names(Data) <- gsub("BodyBody", "Body", names(Data))
    names(Data) <- gsub("^f", "Frequency", names(Data))
    names(Data) <- gsub("Gyro", "Gyroscope", names(Data))

 6) From the data set in step 4, creates a second, independent tidy data set with the average of each 
 variable for each activity and each subject :
  
   load :

    library(plyr)
   
  7) The cleaned up data set is in tidydata.txt

     write.table(New_Data, file = "tidydata.txt", row.name=FALSE) 

   