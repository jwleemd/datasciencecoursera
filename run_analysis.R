### Merges the training and the test sets to create one data set.

# setting the working directory

setwd("C:/Users/jae/Documents/datasciencecoursera/")

# downloading the data set using URL

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="Dataset.zip")
unzip("Dataset.zip")

# reading in label data

activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt", header=F)
feature.labels <- read.table("UCI HAR Dataset/features.txt", header=F)

# reading in the train set

train.set <- read.table("UCI HAR Dataset/train/X_train.txt", header=F)
train.activity <- read.table("UCI HAR Dataset/train/y_train.txt", header=F)
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt", header=F)

# assign column names and add subject and activity data 

colnames(train.set) <- feature.labels$V2
train.set$subject <- train.subject$V1
train.set$activity <- train.activity$V1
train.set$origin <- "train"

# rearranging the order of columns

train.set <- train.set[, c(ncol(train.set)-2, ncol(train.set)-1, ncol(train.set), 1:(ncol(train.set)-3))]

# reading in the test set

test.set <- read.table("UCI HAR Dataset/test/X_test.txt", header=F)
test.activity <- read.table("UCI HAR Dataset/test/y_test.txt", header=F)
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt", header=F)

# assign column names and add subject and activity data

colnames(test.set) <- feature.labels$V2
test.set$subject <- test.subject$V1
test.set$activity <- test.activity$V1
test.set$origin <- "test"


# rearranging the order of columns

test.set <- test.set[, c(ncol(test.set)-2, ncol(test.set)-1, ncol(test.set), 1:(ncol(test.set)-3))]

# merging the train and test datasets into one dataset

total.set <- rbind(train.set, test.set)

###Extracts only the measurements on the mean and standard deviation for each measurement. 

mean_idx <- grep("mean()", colnames(total.set))
std_idx <- grep("std()", colnames(total.set))
mean_and_std <- total.set[, c(1,2,3,mean_idx, std_idx)]

#Uses descriptive activity names to name the activities in the data set




#Appropriately labels the data set with descriptive variable names. 




#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.