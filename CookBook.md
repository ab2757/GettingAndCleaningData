# Codebook for Getting and Cleaning Data Project Assignment

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

Here are the data for the project: 
[Input Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

This codebook describes the variables, the data, and any transformations or work that I have performed to clean up the data.

### Data
UCI HAR Dataset contains data for train, test and other related files
* X_train.txt : contains all variables for train dataset
* y_train.txt : contains y variable for train dataset
* subject_train.txt : contains subject variable for train dataset
* X_test.txt : contains all variables for test dataset
* y_test.txt : contains y variable for test dataset
* subject_test.txt : contains subject variable for test dataset
* activity_labels.txt : contains labels for each activity type associated with subject
* features.txt : contains features names for all of the features

## run_analysis.R
I have written a script run_analysis.R for getting and cleaning data. I have taken following steps :
* Download the input data in form of zip file
* Unzip the data
* Read the X_train.txt, X_test.txt, y_train.txt, y_test.txt, subject_train.txt, subject_test.txt
* Merge the corresponding input files of train and test dataset to create merge_subject, merge_X, merge_Y datasets
* Merge merge_X, merge_Y, merge_subject datasets to create final_data dataset
* Read the features.txt
* Extract the features which contain either mean or std(standard deviation) in their names
* Subset the final_data to contain only those features which contain either mean or std
* Read activity.txt
* Join activity and final_data to join  "y" feature with "activity" feature - "final_data2"
* Renaming all the variables in final_data2 with feature names
* Few of the feature has same names
* Hence make them unique
* Create Tidy dataset - calculate mean of all variables in final_data3 grouped by activity and subject

Thank You!