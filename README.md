# getting_cleaning_data_assignment
A repository for the course assignment

The data files analysed in this project were downloaded from the internet. The source adress is:
            https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Only a subset of the unzipped files were used in the analysis. These are the files in the directory "UCI HAR Dataset" and the two directories below this "Test" and "Train"
The R code will show which files were used.

The following procedure was used for merging the dataset:
# Step 1) Combine X_test dataset with column names from features.txt using names() command
# Step 2) Use names() to name y_test column as activity_code
# Step 3) Combine X_test and y_test using cbind()
# Step 4) Combine the file from step 3 with subject_test using cbind()
# Step 5) Do step 1 to step 4 for the corresponding train datasets. The order of columns must be identical in the two datasets from Test and Train data.
# Step 6) Combine the two datasets from step 1-4 using rbind()
# Step 7: Extract columns with mean or standard deviation and identifiers for activity and subject
# Step 8) Combine the new file with activity names using left_join by activity code

The R code follows and indicates the steps of this procedure.

Finally a new dataset is established with mean values for all variables and grouped by activity and subject.
The new dataset is established using the following tidyverse code:
          grpmeans <- cfile %>% group_by(activity_code, activity_name, subject) %>% summarise_all(mean)

I comment here on the 5 parts on the assignment:
You should create one R script called run_analysis.R that does the following.

1 Merges the training and the test sets to create one data set: This is done in steps 1-6 in the procedure.
2 Extracts only the measurements on the mean and standard deviation for each measurement: This is done in step seven using the select order
3 Uses descriptive activity names to name the activities in the data set: This is done in step 8
4 Appropriately labels the data set with descriptive variable names: This is done in step 1 in the procudure. I use the variable names in the original dataset.
5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:
          The new dataset is established using the following tidyverse code:
          grpmeans <- cfile %>% group_by(activity_code, activity_name, subject) %>% summarise_all(mean)
          
