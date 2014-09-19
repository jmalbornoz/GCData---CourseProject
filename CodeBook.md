Human Activity Recognition Using Smartphones Dataset – Data Cleaning & Reduction Description


GENERAL DESCRIPTION OF THE DATASET:
The original dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Provides information about the 561 variables used in the feature vector.
- 'features.txt': List of all 561 features. Features are normalized and bounded within [-1,1] and therefore the variables in the data set are adimensional
- 'activity_labels.txt': List labels for 6 human activities.
- 'train/X_train.txt': Training set, 7352 rows x 561 columns.
- 'train/y_train.txt': Training labels for all 6 activities.
- 'test/X_test.txt': Test set, 2947 rows x 561 columns.
- 'test/y_test.txt': Testing labels for all 6 activities.
Both test and training sets folders include files ‘subject_test’ and ‘subject_train’; these files contain integer numbers that identify the volunteers that took place in the experiment for the testing and training phases respectively. 

STEPS IN THE REDUCTION OF THE DATA SET:
The following describes the steps found in the script “run_analysis.R”:


0)	PRELIMINARY STEPS
i.	The dataset at "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" was downloaded; the date and time of the download were recorded in variable “dateDownloaded”
ii.	The file was unzipped and folder ‘UCI HAR Dataset’ was created.

1)	STEP 1: MERGING THE TRAINING AND TEST SETS TO CREATE ONE DATA SET
* i.	File ‘UCI HAR Dataset/test/X_test.txt’ was read into data frame “test” with 2947 rows (one for each observation) and 561 columns (one for each feature)
* ii.	File ‘UCI HAR Dataset/test/subject_test.txt’ (2497 rows, 1 column) was read into data frame ‘test_subjects’
* iii.	File ‘UCI HAR Dataset/test/y_test.txt’ (2497 rows, 1 column) was read into data frame ‘test_activities’
* iv.	Data frames ‘test_subjects’ and ‘test_activities’ were appended to data frame ‘test’. The resulting data frame ‘test’ has now 563 columns: the first column contains integer numbers identifying each of the 9 volunteers whose data was used for the testing phase of the experiment, the second column identifies each of the 6 activities that the experiment aims to identify; the remaining 561 columns corresponds to the features described in file 'features.txt'
* v.	File ‘UCI HAR Dataset/train/X_train.txt’ was read into data frame “train” with 7352 rows (one for each observation) and 561 columns (one for each feature)
* vi.	File ‘UCI HAR Dataset/train/subject_train.txt’ (7352 rows, 1 column) was read into data frame ‘train_subjects’
* vii.	File ‘UCI HAR Dataset/train/y_train.txt’ (7352 rows, 1 column) was read into data frame ‘train_activities’
* viii.	Data frames ‘train_subjects’ and ‘train_activities’ were appended to data frame ‘train’. The resulting data frame ‘train’ has now 563 columns: the first column contains integer numbers identifying each of the 21 volunteers whose data was used for the training phase of the experiment, the second column identifies each of the 6 activities that the experiment aims to identify; the remaining 561 columns corresponds to the features described in file 'features.txt'
* ix.	Data frames ‘train’ and ‘test’ are merged vertically; the result is stored in data frame ‘theData_0.’ This is the requested data set specified in STEP 1.

