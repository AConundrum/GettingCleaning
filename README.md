### Introduction

This repository hosts R-code and associated documentation for the assignment of the DataScience track's "Getting and Cleaning Data" course.  The purpose of this project is to demonstrate the collection, manipulation, and cleaning of a publicly available data set.  There are 3 files of interest...

1. `README.md` (this document), is an overview of the files in this repository which also describes the steps used to manipulate the raw data set into the final data set.

2. `run_analysis.R` is the master script for this project. It can be loaded into R/Rstudio and executed without any parameters.

3. `CodeBook.md` describes the variable names of the data set that results from the master script.

### The data set
The data set "Human Activity Recognition Using Smartphones" has been taken from [UCI's Machine Learning Repository](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The Data Set was manually downloaded and unzipped to an appropriate working directory in a folder named `UCI HAR Dataset`.

###   Description of `run_analysis.R`:
1. Merge the training and the test sets to create one data set.
     * Assume the folder "UCI HAR Dataset" is in the working directory
     * Read all the relevant files into a list of tables. (named RAW)
     * Use 'rbind()' for merging, taking care to keep all the data in the same order.
          * Make sure the training data set is first or above the test data set
     for each 'rbind()' call.
          * rbind the data
          * rbind the subjects
          * rbind the activity numbers
2. Extract only the measurements on the mean and standard deviation for
   each measurement.
     * Create a variable for the labels (found in features.txt)
     * Search for (grep) only labels with "`std(`" or "`mean(`" (so it does not find meanFreq)
     * Replace the default column names (V1, V2...) with the appropriate found (grep'ed) labels.
3. Use descriptive activity names to name the activities in the data set.
     * Map the activity numbers to activity names (easy using factors)
     * Make sure to keep the correct order
4. Appropriately label the data set with descriptive variable names.
     * Remove (gsub) all punctuation
     * Capitalize std and mean
     * Fix the BodyBody to Body (labeling error)
5. Create a second, independent tidy data set with the average of each
   variable for each activity and each subject.
     * cbind the subjects, activities, and data into one data set. (double check for correct column names)
     * aggregate the data by taking the mean of each column subsetted by first the subject and second by the activity.
     * save the result to a file
     * The data is considered tidy because there is one set of independent measurements for each subject/activity pair.

The result of the execution is that a file (`tidy.txt`) is created, that stores the data (mean and standard deviation of each measurement per activity&subject) for later analysis.

It can be read in at the R command prompt by invoking:<br>
`TIDY <- read.table("TIDY.txt")`