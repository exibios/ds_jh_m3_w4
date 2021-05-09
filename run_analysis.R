oldw <- getOption("warn")

options(warn = -1)

## 0 get data
#file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#data_file<-"data.zip"
#download.file(file,data_file,method = "curl")
#unzip(data_file)

#read x_test measures of test data
tx <- read.table("UCI HAR Dataset/test/X_test.txt")
#read y_test activity of test data
ty <- read.table("UCI HAR Dataset/test/y_test.txt")
#read x_train measures of train data
trx <- read.table("UCI HAR Dataset/train/X_train.txt")
#read y_train activity of train data
try <- read.table("UCI HAR Dataset/train/y_train.txt")
# column names are in features.txt
features <- read.table("UCI HAR Dataset/features.txt")
# 1 Merges the training and the test sets to create one data set.
test_train_x <- rbind(tx,trx)
# also activity data should be binded
test_train_y <- rbind(ty,try)
# assing measure column names to the measures data.frame
colnames(test_train_x)<-(features$V2)
# rename the activity column
colnames(test_train_y)<-(c("activity"))
# cbind activity column to get only one dataset
test_train <- cbind(test_train_x,test_train_y)
# find the columns with mean or std strings to filter mean and standard deviation ones
mean_and_std <- features[grep("(mean|std)",features$V2),]
# get a list of
mean_and_std <- unlist(mean_and_std["V2"])
# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
# with the list of columns fitered by mean and std, keep also activity
mean_and_std_for_measurement <- test_train[,c(mean_and_std,"activity")]
# 3 Uses descriptive activity names to name the activities in the data set
# #activity is already present
# unique(mean_and_std_for_measurement$activity)
# 4 Appropriately labels the data set with descriptive variable names. 
# adding the descriptive activity name
library(dplyr)
mean_and_std_for_measurement <- mutate(mean_and_std_for_measurement,activity_name="")
mean_and_std_for_measurement <- mutate(mean_and_std_for_measurement,activity_name=ifelse(activity==1,"WALKING",activity_name))
mean_and_std_for_measurement <- mutate(mean_and_std_for_measurement,activity_name=ifelse(activity==2,"WALKING_UPSTAIRS",activity_name))
mean_and_std_for_measurement <- mutate(mean_and_std_for_measurement,activity_name=ifelse(activity==3,"WALKING_DOWNSTAIRS",activity_name))
mean_and_std_for_measurement <- mutate(mean_and_std_for_measurement,activity_name=ifelse(activity==4,"SITTING",activity_name))
mean_and_std_for_measurement <- mutate(mean_and_std_for_measurement,activity_name=ifelse(activity==5,"STANDING",activity_name))
mean_and_std_for_measurement <- mutate(mean_and_std_for_measurement,activity_name=ifelse(activity==6,"LAYING",activity_name))

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#read subject_test rows of test data
sbj_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
#read subject_train rows of train data
sbj_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
#rbind test and train subject data
sbj <- rbind(sbj_test,sbj_train)
#set colname on subject
colnames(sbj) <- c("subject")
# cbind subject data to working data.frame
mean_and_std_for_measurement_sbj <- cbind(mean_and_std_for_measurement,sbj)
#head(mean_and_std_for_measurement_sbj,5)

mean_and_std_for_measurement_sbj_groupped <- mean_and_std_for_measurement_sbj %>%
        group_by(activity_name,subject) %>%
        summarize_at(vars(-activity),funs(mean))

#easy visualization
#write.table(mean_and_std_for_measurement_sbj_2[,c('activity_name','subject','tBodyAcc-mean()-X')],"f.csv")

options(warn = oldw)