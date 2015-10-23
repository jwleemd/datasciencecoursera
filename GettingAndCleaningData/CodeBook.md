##Variables used in run_anlaysis.R script

###Step 0

*url		the url for the original dataset

###Step 1
*train.subject		a vector for train subjects
*test.subject		a vector for test subjects
*total.subject		a vector created by merging train.subject and test.subject
*train.activity		a vector for the first column of y_train.txt
*test.activity		a vector for the first column of y_test.txt
*total.activity		a vector created by concatenating train.activity and test.activity
*train.set	a data frame for X_train.txt
*test.set	a data frame for X_test.txt
*total.set	a data frame created by merging train.set and test.set
*data.all	a data frame merged from total.subject, total.activity, and total.set

###Step 2
*feature.labels		a data frame for features. Only the second column, which is the actual labels, will be retained
*mean_idx		a vector of indices for column names that contain "mean()". Produced by grep command.
*std_idx			a vector of indices for column names that contain "std()". Produced by grep command.
mean_and_std_data	a data frame created by subsetting the total.set with c(mean_idx, std_idx)

###Step 3

*activity.labels		a data frame for activity_labels.txt; contains activity labels and their matching descriptive activity names


###Step 4

*replaceNames()	a function that replaces names in mean_and_std_data with descriptive variable names


###Step 5

*data_melt			a long-format data frame created by melting (in the reshape2 package) data_all
*mean_for_each_subject_and_activity	a short-format data frame that contains the average of each variable for each activity and each subject. Created by dcast function of the reshape2 package

##The data

The original data is a zip-compressed file available at the url described in run_analysis.R script. When decompressed, the folder "UCI HAR Dataset" contains the following files

*features.txt			a text file for feature labels. This is a list of variables measured in each subject.
*activity_labels.txt		a text file for activity labels and their descriptive names
*feature_info.txt			a text file containing information on variables measured in train and test datasets.

*/train/X_train.txt			a text file for activity data measured in train subjects
*/train/y_train.txt			a text file for activity labels in train subjects
*/train/subject_train.txt	a text file for the list of train subjects

*/test/X_test.txt			a tesxt file for activity data measured in test subjects
*/test/y_test.txt			a text file for activity labels in train subjects
*/test/subject_test.txt		a text file for the list of test subjects

##How getting and cleaning the data is done

0. The downloaded zip file is extracted using the unzip command on R. 
1. The training and test datasets are merged into one dataset using rbind.
2. Using grep() command, the measurements on the mean and standard deviation for each measurement are extracted.
3.Using information in feature.labels, labels for activity are matched with their descriptive names.
4. The column names of the mean_and_std_data are replaced with descriptive variable names using replaceNames() function.
5. The merged data were transformed into a long-format table using melt command (reshape2) and the averge of each variable for each activity and each subject was calculated using dcast command (reshape2).
