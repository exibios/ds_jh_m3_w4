# Readme #
## Getting and Cleaning Data Course Project

Assignment of Getting and Cleaning Data Project, part of Data Science Specialization by Johns Hopkins University

Summary

Reading data of "Human Activity Recognition Using Smartphones Dataset" we apply concepts of cleaning and data shaping to cover: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for 6. each activity and each subject.

for the codebook of the final dataset I encourage you to consult the cookbook.html but, if not possible use the pdf one.

1. First we identify our datasets, we have 2 different kind of datasets for the measuments:

        * A. UCI HAR Dataset/train
        * B. UCI HAR Dataset/test

and we have 2 different kind of datasets to know subjects and activity dimensions

        * C. UCI HAR Dataset/test/subject_test.txt
        * D. UCI HAR Dataset/train/subject_train.txt

        * E. UCI HAR Dataset/test/y_test.txt
        * F. UCI HAR Dataset/train/y_train.txt

additionally we have one file to identify the activity with human readable text

        * G. UCI HAR Dataset/activity_labels.txt
        
and one dataset descibring the name of the measures in A and B

        * H. UCI HAR Dataset/features.txt

2. Second we prepare the data to rbinding train and test

        * AB <- A rbind B
        * CD <- C rbind D
        * EF <- E rbind F
                - The order of rbinding is important to keep the correct relationship between datasets


3. I set the columns of AB with H, to correctly know which column is which

        * names(ab)<-H

4. I keept only the mean and std columns for measurements

5. I've created columns of activity and adding it to the working dataset

6. Same with subjects, adding a new column to identify them

7. Finally I create a summary dataset with the required groupping called mean_and_std_for_measurement_sbj_groupped, the group is by activity and subject giving a total of 180 records (6 activities and 30 subjects). 








