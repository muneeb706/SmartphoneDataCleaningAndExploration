# Smartphone Data Cleaning And Exploration

This project performs data cleaning and data exploration steps on the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) in R programming language. The dataset can be downloaded from the following link:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

It contains only one code file i.e [run_analyis.R](https://github.com/muneeb706/SmartphoneDataCleaningAndExploration/blob/master/run_analysis.R). Following steps are performed in the script. 

1. Merges the training and the test sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation for each measurement.
1. Uses descriptive activity names to name the activities in the dataset.
1. Appropriately labels the data set with descriptive variable names.
1. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### run_analysis.R expects the following directory structure:

getwd()   
  |----run_analysis.R  
  |----README.md  
  |----CodeBook.md  
  |----data  
  |----|----UCI HAR Dataset

Note: getwd() function points to current working directory and dataset folder 'UCI HAR Dataset' should be downloaded inside data folder in given directory structure.

Code explanation is given in [code book](https://github.com/muneeb706/SmartphoneDataCleaningAndExploration/blob/master/CodeBook.md).
