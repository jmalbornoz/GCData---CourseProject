GCData---CourseProject
======================

Course project for Coursera's "Getting &amp; Cleaning Data" 

The aim of this project is to generate a tidy dat set from data collected during the training and testing phases of an experiment aimed at identifying 6 concrete human activities. The collected data set represents a set of accelerometer and gyroscope measurements from smartphones (Samsung Galaxy S) carried by 30 volunteers. 

Tidying of the data was performed by 
* a) merging the training and testing sets 
* b) adding columns identifying the participating volunteers and the activities to the merged data set
* c) subsetting the merged data set to keep only those features that have both mean and standard deviation
* d) replacing the numerical labels identifying the activities by easier-to-read alphanumerical labels in the merged data set 
* e) naming all the variables in the merged data set with descriptive names
* f) Summarising the data set by computing the mean for each selected feature grouped by volunteer ID and activity

The above steps are performed by the script 'run\_analysis.R'; this script downloads the necessary data set and saves it in the working directory as file 'dataset.zip'. This file is then unzipped and the original data set is processed; once the script is executed the resulting tidy data set is saved as file 'tidy\_data.txt'
