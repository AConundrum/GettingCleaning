##
##   Description:
##   1. Merge the training and the test sets to create one data set.
##   2. Extract only the measurements on the mean and standard deviation for
##      each measurement.
##   3. Use descriptive activity names to name the activities in the data set.
##   4. Appropriately label the data set with descriptive variable names.
##   5. Create a second, independent tidy data set with the average of each
##      variable for each activity and each subject.
##
##   AUTHOR    : Edward J Hopkins
##   $DATE     : Thu Jul 10 01:02:11 2014     ## date()
##   $Revision : 1.00 $
##   DEVELOPED : Rstudio, Version 0.98.507    ## packageVersion("rstudio")
##             : R version 3.1.0 (2014-04-10) ## R.Version.string
##   Copyright : Copyright (c) 2014 E. J. Hopkins
##   FILENAME  : run_analysis.R

## Dependencies:
## See also:

###############################################################################     
## BEGIN CODE
# Assume the folder "UCI HAR Dataset" is in the working directory
FILES <- list("UCI HAR Dataset/train/X_train.txt",       # RAW[1], Data  
              "UCI HAR Dataset/test/X_test.txt",         # RAW[2], Data
              "UCI HAR Dataset/features.txt",            # RAW[3], Data labels
              "UCI HAR Dataset/activity_labels.txt",     # RAW[4]
              "UCI HAR Dataset/train/subject_train.txt", # RAW[5], Subjects
              "UCI HAR Dataset/test/subject_test.txt",   # RAW[6], Subjects
              "UCI HAR Dataset/train/y_train.txt",       # RAW[7], Activities
              "UCI HAR Dataset/test/y_test.txt")         # RAW[8], Activities
RAW <- sapply(FILES,read.table,simplify=FALSE)           # Read in all files

## 1. Merge the training and the test sets to create one data set.
allDATA <- rbind(RAW[[1]],RAW[[2]])    # train over test
Subject <- rbind(RAW[[5]],RAW[[6]])    # train over test
ActNumber <- rbind(RAW[[7]],RAW[[8]])  # train over test

##3. Use descriptive activity names to name the activities in the data set.
ActNumFact <- as.factor(ActNumber$V1)        # to rename, must be factor
levels(ActNumFact) <- as.vector(RAW[[4]]$V2) # Rename Activity levels (keep correct order)

## 2. Extract only the measurements on the mean and standard deviation for
##    each measurement.
VarNames <- RAW[[3]]$V2                    # Create a variable containing labels
Nidx <- grep("(mean\\(|std\\())",VarNames) # Use "(" so it doesn't find meanFreq
names(allDATA)[Nidx] <- as.character(VarNames[Nidx]) # replace column names
tmpDATA <- allDATA[Nidx]                   # Only pick "std()" and "mean()" columns

##   4. Appropriately label the data set with descriptive variable names.
VarNAMES <- names(tmpDATA)
VarNAMES <- gsub("[[:punct:]]","",VarNAMES)  # Remove punctuation
VarNAMES <- gsub("std","Std",VarNAMES)       # Capitalize std
VarNAMES <- gsub("mean","Mean",VarNAMES)     # Capitalize mean
VarNAMES <- gsub("BodyBody","Body",VarNAMES) # Fix typo of "BodyBody" to "Body"
names(tmpDATA) <- VarNAMES

DATA <- cbind(Subject,ActNumFact,tmpDATA) # This is the working data set.
rm(list=setdiff(ls(),"DATA"))
names(DATA)[[1]] <- "Subject"
names(DATA)[[2]] <- "Activity"

##   5. Create a second, independent tidy data set with the average of each
##      variable for each activity and each subject.
TIDY <- aggregate(DATA[,-1:-2],list(Subject=DATA$Subject,Activity=DATA$Activity),mean)
write.table(TIDY,file="TIDY.txt")
#rm(TIDY)
#TIDY2 <- read.table("TIDY.txt")
## END CODE
###############################################################################     

## MODIFICATIONS:
## date()
## Description...

## If this code does not work, then I don't know who wrote it.