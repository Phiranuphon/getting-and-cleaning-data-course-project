#1 Merges the training and the test sets to create one data set.
#2 Extracts only the measurements on the mean and standard deviation for each measurement.
#3 Uses descriptive activity names to name the activities in the data set
#4 Appropriately labels the data set with descriptive variable names.
#5 From the data set in step 4, creates a second, independent tidy data set with the average of 
#  each variable for each activity and each subject.

#download file
url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
unzipfile<- tempfile()
download.file(url,unzipfile)
list.files <- unzip(unzipfile,list=TRUE)

setwd(dir()[1])

#import Test data
Test.dataX<- read.table(list.files[17,1])
#import Activity label of Test data
Test.dataY<- read.table(list.files[18,1])
#import Train data
Train.dataX<- read.table(list.files[31,1])
#import Activity label of Train data
Train.dataY<- read.table(list.files[32,1])
#import Features 
Features <- read.table(list.files[2,1])
#import ACtivity
Activity <- read.table(list.files[1,1])

#select mean and std data


#label the dataset
colnames() <- Features[,2] 

