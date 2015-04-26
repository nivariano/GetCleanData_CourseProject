Variables in the final tidy data set (narrowDF):

- Subject
Fixed variable, integer identifying each of the subjects that took part in the experiment.
Range [1:30]
Obtained from the subject_xxx.txt files in the orginal data set.
More information in the README.txt file in the orginal data set.

- ActivityName
Fixed variable, character string identifying one of the six possible activities performed by the subjects in the experiment.
Range ["WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"]
Obtained from the activity_labels.txt file in the orginal data set.
More information in the README.txt file in the orginal data set.

- meanStdVars
Key variable in the key-value pair, factor with 66 levels holding those variables selected from the original data set which contain a mean() or a std() measurement (but not a meanFreq() measurement).
The range is a subset extracted from the features.txt file in the original data set.
More information in the features_info.txt file in the orginal data set.

- AverageValue
Value variable in the key-value pair, numeric which is the average of all the measurements for each selected variable (mean, std), for each activity performed by each subject.
