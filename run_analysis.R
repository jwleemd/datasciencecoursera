# downloading the data set using URL

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="Dataset.zip")
unzip("Dataset.zip")

### Merges the training and the test sets to create one data set.

train.set <- read.table("UCI HAR Dataset/train/X_train.txt", header=F)
test.set <- read.table("UCI HAR Dataset/test/X_test.txt", header=F)
total.set <- rbind(train.set, test.set)

###Extracts only the measurements on the mean and standard deviation for each measurement. 

feature.labels <- read.table("UCI HAR Dataset/features.txt", header=F, stringsAsFactors=F)
feature.labels <- feature.labels$V2

mean_idx <- grep("mean()", feature.labels)
std_idx <- grep("std()", feature.labels)
mean_and_std_data <- total.set[, c(mean_idx, std_idx)]

### Uses descriptive activity names to name the activities in the data set

activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt", header=F, stringsAsFactors=F)
train.activity <- read.table("UCI HAR Dataset/train/y_train.txt", header=F, stringsAsFactors = F)$V1
test.activity <- read.table("UCI HAR Dataset/test/y_test.txt", header=F, stringsAsFactors = F)$V1

total.activity <- c(train.activity, test.activity)
total.activity.descr.labels <- activity.labels$V2[total.activity]

### Appropriately labels the data set with descriptive variable names. 

names(mean_and_std_data) <- feature.labels[c(mean_idx, std_idx)]
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt", header=F)$V1
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt", header=F)$V1
total.subject <- c(train.subject, test.subject)
data_all <- cbind(total.subject, total.activity.descr.labels, mean_and_std_data)

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

require(reshape2)
data_melt <- melt(data_all, id.vars=c("total.subject", "total.activity.descr.labels"), measure.vars=colnames(data_all)[-(1:2)])
mean_for_each_subject_and_activity <- dcast(data_melt, total.subject + total.activity.descr.labels ~ variable, mean)

