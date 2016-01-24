##copy data files into the same folder of working directory
setwd("./r_projects/t3assign")
getwd()
##tst_ for test, trn_ for training
tst_survey<-read.table("subject_test.txt")
tst_x<-read.table("X_test.txt")
tst_y<-read.table("y_test.txt")
trn_survey<-read.table("subject_train.txt")
trn_x<-read.table("X_train.txt")
trn_y<-read.table("y_train.txt")

##col_header are variable headers
col_header<-read.table("features.txt",stringsAsFactors = F)

##act is the activity lables
act<-read.table("activity_labels.txt")

##original assignment requirements:
##1. Merges the training and the test sets to create one data set.
##2. Extracts only the measurements on the mean and standard deviation for each measurement.
##3. Uses descriptive activity names to name the activities in the data set
##4. Appropriately labels the data set with descriptive variable names.
##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## procedure 1. Merges the training and the test sets to create one data set.
## before I merge the data, I performed the following analysis to understand the files
## so I can merge the data correctly
## review the distribution in the four datasets that only have one variable
## by reviewing the results, we can guess the _survey are the id of 30 volunteers
## _y is six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
## _x has same number of columns as the number of variable names in the features.txt
## so a good guess features.txt has the column header for _x files
sapply(c(trn_survey,trn_y,tst_survey,tst_y),table)

##combining
tst<-cbind(tst_survey,tst_y,tst_x)
trn<-cbind(trn_survey,trn_y,trn_x)
df<-rbind(tst,trn)
head(df,2)


##procedure 4. Appropriately labels the data set with descriptive variable names.
names(df)<-c("id","activity",col_header[,2])

##procedure 3. Uses descriptive activity names to name the activities in the data set
##convert the activity column to factors, and use the levels of the factor as a lookup table 
## to replace number with activity names
act[,2]
df$activity<-as.factor(df$activity)
factor(df$activity, ordered=T)
levels(df$activity)<-act[,2]
levels(df$activity)

##checking results
names(df)
table(df$id)
table(df$activity)

##procedure 2. Extracts only the measurements on the mean and standard deviation for each measurement.
##this step is only possible after step 3 and 4 are performed, so the df has proper column variable names
table(grepl("*mean()|*std()",names(df)))
df_tidy<-df[,grepl("*mean()|*std()",names(df))]
df_tidy<-cbind(df[,1:2],df_tidy)

##procedure 5. From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.

## use data.table function to summarize data
## .SD is the subset of the columns of the data. 
## By default, that's all the columns in the data excluding the keys 
library(data.table)
df_mean<-setDT(df_tidy)[, lapply(.SD, mean), by=.(id, activity)]
setDF(df_mean) # convert back to dataframe

##order by id and activity before output
df_mean<-df_mean[order(df_mean[,1],df_mean[,2]),]

write.table(df_mean,"df_mean.txt", row.names = F)
