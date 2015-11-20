# Getting and Cleaning Data

Goal: prepare tidy data that can be used for later analysis

##Steps:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Tidy data
1. Download the data source, then unzipped the data in your working directory.
  -Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  -Package require(): "data.table" and "reshape2"
2. Download the file run_analysis.R and save in your working directory.
3. Load the script: source("run_analysis.R")
4. Then you can find the file "tidy.txt" in your working directory with the average of each variable for each activity and each subject.




