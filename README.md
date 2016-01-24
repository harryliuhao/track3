# track3
Assignment: Getting and Cleaning Data Course Project

original assignment requirements:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


 ### procedure 1. Merges the training and the test sets to create one data set.
 before I merge the data, I performed the following analysis to understand the files
 so I can merge the data correctly
 review the distribution in the four datasets that only have one variable
 by reviewing the results, we can guess the _survey are the id of 30 volunteers
 _y is six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
 _x has same number of columns as the number of variable names in the features.txt
 so a good guess features.txt has the column header for _x files


## procedure 4. Appropriately labels the data set with descriptive variable names.


##procedure 3. Uses descriptive activity names to name the activities in the data set
convert the activity column to factors, and use the levels of the factor as a lookup table 
 to replace number with activity names

##procedure 2. Extracts only the measurements on the mean and standard deviation for each measurement.
this step is only possible after step 3 and 4 are performed, so the df has proper column variable names


##procedure 5. From the data set in step 4, creates a second, independent tidy data set with the average 
 of each variable for each activity and each subject.

 use data.table function to summarize data
 .SD is the subset of the columns of the data. 
 By default, that's all the columns in the data excluding the keys 

order by id and activity before output

