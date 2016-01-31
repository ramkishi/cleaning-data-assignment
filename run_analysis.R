# install (if necessary) and load required packages
install.packages("plyr")
install.packages("dplyr")
library(plyr)
library(dplyr)
library(stringr)
library(reshape2)

codebook <- function(...){
  cat(..., "\n",file=targetCodebookFilePath,append=TRUE, sep="")
}

targetCodebookFilePath <- "./CodeBook.md"
file.remove(targetCodebookFilePath)
codebook("# Code Book")
codebook("generated ",as.character(Sys.time())," during sourcing of `run_analysis.R`")
codebook("")  

# read in the test data

codebook("reading test dataset") 
x_test <- read.table("UCI HAR Dataset\\test\\X_test.txt")
y_test <- read.table("UCI HAR Dataset\\test\\y_test.txt")
subject_test <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
x_train <- read.table("UCI HAR Dataset\\train\\X_train.txt")
y_train <- read.table("UCI HAR Dataset\\train\\y_train.txt")
train_subjects <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
codebook("reading features") 
# read in the features
features <- read.table("UCI HAR Dataset\\features.txt")
codebook("merging the test sets and training sets to create single data set") 
# 1) merge the test sets and training sets to create single data set
combined_data <- rbind(x_test,x_train)
combined_y <- rbind(y_test,y_train)
combined_subjects <- rbind(subject_test,train_subjects)

# apply the features V2 column as the headers for the combined_data data frame
# clean up the names first to remove hyphens and parentheses
listOfNames <- as.character(features$V2)
listOfNames <- make.names(listOfNames, unique=TRUE)
names(combined_data) <- listOfNames

# add combined_y and combined_subjects as the first columns in the combined_data data frame
combined_data <- cbind(combined_y, combined_data)
names(combined_subjects) = c('subjects')
combined_data <- cbind(combined_subjects, combined_data)
codebook("extracing only the measurements on the mean and standard deviation")
# 2) for each measurement extract only the measurements on the mean and standard deviation
subset_data <- select(combined_data, subjects, V1, contains(".mean."), contains(".std."))
codebook("convert the subject and activities columns to factors")

# convert the subject and activities columns to factors
subset_data$subjects <- as.factor(subset_data$subjects)
subset_data$V1 <- as.factor(subset_data$V1)
codebook("using descriptive activity names by naming the activites in the data set")
# 3) use descriptive activity names by naming the activites in the data set
subset_data$V1 <- mapvalues(subset_data$V1, from = c("1", "2", "3", "4", "5", "6"), 
                         to = c("Walking", "WalkingUpStairs", "WalkingDownStairs", "Sitting", "Standing", "Lying"))
codebook("appropriately labeling the data set with descriptive variable names")
# 4) appropriately label the data set with descriptive variable names
# (Refer codebook.md for an explanation of the variable names.)
names(subset_data) <- str_replace_all(names(subset_data), "[.][.]", "")
names(subset_data) <- str_replace_all(names(subset_data), "BodyBody", "Body")
names(subset_data) <- str_replace_all(names(subset_data), "tBody", "Body")
names(subset_data) <- str_replace_all(names(subset_data), "fBody", "FFTBody")
names(subset_data) <- str_replace_all(names(subset_data), "tGravity", "Gravity")
names(subset_data) <- str_replace_all(names(subset_data), "fGravity", "FFTGravity")
names(subset_data) <- str_replace_all(names(subset_data), "Acc", "Acceleration")
names(subset_data) <- str_replace_all(names(subset_data), "Gyro", "AngularVelocity")
names(subset_data) <- str_replace_all(names(subset_data), "Mag", "Magnitude")
for(i in 3:68) {if (str_detect(names(subset_data)[i], "[.]std")) 
                {names(subset_data)[i] <- paste0("StandardDeviation", str_replace(names(subset_data)[i], "[.]std", ""))}}
for(i in 3:68) {if (str_detect(names(subset_data)[i], "[.]mean")) 
                {names(subset_data)[i] <- paste0("Mean", str_replace(names(subset_data)[i], "[.]mean", ""))}}
names(subset_data) <- str_replace_all(names(subset_data), "[.]X", "XAxis")
names(subset_data) <- str_replace_all(names(subset_data), "[.]Y", "YAxis")
names(subset_data) <- str_replace_all(names(subset_data), "[.]Z", "ZAxis")
codebook("creating a second, independent tidy data set with the average of each variable for each activity and each subject") 
# 5) from the data set in step 4, create a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
# Use a split/apply/combine method. First, split the data by the subject and activity factors.
split_set <- split(select(subset_data, 3:68), list(subset_data$subjects, subset_data$V1))
# Use apply to calculate the mean of each column in the resulting list after using lapply to iterate over each item .
mean_set <- lapply(split_set, function(x) apply(x, 2, mean, na.rm=TRUE))
# Convert the resulting output in the form of list to a data frame.
tidy_set <- data.frame(t(sapply(mean_set,c)))

