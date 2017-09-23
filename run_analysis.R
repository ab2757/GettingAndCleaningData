############ Data Science ##################

######## Course 3 ##############

########## Week 4 Project ############

## Setting the path for local folder 
#wd_path = "C:/Users/ab275/Documents/Analytics/coursera/Data Science/C3 Getting and Cleaning Data/W4"
#setwd(wd_path)

## downloading the zip file, unzipping it 
fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,"./HAR dataset.zip")
unzip("HAR dataset.zip")


## Reading the train and test files from the respective folder
train_subject = read.table("./UCI HAR Dataset/train/subject_train.txt")
#View(train_subject)

test_subject = read.table("./UCI HAR Dataset/test/subject_test.txt")
#View(test_subject)

train_X = read.table("./UCI HAR Dataset/train/X_train.txt")
#View(train_X)

test_X = read.table("./UCI HAR Dataset/test/X_test.txt")
#View(test_X)

train_Y = read.table("./UCI HAR Dataset/train/Y_train.txt")
#View(train_Y)

test_Y = read.table("./UCI HAR Dataset/test/Y_test.txt")
#View(test_Y)

######################################################################

## Mergint the respective train and test files together
merge_subject = rbind(train_subject,test_subject)
merge_X = rbind(train_X,test_X)
merge_Y = rbind(train_Y,test_Y)

## Naming the column names of merged datasets
names(merge_subject) = "subject"
names(merge_Y) = "y_var"

## finally merging different files contaning different columns 
final_data = cbind(merge_subject,merge_X,merge_Y)
#View(final_data)

######################################################################

## Reading feature names from feature.txt and assigning column names to it
feature_names = read.table("./UCI HAR Dataset/features.txt")
names(feature_names) = c("feature_num","feature_name")

## Extracting indices where feature names contain either mean or std(standard deviation)
features_mean = grep("mean",feature_names$feature_name)
features_std = grep("std",feature_names$feature_name)

## Preparing columns names by pasting "V" with indices so that it can be subsetted from merged final data
column_mean = paste("V",features_mean,sep="")
column_std = paste("V",features_std,sep="")

## Subsetting the final_data to extract only columns containing either mean or standard deviation in their names
data_subset = final_data[,c(column_mean,column_std)]

######################################################################

## Reading activity labels and assigning column names to it
activity = read.table("./UCI HAR Dataset/activity_labels.txt")
names(activity) = c("activity_num","activity_name")

#table(merge_Y)
#names(merge_Y)

## Merging the final_data and activity
final_data2 = merge(final_data,activity,by.x="y_var",by.y="activity_num",all.x=T)
#View(final_data2)
#table(final_data2$activity_name,useNA = "ifany")

######################################################################
#str(feature_names)
## Converting feature names to characters
feature_names$feature_name = as.character(feature_names$feature_name)

## Naming column names of final_data2 from feature_names
names(final_data2) = c("subject",feature_names[,2],"y_var","activity_name")
#names(final_data2)

######################################################################

#length(unique(names(final_data2)))
#sort(table(names(final_data2)),decreasing = T)[1:20]

## Since feature_names contain some duplicate names, we are making them unique
valid_names <- make.names(names = names(final_data2), unique=TRUE, allow_=TRUE)
names(final_data2) = valid_names

## Finally getting mean for all the feature variables group by activity and subject
final_data3 = final_data2 %>% group_by(activity_name,subject) %>% summarize_each(funs(mean))
#View(final_data3)

## Writing the final_data3 to a txt file with no row names
write.table(final_data3,file = "./ab_tidy_data.txt",row.names = FALSE)