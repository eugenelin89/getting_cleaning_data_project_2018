## Working Dir is "UCI HAR Dataset"

## 1. Merge Training Set General Steps
## a. Merge X_train, subject_train, and y_train
## b. Merge X_test, subject_Test, and y_test
## c. Merge dataframe from 1 and 2

## First, load the data for training set
x_train <- read.table("train/X_train.txt")
subject_train <- read.table("train/subject_train.txt")
y_train <- read.table("train/y_train.txt")
## load the data for test set
x_test <- read.table("test/X_test.txt")
subject_test <- read.table("test/subject_test.txt")
y_test <- read.table("test/y_test.txt")
## load features
features <- read.table("features.txt", as.is = TRUE)

## Step a. Merge X_train, subject_train, and y_train
data_train <- cbind(x_train, subject_train, y_train)
## Step b. Merge X_test, subject_test, and y_test
data_test <- cbind(x_test, subject_test, y_test)
## Step c. Merge dataframes from Step a and b
data_combined <- rbind(data_test, data_train)

## 2. Extracts only mean and standard deviation
## From features, find index of *-mean()-* and *-std()-*
mean_std_index <- grep("std|mean",features[[2]])
data_mean_std <- data_combined[,mean_std_index]
## In the process, we've lost the column for subjects, subject_train and subject_test
data_mean_std <- cbind(rbind(subject_train, subject_test), data_mean_std)


## 3. Use descriptive activity names
## a. load activity labels
activities <- read.table("activity_labels.txt", as.is = TRUE)
## b. append activity label in front of our mean/std data set.
data_activity_label <- cbind(rbind(y_train, y_test), data_mean_std)
## c. use merge() to merge activities with data_activity_label.
## First, we want the intersecting columns to have the same name
colnames(activities) <- c("activity_id","activity_name")
colnames(data_activity_label) <- c("activity_id")
## Then, we perform the merge
data_activity_with_name <- merge(activities, data_activity_label)
## clear out the activity_id, now replaced with activity_name
data_activity_with_name <- data_activity_with_name[,2:ncol(data_activity_with_name)]

## 4. Use descriptive column labels
### Get a vector of descriptive column labels from:
### mean_std_index (vector of indices)
### features (table of features for means and stds)
### Subset the features of means and stds fream the features table:
features_mean_std <- features[mean_std_index, ]
### extract only the descriptive name
features_vec <- features_mean_std[[2]]
### the first column of our final table is actually "activity":
features_vec <- c("activity","subject", features_vec)
### finally, rename the columns of our table.
colnames(data_activity_with_name) <- features_vec
data.final <- data_activity_with_name

## 5. Average of each variable for each activity and each subject
### Using aggregate to group the data
data.new <- aggregate(data.final, by=list(data.final$activity,data.final$subject), FUN=mean, na.rm=TRUE)
### Clean the result by dropping unwanted columns
drop <- c("activity","subject")
data.new <- data.new[,!(names(data.new) %in% drop)]
### Renaming the grouping columns
colnames(data.new)[colnames(data.new)=="Group.1"] <- "Activity"
colnames(data.new)[colnames(data.new)=="Group.2"] <- "Subject"








