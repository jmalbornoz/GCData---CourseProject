#
# Getting & Cleaning Data
# Course Project
#
# Jose Albornoz
# September 19th 2014
#
#
# What to submit: 
# 1) a tidy data set 
# 2) a link to a Github repository with the script for performing the analysis 
# 3) a code book that describes the variables, the data, and any transformations or work 
# that you performed to clean up the data called CodeBook.md. 
# Include a README.md in the repo with the scripts. 
# This repo explains how all of the scripts work and how they are connected.  
#
# You should create one R script called run_analysis.R that does the following. 

# STEP 1: Merges the training and the test sets to create one data set.
# STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
# STEP 3: Uses descriptive activity names to name the activities in the data set.
# STEP 4: Appropriately labels the data set with descriptive variable names. 
# STEP 5: From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.
#

#####################
# PRELIMINARY STEPS #
#####################

# downloads the dataset, registers date of download
theURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(theURL, destfile = "dataset.zip")
dateDownloaded <- date()

# unzips file
unzip("dataset.zip")

################################################################
# STEP 1: merges training and test sets to create one data set #
###############fI###############################################

#
# test data
#

# reads test data
test <- read.table("UCI HAR Dataset/test/X_test.txt", colClasses = "numeric")

# reads test subjects
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt", colClasses = "numeric")

# reads test activities
test_activities <- read.table("UCI HAR Dataset/test/y_test.txt", colClasses = "numeric")

# appends test subjects and test activities to test data
test <- cbind(test_subjects, test_activities, test)

#
# training data
#

# reads training data
train <- read.table("UCI HAR Dataset/train/X_train.txt", colClasses = "numeric")

# reads training data subjects
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt", colClasses = "numeric")

# reads training activities
train_activities <- read.table("UCI HAR Dataset/train/y_train.txt", colClasses = "numeric")

# appends training subjects to training data
train <- cbind(train_subjects, train_activities, train)

# training and test data frames are merged vertically -> this is the requested data set
theData_0 <- rbind(train, test)

##################################################################################################
# STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement #
##################################################################################################

# defines a vector of indexes that are going to be used to subset requested mean and std values from
# full feature list
# ** ONLY features with BOTH mean are std are selected **
#
selectedCols <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 215, 227, 228, 240, 
                  241, 253, 254, 266:271, 345:350, 424:429, 503, 504)

reqCols <- c(c(1,2) , 2 + selectedCols)

# subsets data frame to extract desired columns -> the result is the requested data set
theData_1 <- theData_0[,reqCols]

##################################################################################
# STEP 3: Uses descriptive activity names to name the activities in the data set #
##################################################################################

# reads file with activity labels
activityNames <- read.table("UCI HAR Dataset/activity_labels.txt", colClasses = "character")
activityNames <- activityNames$V2

# substitutes integer numbers in column 2 of the data set by their corresponding activitylabel
for(i in 1:6) { theData_1$V1.1[theData_1$V1.1 == i] <- activityNames[i] }

# expresses activity descriptions as factors
theData_1$V1.1 <- as.factor(theData_1$V1.1)

################################################################
# STEP 4: Labels the data set with descriptive variable names. #
################################################################

# reads list with all feature names
allFeatureNames <- read.table("UCI HAR Dataset/features.txt", colClasses = "character")

# selects the names corresponding to the chosen features
selectedNames <- allFeatureNames[selectedCols,]
selectedNames <- selectedNames$V2

# constructs vector with all variable names
theNames <- c(c("Subject", "Activity"), selectedNames)

# assigns names to data frame
names(theData_1) <- theNames

#######################################################################
# STEP 5: creates a second, independent tidy data set with the        #
#         average of each variable for each activity and each subject #
#######################################################################

# loads library dplyr
library(dplyr)

# arranges data set by activity and subject ID 
theData_1 <- arrange(theData_1, Activity, Subject)

# groups dataset by Activity and Subject
theData_11 <- group_by(theData_1, Activity, Subject)

# calculates average for each selected feature
theData_avg <- summarise_each(theData_11, funs(mean))

# writes the resulting data set to disk
write.table(theData_avg, file = "tidy_data.txt", row.name = FALSE)





