Course Project, Johns Hopkins Data Science, Getting and Cleaning Data
=====================================================================
##### Objective of the project
* To demonstrate the ability to collect, work with, and clean a data set.
* To prepare tidy data that can be used for later analysis.

##### Deliverables
* A tidy data set with average of each variable for each activity and each subject described in the **Cleaning Raw Data** section.
* A link to this Github repository.
* A Code Book, included in this Github repository
* A Readme, included in this Github repository

##### Data Source
Data is collected from the accelerometers from the Samsung Galaxy S smartphone.  A full description is available [here.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
The data for the project is available [here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)



##### Cleaning Raw Data
A R script, with the name run_analysis.R, was created to perform the following task:
###### 1. Merges the training and the test sets to create one data set.
* a. Horizontally merge X_train.txt, subject_train.txt, and y_train.txt
* b. Horizontally merge X_test.txt, subject_Test.txt, and y_test.txt
* c. Vertically merge dataframe from a and b

###### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
* grep() was used to identify indices of feature names that contain **mean** or **std**.
* With data frame from step 1, only columns of the above indices are extracted.

###### 3. Uses descriptive activity names to name the activities in the data.
* Load activity labels
* Append activity label in front of our mean/std data set.
* Use merge() to merge activities labels with the data frame from step 2.

###### 4. Appropriately labels the columns with descriptive names.
* Get a vector of descriptive column labels from the vector of indices of mean or std feature.
* Subset the features of means and stds fream the features table.
* Extract only the descriptive name.
* Set The first column of our final table to "Activity".
* Finally, rename the columns of our table.

###### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* Using aggregate to group the data.
* Clean the result by dropping unwanted columns.
* Renaming the grouping columns._


##### Criteria for Choosing Columns
* Measurement names that includes the string **mean** or **std**

##### Discussion of the result 
Two data sets were generated as a result of the script, one from step 1 to 4 and the other from step 5 of **Cleaning Raw Data** section.
The first script, generated from step 1 to 4, has 10299 rows and 81 columns.  The first column gives the acitivity name, and the second column states the ID of participating subjects.  The remaining column are values of mean and standard deviation of each measurement.

The second data set is the result of step 5.  The data set is first grouped by Activity, then by Subject. There are 180 rows and 81 columns.  The first two colums are the activity name and subject ID.  The remaining columns gives the average of each variable for each activity, and for each subject.   

