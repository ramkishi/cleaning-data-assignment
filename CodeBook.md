# Code Book
generated 2016-01-31 21:01:52 during sourcing of `run_analysis.R`

reading test dataset
reading features
merging the test sets and training sets to create single data set
extracing only the measurements on the mean and standard deviation
convert the subject and activities columns to factors
using descriptive activity names by naming the activites in the data set
appropriately labeling the data set with descriptive variable names
creating a second, independent tidy data set with the average of each variable for each activity and each subject
Give the subject and activity columns friendly names, and convert them to factors
 carrying out first DATA VERIFICATIION
 carrying out second DATA VERIFICATIION

## `resultData` variable

### key columns

Variable name       | Description
--------------------|------------
`subject`           | ID of subject, int (1-30)
`activity_num`      | ID of activity, int (1-6)
`activity_name`     | Label of activity, Factor w/ 6 levels
### non-key columns

Variable name       | Description
--------------------|------------
`variable`          | comlete name of the feature, Factor w/ 66 levels (eg. tBodyAcc-mean()-X) 
`value`             | the actual value, num (range: -1:1)
`dimension`         | dimension of measurement, Factor w/ 2 levels: `t` (Time) or `f` (Frequency)
`source`            | source of measurement, Factor w/ 3 levels: `Body`,`BodyBody` or `Gravity`
`type`              | type of measurement, Factor w/ 2 levels: `Acc` (accelerometer) or `Gyro` (gyroscope)
`jerk`              | is 'Jerk' signal , Factor w/ 2 levels:  `Jerk` or `` (non Jerk)
`magnitude`         | is 'Magnitude' value , Factor w/ 2 levels:  `Mag` or `` (non Mag)
`method`            | result from method , Factor w/ 2 levels:  `mean` (average) or `std` (standard deviation)
`axis`              | FFT exrapolated to axis , Factor w/ 2 levels:  `` (no FFT-axis) or `X`, `Y` or `Z`

## `tidyData` variable

### key columns

Variable name       | Description
--------------------|------------
`activity_name`     | Label of activity, Factor w/ 6 levels
`subject`           | ID of subject, int (1-30)
### non-key columns

Variable name       | Description
--------------------|------------
`MeanBodyAccelerationXAxis`   | the average value for this feature, num (range: -1:1)
`MeanBodyAccelerationYAxis`   | the average value for this feature, num (range: -1:1)
`MeanBodyAccelerationZAxis`   | the average value for this feature, num (range: -1:1)
`MeanGravityAccelerationXAxis`   | the average value for this feature, num (range: -1:1)
`MeanGravityAccelerationYAxis`   | the average value for this feature, num (range: -1:1)
`MeanGravityAccelerationZAxis`   | the average value for this feature, num (range: -1:1)
`MeanBodyAccelerationJerkXAxis`   | the average value for this feature, num (range: -1:1)
`MeanBodyAccelerationJerkYAxis`   | the average value for this feature, num (range: -1:1)
`MeanBodyAccelerationJerkZAxis`   | the average value for this feature, num (range: -1:1)
`MeanBodyAngularVelocityXAxis`   | the average value for this feature, num (range: -1:1)
`MeanBodyAngularVelocityYAxis`   | the average value for this feature, num (range: -1:1)
`MeanBodyAngularVelocityZAxis`   | the average value for this feature, num (range: -1:1)
`MeanBodyAngularVelocityJerkXAxis`   | the average value for this feature, num (range: -1:1)
`MeanBodyAngularVelocityJerkYAxis`   | the average value for this feature, num (range: -1:1)
`MeanBodyAngularVelocityJerkZAxis`   | the average value for this feature, num (range: -1:1)
`MeanBodyAccelerationMagnitude`   | the average value for this feature, num (range: -1:1)
`MeanGravityAccelerationMagnitude`   | the average value for this feature, num (range: -1:1)
`MeanBodyAccelerationJerkMagnitude`   | the average value for this feature, num (range: -1:1)
`MeanBodyAngularVelocityMagnitude`   | the average value for this feature, num (range: -1:1)
`MeanBodyAngularVelocityJerkMagnitude`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAccelerationXAxis`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAccelerationYAxis`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAccelerationZAxis`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAccelerationJerkXAxis`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAccelerationJerkYAxis`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAccelerationJerkZAxis`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAngularVelocityXAxis`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAngularVelocityYAxis`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAngularVelocityZAxis`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAccelerationMagnitude`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAccelerationJerkMagnitude`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAngularVelocityMagnitude`   | the average value for this feature, num (range: -1:1)
`MeanFFTBodyAngularVelocityJerkMagnitude`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAccelerationXAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAccelerationYAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAccelerationZAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationGravityAccelerationXAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationGravityAccelerationYAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationGravityAccelerationZAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAccelerationJerkXAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAccelerationJerkYAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAccelerationJerkZAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAngularVelocityXAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAngularVelocityYAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAngularVelocityZAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAngularVelocityJerkXAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAngularVelocityJerkYAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAngularVelocityJerkZAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAccelerationMagnitude`   | the average value for this feature, num (range: -1:1)
`StandardDeviationGravityAccelerationMagnitude`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAccelerationJerkMagnitude`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAngularVelocityMagnitude`   | the average value for this feature, num (range: -1:1)
`StandardDeviationBodyAngularVelocityJerkMagnitude`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAccelerationXAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAccelerationYAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAccelerationZAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAccelerationJerkXAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAccelerationJerkYAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAccelerationJerkZAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAngularVelocityXAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAngularVelocityYAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAngularVelocityZAxis`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAccelerationMagnitude`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAccelerationJerkMagnitude`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAngularVelocityMagnitude`   | the average value for this feature, num (range: -1:1)
`StandardDeviationFFTBodyAngularVelocityJerkMagnitude`   | the average value for this feature, num (range: -1:1)