# using strsplit, then add them to a separate data frame that can be combined with the tidy data set using cbind.
factors <- data.frame(t(sapply(strsplit(rownames(tidy_set), "[.]"),c)))
tidy_set <- cbind(factors, tidy_set)

codebook("Give the subject and activity columns friendly names, and convert them to factors")
# Give the subject and activity columns friendly names, and convert them to factors.
tidy_set <- dplyr::rename(tidy_set,TestSubject = X1, Activity = X2)
tidy_set$TestSubject <- as.factor(tidy_set$TestSubject)
tidy_set$Activity <- as.factor(tidy_set$Activity)
rownames(tidy_set) <- NULL
codebook(" carrying out first DATA VERIFICATIION")
# DATA VERIFICATION - "manually" generate a couple test variables to verify that the calculated average values are correct.
# pull all of the data for subject = 1, activity = walking, variable = tBodyAcc.mean...X
test_set <- select(filter(subset_data, V1=="Walking" & subjects==1), MeanBodyAccelerationXAxis)
# calculate the mean, and compare it to the same calculation from the result set.
tidy_set_val <- select(filter(tidy_set, TestSubject==1 & Activity=="Walking"), MeanBodyAccelerationXAxis)$MeanBodyAccelerationXAxis
result <- all.equal(mean(test_set$MeanBodyAccelerationXAxis), tidy_set_val)
print("Data calculation verification--TRUE indicates the verification passed:")
print(result)
codebook(" carrying out second DATA VERIFICATIION")
# second verification, with data from the middle of the matrix
test_set <- select(filter(subset_data, V1=="Sitting" & subjects==5), StandardDeviationFFTBodyAccelerationXAxis)
tidy_set_val <- select(filter(tidy_set, TestSubject==5 & Activity=="Sitting"), StandardDeviationFFTBodyAccelerationXAxis)$StandardDeviationFFTBodyAccelerationXAxis
result <- all.equal(mean(test_set$StandardDeviationFFTBodyAccelerationXAxis), tidy_set_val)
print(result)

# write the tidy data set to a file for project submission
write.table(tidy_set, "tidy_data_set.txt", row.names=FALSE)

# Environment clean up - tidy up the global environment by removing temporary variables to save memory
rm(combined_data)
rm(combined_subjects)
rm(combined_y)
rm(factors)
rm(features)
rm(subset_data)
rm(test_subjects)
rm(x_test)
rm(y_test)
rm(train_subjects)
rm(x_train)
rm(y_train)
rm(listOfNames)
rm(mean_set)
rm(split_set)


# writing variable properties
codebook("") 
codebook("## `resultData` variable\n")
codebook("### key columns\n")
codebook("Variable name       | Description")
codebook("--------------------|------------")
codebook("`subject`           | ID of subject, int (1-30)")
codebook("`activity_num`      | ID of activity, int (1-6)")
codebook("`activity_name`     | Label of activity, Factor w/ 6 levels")

codebook("### non-key columns\n")
codebook("Variable name       | Description")
codebook("--------------------|------------")
codebook("`variable`          | complete name of the feature, Factor w/ 66 levels (eg. tBodyAcc-mean()-X) ")
codebook("`value`             | the actual value, num (range: -1:1)")
codebook("`dimension`         | dimension of measurement, Factor w/ 2 levels: `t` (Time) or `f` (Frequency)")
codebook("`source`            | source of measurement, Factor w/ 3 levels: `Body`,`BodyBody` or `Gravity`")
codebook("`type`              | type of measurement, Factor w/ 2 levels: `Acc` (accelerometer) or `Gyro` (gyroscope)")
codebook("`jerk`              | is 'Jerk' signal , Factor w/ 2 levels:  `Jerk` or `` (non Jerk)")
codebook("`magnitude`         | is 'Magnitude' value , Factor w/ 2 levels:  `Mag` or `` (non Mag)")
codebook("`method`            | result from method , Factor w/ 2 levels:  `mean` (average) or `std` (standard deviation)")
codebook("`axis`              | FFT exrapolated to axis , Factor w/ 2 levels:  `` (no FFT-axis) or `X`, `Y` or `Z`")

codebook("") 
codebook("## `tidyData` variable\n")
codebook("### key columns\n")
codebook("Variable name       | Description")
codebook("--------------------|------------")
codebook("`activity_name`     | Label of activity, Factor w/ 6 levels")
codebook("`subject`           | ID of subject, int (1-30)")


codebook("### non-key columns\n")
codebook("Variable name       | Description")
codebook("--------------------|------------")
tidyDataCols <- names(tidy_set)[3:68]
for(tdc in tidyDataCols){
  codebook("`",tdc,"`   | the average value for this feature, num (range: -1:1)")
}