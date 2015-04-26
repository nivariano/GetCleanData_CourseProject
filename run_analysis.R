# Coursera Course Project
# Course name: Getting and Cleaning Data (Johns Hopkins University)
# Course edition: april 2015
#
# Assignment description:
# You should create one R script called run_analysis.R that does the following:
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each
# measurement. 
# 3) Uses descriptive activity names to name the activities in the data set.
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.


# Start of script.

# First, make sure the required data is in the working directory,
# assuming it has been unzipped in there without changing subdir structure.

if (!file.exists("UCI HAR Dataset")) {
    stop("UCI HAR Dataset folder not in the working directory!!")
}

# 1) Merges the training and the test sets to create one data set.

# Read in all the useful raw data files.

activity_labelsDF <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                                stringsAsFactors = FALSE)

featuresDF <- read.table("./UCI HAR Dataset/features.txt", 
                         stringsAsFactors = FALSE)

subject_testDF <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                             stringsAsFactors = FALSE)

y_testDF <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                       stringsAsFactors = FALSE)

X_testDF <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                       colClasses = "numeric")

subject_trainDF <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                              stringsAsFactors = FALSE)

y_trainDF <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                        stringsAsFactors = FALSE)

X_trainDF <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                        colClasses = "numeric")

# Use rbind() to merge test and train data sets.

subject_DF <- rbind(subject_testDF, subject_trainDF)
y_DF <- rbind(y_testDF, y_trainDF)
X_DF <- rbind(X_testDF, X_trainDF)

# 2) Extracts only the measurements on the mean and standard deviation for each
# measurement.

# Assign feature names to column names in order to do the subsetting.

colnames(X_DF) <- featuresDF$V2

# Use grep() to select which columns contain mean and std (but not meanFreq) 
# variables.

meanStdColumnNames <- grep("mean|std", featuresDF$V2, value = TRUE)
meanStdColumnNames <- grep("meanFreq", meanStdColumnNames, value = TRUE, invert = TRUE)

# Use the resulting vector to subset the data frame containing means and stds.

meanStdDF <- X_DF[, meanStdColumnNames]

# 3) Uses descriptive activity names to name the activities in the data set.

# First, bind Subject and Activity columns so they are already there when we 
# will join data frames and rows are re-arranged.

meanStdDF <- cbind(meanStdDF, y_DF)
colnames(meanStdDF)[length(colnames(meanStdDF))] <- "Activity"
meanStdDF <- cbind(meanStdDF, subject_DF)
colnames(meanStdDF)[length(colnames(meanStdDF))] <- "Subject"

# Add activity names to the working data frame.

library(dplyr)

meanStdDF <- right_join(meanStdDF, activity_labelsDF, by = c("Activity" = "V1"))
colnames(meanStdDF)[length(colnames(meanStdDF))] <- "ActivityName"

# 4) Appropriately labels the data set with descriptive variable names. 

# Ensure variable names are syntactically valid.
# Abbreviations explained in the code book MD file.

names(meanStdDF) <- make.names(names(meanStdDF), unique = TRUE)

# 5) From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# Select the columns that will make up the tidy data set.

tidyDF <- select(meanStdDF, Subject, ActivityName, 1:length(meanStdColumnNames))

# Create groups and calculate selected variable averages.

tidyDF <- group_by(tidyDF, Subject, ActivityName)
tidyDF <- summarise_each(tidyDF, funs(mean))

# Reshape the tidy data set into a narrow form to have a key-value pair of 
# columns with selected variables (key) and average values (value).

library(tidyr)

narrowDF <- gather(tidyDF, meanStdVars, AverageValue, -(Subject:ActivityName))
narrowDF <- arrange(narrowDF, Subject, ActivityName)

# Create output txt file with write.table() using row.name=FALSE.

write.table(narrowDF, 
            file = "TidyDataSet.txt", 
            row.names = FALSE)

# End of script.
