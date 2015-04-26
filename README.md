# GetCleanData_CourseProject
Repository for uploading the "Getting and Cleaning Data" Course Project in Coursera

This file explains which has been my line of action to deliver the Course Project.

1) Understand the goal of the assignment:
Given an original data set, obtain a tidy data set with two fixed variables and a key-value pair (averages of some measurementws, value of those averages) that has to be uploaded to Coursera, plus three files that have to be uploaded to github:
    run_analysis.R script: Does the data reading and cleaning, producing the tidy data set.
    README MD file: Explains what has been done to produce the desired result.
    CodeBook MD file: Explains the variables in the tidy data set.

2) Understand the original data set structure:
- Raw sensor signals (accelerometer and gyroscope) that result in 128 samples/window after pre-processing (Inertial Signals directory).
- For each window sample, a vector of 561 features was obtained by calculating variables from the time and frequency domain (X_ files in test and train directories).
- The activity label for each window sample (y_ files in test and train directories).
- The subject who performed the activity for each window sample (subject_ files in test and train directories).
- Equivalence of activity labels and activity names (activity_labels.txt file).
- All 561 feature names (features.txt file)

3) Define a procedure to reach the goal:
- Download, extract and load into R the original data set.
- The original data set is divided in two (test, train) and needs to be merged.
- Certain variables have to be selected from the merged data set (mean, std).
- Add activity labels and subjects to the resulting data set and then join the activity names for each observation.
- Label the data set with descriptive variable names for each variable.
- Create a second, independent tidy data set with the average of each selected variable for each activity and each subject.
- Reshape the tidy data set obtain two fixed variables (subject, activity name) and a key-value pair (selected variables, average values).
- Write the tidy data set into a text file that can be uploaded to Coursera.
- Describe the followed procedure in the README MD file.
- Describe the tidy data set variables in the CodeBook MD file.
- Do the uploading of all files.
- Submit on Coursera Project page.

4) Do it!!
Some notes here about decisions I have taken:
- The R script includes comments for most of the steps in the code.
- The script does not include code to unzip the original data source files, as indicated in some discussion forum threads, it just checks if the working directory includes the folder name where the zipped data set is stored (UCI HAR Dataset).
- I have strictly selected the columns that include mean and std variables, meaning that I excluded the meanFreq variables. Therefore, the character vector containing these selected variables (meanStdColumnNames) is 66 elements long. But this definition can be easily modified by changing the regex in the grep() functions used to generate meanStdColumnNames.
- In case meanStdColumnNames is changed, I have used relative positioning to assign column names to the new columns (Activity, Subject, ActivityName) added to the working data frame (meanStdDF).
- I used the make.names() function to ensure that selected variable names are syntactically valid, but as the variable names were already quite long, I did not elaborate them further. Detailed explanation about selected variable names is included in the code book.
- I used functions in the {dplyr} and {tidyr} packages to generate the tidy data set because with little code you obtain powerful functionality (and it is supposed to be high-performing, although I have not been able to compare it to other methods).
- I opted for a narrow-shaped tidy data set following the suggestions in the tidyr vignette (each variable forms a column, each observation forms a row).
- I wrote the final text file following the assigment instructions (just specifying parameter row.names = FALSE). This outputs a space-separated text file with quoted character values, which is not very pretty, but...

5) Package dependencies:
- {dplyr}
- {tidyr}

6) References used to complete the assignment:
- Hadley Wickham's "Tidy Data" paper (http://vita.had.co.nz/papers/tidy-data.html).
- tidyr vignette (http://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html).
- Discussion forum threads.
- StackOverflow posts.

Hope it is clear enough ;-)
