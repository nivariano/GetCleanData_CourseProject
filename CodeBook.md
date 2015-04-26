# run_analysis.R code book

This code book explains the data structures and variables used in the script 
run_analysis.R used in the Course Project for the Coursera course "Getting 
and Cleaning Data" (apr 2015).

Code book structure: name/type/description, separated by "/".
Kept it in one single line so it can be read into an R object.

# Data source structures (read from the raw data set):

activity_labelsDF/data frame/Correspondence between activity labels and names

featuresDF/data frame/561 calculated variable names only, no measurements

subject_DF/data frame/Merged from train and test sets, contains subject ids

y_DF/data frame/Merged from train and test sets, contains activity labels

X_DF/data frame/Merged from train and test sets, measurements for 561 vars.

# Working data structures:

meanStdColumnNames/chr vector/Contains names of selected variables (mean, std)

meanStdDF/data frame/Contains selected variables, act.labels/names, subjects

tidyDF/data frame/Selected variables' mean values, grouped by subject/act.name

narrowDF/data frame/Reshaped data: subject, act.name, var.(key), mean (value)

# Variables in the final tidy data set (narrowDF):

Subject/integer/Fixed variable [1:30], identifying each of the subjects that took part in the experiment. Obtained from the subject_xxx.txt files in the orginal data set. More information in the README.txt file of the orginal data set.

ActivityName/character/Fixed variable ["WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"], identifying one of the six possible activities performed by the subjects in the experiment. Obtained from the activity_labels.txt file in the orginal data set. More information in the README.txt file of the orginal data set.

meanStdVars/factor/Key variable in the key-value pair, factor with 66 levels holding those variables selected from the original data set which contain a mean() or a std() measurement (but not a meanFreq() measurement). The range is a subset extracted from the features.txt file in the original data set. More information in the features_info.txt file of the orginal data set.

AverageValue/numeric/Value variable in the key-value pair, which is the average of all the measurements for each selected variable (mean, std), for each activity performed by each subject.

# Final output text file:

TidyDataSet.txt/txt file/Contains narrowDF data frame values, space-separated
