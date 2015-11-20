#Goal: prepare tidy data that can be used for later analysis
#STEPS:
#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names. 
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library("data.table")
library("reshape2")

##STEP 1: Merges the training and the test sets to create one data set.
dir <- "UCI HAR Dataset"
#Test
subject_test <- read.table(paste(dir, "test/subject_test.txt", sep = "/"))
X_test <- read.table(paste(dir, "test/X_test.txt", sep = "/")) 
y_test <- read.table(paste(dir, "test/y_test.txt", sep = "/"))

#Training
subject_train <- read.table(paste(dir, "train/subject_train.txt", sep = "/"))
X_train <- read.table(paste(dir, "train/X_train.txt", sep = "/"))
y_train <- read.table(paste(dir, "train/y_train.txt", sep = "/"))

#Get the colums names
names(subject_train) <- "Subject"
names(subject_test) <- "Subject"

#Name activity
names(y_train) <- "Activity"
names(y_test) <- "Activity"

#Names for measurement
featureNames<- read.table("UCI HAR Dataset/features.txt")
names(X_train) <- featureNames$V2
names(X_test) <- featureNames$V2

#Merges into create one data set
train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
combined_data <- rbind(train, test)

##STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.

#Columns contain "mean()" or "std()" and 
mean_std_columns <- grepl("mean\\(\\)", names(combined_data)) |
                    grepl("std\\(\\)", names(combined_data))  |
                    grepl("Subject", names(combined_data))    |
                    grepl("Activity", names(combined_data))

#Use only columns with mean and std
combined_data <- combined_data[, mean_std_columns]
    
## STEP 3: Uses descriptive activity names to name the activities in the data set
## STEP 4: Appropriately labels the data set with descriptive variable names.
activity_names <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]

#Set the name to each activity
combined_data$Activity <- factor(combined_data$Activity, labels= activity_names)

## STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
melt_data <- melt(combined_data, id.vars= c("Subject","Activity"))
tidy <- dcast(melt_data, Subject+Activity ~ variable, mean)

#Write the tidy data set to a file
write.table(tidy, file="tidy.txt", row.names = FALSE)
