library(tidyverse)

####################################################################################################################################
############################################################   Week 4 course assignment   ##########################################

setwd("G:/Kostnadsanalyse og prising/R kurs/Coursera Data Science")

### Test data
dx_test <- read.table("w4assignment_ca/UCI HAR Dataset/test/X_test.txt",header=FALSE,sep="")
dy_test <- read.table("w4assignment_ca/UCI HAR Dataset/test/y_test.txt",header=FALSE,sep="")
dsubject_test <- read.table("w4assignment_ca/UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep="")
names(dsubject_test) <- "subject"
str(dx_test)
str(dy_test)
table(dy_test)
str(dsubject_test)
table(dsubject_test)

### These comments apply both to the test and train data
### Test data x is 2947 observations with 561 variables. The variable names are contained in Features.txt
### Data y is a code description of activity for different observations, 2947 observations of one variable. The file Activity_labels.txt links code in y file to activity names
### The file subject.txt contains an identifier for the individual subject. Of 30 individuals 9 are in the test data and 21 are in the train data. No overlap.

### Train data
dx_train <- read.table("w4assignment_ca/UCI HAR Dataset/train/X_train.txt",header=FALSE,sep="")
dy_train <- read.table("w4assignment_ca/UCI HAR Dataset/train/y_train.txt",header=FALSE,sep="")
dsubject_train <- read.table("w4assignment_ca/UCI HAR Dataset/train/subject_train.txt",header=FALSE,sep="")
names(dsubject_train) <- "subject"
str(dx_train)
str(dy_train)
str(dsubject_train)

### Data information
dfeatures <- read.table("w4assignment_ca/UCI HAR Dataset/features.txt",header=FALSE,sep="")
str(dfeatures)                     # V1 is number, V2 is name
dactivity_labels <- read.table("w4assignment_ca/UCI HAR Dataset/activity_labels.txt",header=FALSE,sep="")
str(dactivity_labels)              # V1 is number, V2 is name
names(dactivity_labels) <- c("activity_code","activity_name")


###########################################################  Procedure for merging dataset  ############################################
# Step 1) Combine X_test dataset with column names from features.txt using names() command
# Step 2) Use names() to name y_test column as activity_code
# Step 3) Combine X_test and y_test using cbind()
# Step 4) Combine the file from step 3 with subject_test using cbind()
# Step 5) Do step 1 to step 4 for the corresponding train datasets. The order of columns must be identical in the two datasets
# Step 6) Combine the two datasets from step 1-4 using rbind()
# Step 7: Extract columns with mean or standard deviation and identifiers for activity and subject
# Step 8) Combine the new file with activity names using left_join by activity code

# Step 1-4 for test data
names(dx_test) <- dfeatures$V2
names(dy_test) <- "activity_code"
ctest <- cbind(dx_test,dy_test)
ctest <- cbind(ctest,dsubject_test)

# Step 5: Do step 1-4 for train data
names(dx_train) <- dfeatures$V2
names(dy_train) <- "activity_code"
ctrain <- cbind(dx_train,dy_train)
ctrain <- cbind(ctrain,dsubject_train)

# Step 6: combining ctest and ctrain
cfile <- rbind(ctrain, ctest)

# Step 7: Extract columns with mean or standard deviation and identifiers for activity and subject
cfile <- cfile %>% select(ends_with(c("activity_code","subject","mean()","std()")))

# Step 8: add labels to activity code
cfile <- left_join(dactivity_labels,cfile, by="activity_code")

#################################################################################################################
# create a second, independent tidy data set with the average of each variable for each activity and each subject.

grpmeans <- cfile %>% group_by(activity_code, activity_name, subject) %>% summarise_all(mean)

### This ends the assignment