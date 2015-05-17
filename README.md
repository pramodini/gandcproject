## gandcproject


This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:


### Process

 1) Reads the data from the url.

 2) Downloads the file and unzips into the working directory in data folder.
 
 3) Reads data from the files into the variables.

 4) Looks at the properties of the above designated variables.

 
 5) Merges the training and the test sets to create one    data set by :
 
  * concatenating the data tables by rows
  
  * setting names to variables and 
  
  * merges columns to get the data frame Data for the entire data.

 6) Extracts only the measurements on the mean and standard deviation for each measurement by :

  * Subset names of features by measurement on the mean and standard deviation.
    
  * Subset the data frame Data by selected names of features.
  
  * Checking the structure of the data frame Data.
  
 7) Uses descriptive activity names to name the activities in data set.

  * By reading the descriptive activity names from "activity_lables.txt". 

  * Factorizing  the variable activity in the data frame data using descriptive activity names.
  
  * checking 
   

 8) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 * The end result is shown in the file tidydata.txt








