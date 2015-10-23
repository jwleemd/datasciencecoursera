# downloading the data set using URL

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="Dataset.zip")
unzip("Dataset.zip")

### 1. Merges the training and the test sets to create one data set.

# merging subjects

train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=F)$V1
test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=F)$V1
total.subject <- c(train.subject, test.subject)

# merging activity

train.activity <- read.table("./UCI HAR Dataset/train/y_train.txt", header=F, stringsAsFactors = F)$V1
test.activity <- read.table("./UCI HAR Dataset/test/y_test.txt", header=F, stringsAsFactors = F)$V1
total.activity <- c(train.activity, test.activity)

# merging measurement data

train.set <- read.table("./UCI HAR Dataset/train/X_train.txt", header=F)
test.set <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F)
total.set <- rbind(train.set, test.set)

# creating one merged data set

data.all <- cbind(total.subject, total.activity, total.set)

### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

feature.labels <- read.table("./UCI HAR Dataset/features.txt", header=F, stringsAsFactors=F)$V2

mean_idx <- grep("mean\\(\\)", feature.labels)
std_idx <- grep("std\\(\\)", feature.labels)
mean_and_std_data <- total.set[, sort(c(mean_idx, std_idx))]
names(mean_and_std_data) <- feature.labels[sort(c(mean_idx,std_idx))]

mean_and_std_data <- cbind(total.subject, total.activity, mean_and_std_data)

### 3. Uses descriptive activity names to name the activities in the data set

activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=F, stringsAsFactors=F)
mean_and_std_data[,2] <- activity.labels$V2[total.activity]

### 4. Appropriately labels the data set with descriptive variable names. 

replaceNames <- function(name) {
        
        n1 <- gsub("mean\\(\\)", "Mean", name)
        n2 <- gsub("-", "", n1)
        n3 <- gsub("Acc","Accelerometer", n2)
        n4 <- gsub("std\\(\\)","StandardDeviation",n3)
        n5 <- gsub("Mag", "Magnitude",n4)
        n6 <- gsub("Gyro", "GyroScope", n5)
        n7 <- gsub("^t", "time", n6)
        n8 <- gsub("^f", "fourier", n7)
        n8
        
}

names(mean_and_std_data)[1:2] <- c("Subject","Activity")
names(mean_and_std_data) <- replaceNames(names(mean_and_std_data))

### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

require(reshape2)
data_melt <- melt(mean_and_std_data, id.vars=c("Subject", "Activity"))
mean_for_each_subject_and_activity <- dcast(data_melt, Subject + Activity ~ variable, mean)

#Writing the tidy dataset into a tab-delimited text file

write.table(mean_for_each_subject_and_activity, file="tidydata.txt", row.names=F, sep="\t", quote=F)