2)	STEP 2: EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
The features that were selected in this step were limited to those that have BOTH mean and standard deviation values, as specified in the list contained in file 'features.txt'. The following is a list of the 58 chosen features; each one is preceded by its corresponding number in the original list of 561 features:
* 1 tBodyAcc-mean()-X
* 2 tBodyAcc-mean()-Y
* 3 tBodyAcc-mean()-Z
* 4 tBodyAcc-std()-X
* 5 tBodyAcc-std()-Y
* 6 tBodyAcc-std()-Z
* 41 tGravityAcc-mean()-X
* 42 tGravityAcc-mean()-Y
* 43 tGravityAcc-mean()-Z
* 44 tGravityAcc-std()-X
* 45 tGravityAcc-std()-Y
* 46 tGravityAcc-std()-Z
* 81 tBodyAccJerk-mean()-X
* 82 tBodyAccJerk-mean()-Y
* 83 tBodyAccJerk-mean()-Z
* 84 tBodyAccJerk-std()-X
* 85 tBodyAccJerk-std()-Y
* 86 tBodyAccJerk-std()-Z
* 121 tBodyGyro-mean()-X
* 122 tBodyGyro-mean()-Y
* 123 tBodyGyro-mean()-Z
* 124 tBodyGyro-std()-X
* 125 tBodyGyro-std()-Y
* 126 tBodyGyro-std()-Z
* 161 tBodyGyroJerk-mean()-X
* 162 tBodyGyroJerk-mean()-Y
* 163 tBodyGyroJerk-mean()-Z
* 164 tBodyGyroJerk-std()-X
* 165 tBodyGyroJerk-std()-Y
* 166 tBodyGyroJerk-std()-Z
* 201 tBodyAccMag-mean()
* 202 tBodyAccMag-std()
* 214 tGravityAccMag-mean()
* 215 tGravityAccMag-std()
* 227 tBodyAccJerkMag-mean()
* 228 tBodyAccJerkMag-std()
* 240 tBodyGyroMag-mean()
* 241 tBodyGyroMag-std()
* 253 tBodyGyroJerkMag-mean()
* 254 tBodyGyroJerkMag-std()
* 266 fBodyAcc-mean()-X
* 267 fBodyAcc-mean()-Y
* 268 fBodyAcc-mean()-Z
* 269 fBodyAcc-std()-X
* 270 fBodyAcc-std()-Y
* 271 fBodyAcc-std()-Z
* 345 fBodyAccJerk-mean()-X
* 346 fBodyAccJerk-mean()-Y
* 347 fBodyAccJerk-mean()-Z
* 348 fBodyAccJerk-std()-X
* 349 fBodyAccJerk-std()-Y
* 350 fBodyAccJerk-std()-Z
* 424 fBodyGyro-mean()-X
* 425 fBodyGyro-mean()-Y
* 426 fBodyGyro-mean()-Z
* 427 fBodyGyro-std()-X
* 428 fBodyGyro-std()-Y
* 429 fBodyGyro-std()-Z
* 430 fBodyGyro-mad()-X
* 503 fBodyAccMag-mean()
* 504 fBodyAccMag-std()

Columns of the data frame ‘theData_0’ were subset using the indexes corresponding to the above specified variables; 
the result was stored in data frame ‘theData_1’. This data frame has 10299 rows and 60 columns; of these columns 
the first two correspond to volunteer IDs and activity labels respectively, the remaining 58 columns correspond 
to the chosen features listed above. 

3) STEP 3: DESCRIPTIVE ACTIVITY NAMES ARE USED TO NAME THE ACTIVITIES IN THE DATA SET
In order to accomplish this task the list of activity names was read from file ‘activity_levels.txt’ into vector ‘activityNames’. 
Then each integer activity identifier corresponding to each activity in the second column of data frame ‘theData\_1’ was replaced by the corresponding character-based descriptor listed in ‘activityNames’. Lastly, these descriptors were converted to factors in data frame ‘theData_1’. 

4)	STEP 4: LABELS THE DATA SET WITH DESCRIPTIVE DATA LABELS
The complete list of all feature names was read from file ‘features.txt’ into a data frame named ‘allFeatureNames’; this data frame was then subset using the indexes previously used to subset the columns of ‘theData\_0’; these indexes correspond to the list of chosen features (listed in STEP 2); the result was stored in vector ‘selectedNames’. A vector named ‘theNames’ was then built concatenating character strings  ‘Subject’ and ‘Activity’ with the names of the chosen features stored in ‘selectedNames’; the names of the columns in ‘theData\_1’ were then replaced by the names contained in ‘’theNames’. In this way the columns names in ‘theData\_1’ were replaced by ‘Subject’ and ‘Activity’ plus the original names for the 58 chosen features, as requested in STEP 4.

5)	STEP 5: CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
The package ‘dplyr’ was used to perform this task in a few simple steps. Firstly, data frame ‘theData\_1’ was re-arranged according to columns ‘Activity’ and ‘Subject’; as a result a new data frame named ‘theData\_11’ was generated grouping ‘theData\_1’ by columns ‘Activity’ and ‘Subject’. The function ‘summarise\_each’ was then used to compute the mean of the remaining 58 columns containing the selected features, by activity and by subject: the resulting summarised data frame with the requested averages was stored as ‘theData\_avg’, as requested in STEP 5.

6) FINAL STEP: The resulting tidy data set is saved as file 'tidy_data.txt'
