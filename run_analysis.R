## This script creates the two tidy data sets required for the
## Coursera "Getting and Cleaning Data" (getdata-004) course project.

## The requirements are:

# You should create one R script called run_analysis.R that does the following. 
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for
#   each measurement. 
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names. 
# 5 Creates a second, independent tidy data set with the average of each
#   variable for each activity and each subject. 

## Comments:

# Here we will do 2 before 1 as it is good practice (for performance not least)
# to discard large amounts of unnecessary data as soon as possible/feasible.
# 4 we will do in two steps - first applying the feature labels of the source
# as column names to the source data - and then later choosing and applying
# our own more user-friendly descriptive names.

## Script:

# By instruction this code is to assume that the "Samsung data"
# (i.e. the "UCI HAR Dataset" folder) is in the current working
# directory. Hence we do not call setwd()...
#setwd("~/git/Coursera-getdata-004-Project")

# First we load the relevant files into data frames of the same name
# - the files in the "Inertial Signals" folders are not relevant as
# they do not contain "mean()" or "std()" data.

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")

# Then we assign column names to this source data.
# For the X_test & X_train data we simply use the labels
# in the features data. For the rest we make up our own:
names(activity_labels) <- c("ActivityNo","ActivityLabel")
names(features) <- c("FeatureNo","FeatureLabel")
names(subject_test) <- "SubjectNo"
names(subject_train) <- "SubjectNo"
names(X_test) <- features$FeatureLabel
names(X_train) <- features$FeatureLabel
names(Y_test) <- "ActivityNo"
names(Y_train) <- "ActivityNo"

# We identify columns that contain mean or standard deviation data.
# I.e. those where the feature label contains "-mean()" or "-std()".
RelevantFeatureNo <- sort(union(grep("-mean()", features$FeatureLabel, fixed=TRUE), grep("-std()", features$FeatureLabel, fixed=TRUE)))

# And with this filter (applied to the columns of X_test and X_train)
# we combine all the relevant data together (still separately for
# test and train) with cbind and join on the activity labels with merge.
RelevantTestData <- merge(activity_labels,cbind(subject_test,Y_test,X_test[,RelevantFeatureNo]))
RelevantTrainData <- merge(activity_labels,cbind(subject_train,Y_train,X_train[,RelevantFeatureNo]))

# We now have two tidy data sets, but before we simply combine them
# into one, we should make sure that all the columns are compatible.
# Specifically, we might have a problem if the subject numbers used
# in the two sets were overlapping. This we can check with:
# > intersect(RelevantTestData$SubjectNo,RelevantTrainData$SubjectNo)
# Regardless, we add a factor column "SubjectGroup" containing the 
# levels "Test" and "Train" such that we may separate the data sets
# after combining them.

RelevantTestData$SubjectGroup  <- as.factor("Test")
RelevantTrainData$SubjectGroup  <- as.factor("Train")

CombinedData <- rbind(RelevantTestData,RelevantTrainData)

# Now for the somewhat tedious task of giving descriptive names
# to all variables:

TidyDataWide <- data.frame(
  "Subject.Number" = CombinedData$SubjectNo,
  "Subject.Group" = CombinedData$SubjectGroup,
  "Activity" = CombinedData$ActivityLabel,
  "Mean.of.body.acceleration.X.coordinate" = CombinedData[,"tBodyAcc-mean()-X"],
  "Mean.of.body.acceleration.Y.coordinate" = CombinedData[,"tBodyAcc-mean()-Y"],
  "Mean.of.body.acceleration.Z.coordinate" = CombinedData[,"tBodyAcc-mean()-Z"],
  "Std.dev..of.body.acceleration.X.coordinate" = CombinedData[,"tBodyAcc-std()-X"],
  "Std.dev..of.body.acceleration.Y.coordinate" = CombinedData[,"tBodyAcc-std()-Y"],
  "Std.dev..of.body.acceleration.Z.coordinate" = CombinedData[,"tBodyAcc-std()-Z"],
  "Mean.of.gravity.acceleration.X.coordinate" = CombinedData[,"tGravityAcc-mean()-X"],
  "Mean.of.gravity.acceleration.Y.coordinate" = CombinedData[,"tGravityAcc-mean()-Y"],
  "Mean.of.gravity.acceleration.Z.coordinate" = CombinedData[,"tGravityAcc-mean()-Z"],
  "Std.dev..of.gravity.acceleration.X.coordinate" = CombinedData[,"tGravityAcc-std()-X"],
  "Std.dev..of.gravity.acceleration.Y.coordinate" = CombinedData[,"tGravityAcc-std()-Y"],
  "Std.dev..of.gravity.acceleration.Z.coordinate" = CombinedData[,"tGravityAcc-std()-Z"],
  "Mean.of.body.acceleration.jerk.X.coordinate" = CombinedData[,"tBodyAccJerk-mean()-X"],
  "Mean.of.body.acceleration.jerk.Y.coordinate" = CombinedData[,"tBodyAccJerk-mean()-Y"],
  "Mean.of.body.acceleration.jerk.Z.coordinate" = CombinedData[,"tBodyAccJerk-mean()-Z"],
  "Std.dev..of.body.acceleration.jerk.X.coordinate" = CombinedData[,"tBodyAccJerk-std()-X"],
  "Std.dev..of.body.acceleration.jerk.Y.coordinate" = CombinedData[,"tBodyAccJerk-std()-Y"],
  "Std.dev..of.body.acceleration.jerk.Z.coordinate" = CombinedData[,"tBodyAccJerk-std()-Z"],
  "Mean.of.gyrometer.X.coordinate" = CombinedData[,"tBodyGyro-mean()-X"],
  "Mean.of.gyrometer.Y.coordinate" = CombinedData[,"tBodyGyro-mean()-Y"],
  "Mean.of.gyrometer.Z.coordinate" = CombinedData[,"tBodyGyro-mean()-Z"],
  "Std.dev..of.gyrometer.X.coordinate" = CombinedData[,"tBodyGyro-std()-X"],
  "Std.dev..of.gyrometer.Y.coordinate" = CombinedData[,"tBodyGyro-std()-Y"],
  "Std.dev..of.gyrometer.Z.coordinate" = CombinedData[,"tBodyGyro-std()-Z"],
  "Mean.of.gyrometer.jerk.X.coordinate" = CombinedData[,"tBodyGyroJerk-mean()-X"],
  "Mean.of.gyrometer.jerk.Y.coordinate" = CombinedData[,"tBodyGyroJerk-mean()-Y"],
  "Mean.of.gyrometer.jerk.Z.coordinate" = CombinedData[,"tBodyGyroJerk-mean()-Z"],
  "Std.dev..of.gyrometer.jerk.X.coordinate" = CombinedData[,"tBodyGyroJerk-std()-X"],
  "Std.dev..of.gyrometer.jerk.Y.coordinate" = CombinedData[,"tBodyGyroJerk-std()-Y"],
  "Std.dev..of.gyrometer.jerk.Z.coordinate" = CombinedData[,"tBodyGyroJerk-std()-Z"],
  "Mean.of.body.acceleration.magnitude" = CombinedData[,"tBodyAccMag-mean()"],
  "Std.dev..of.body.acceleration.magnitude" = CombinedData[,"tBodyAccMag-std()"],
  "Mean.of.gravity.acceleration.magnitude" = CombinedData[,"tGravityAccMag-mean()"],
  "Std.dev..of.gravity.acceleration.magnitude" = CombinedData[,"tGravityAccMag-std()"],
  "Mean.of.body.acceleration.jerk.magnitude" = CombinedData[,"tBodyAccJerkMag-mean()"],
  "Std.dev..of.body.acceleration.jerk.magnitude" = CombinedData[,"tBodyAccJerkMag-std()"],
  "Mean.of.gyrometer.magnitude" = CombinedData[,"tBodyGyroMag-mean()"],
  "Std.dev..of.gyrometer.magnitude" = CombinedData[,"tBodyGyroMag-std()"],
  "Mean.of.gyrometer.jerk.magnitude" = CombinedData[,"tBodyGyroJerkMag-mean()"],
  "Std.dev..of.gyrometer.jerk.magnitude" = CombinedData[,"tBodyGyroJerkMag-std()"],
  "Mean.of.body.acceleration.X.coordinate.in.frequency.domain" = CombinedData[,"fBodyAcc-mean()-X"],
  "Mean.of.body.acceleration.Y.coordinate.in.frequency.domain" = CombinedData[,"fBodyAcc-mean()-Y"],
  "Mean.of.body.acceleration.Z.coordinate.in.frequency.domain" = CombinedData[,"fBodyAcc-mean()-Z"],
  "Std.dev..of.body.acceleration.X.coordinate.in.frequency.domain" = CombinedData[,"fBodyAcc-std()-X"],
  "Std.dev..of.body.acceleration.Y.coordinate.in.frequency.domain" = CombinedData[,"fBodyAcc-std()-Y"],
  "Std.dev..of.body.acceleration.Z.coordinate.in.frequency.domain" = CombinedData[,"fBodyAcc-std()-Z"],
  "Mean.of.body.acceleration.jerk.X.coordinate.in.frequency.domain" = CombinedData[,"fBodyAccJerk-mean()-X"],
  "Mean.of.body.acceleration.jerk.Y.coordinate.in.frequency.domain" = CombinedData[,"fBodyAccJerk-mean()-Y"],
  "Mean.of.body.acceleration.jerk.Z.coordinate.in.frequency.domain" = CombinedData[,"fBodyAccJerk-mean()-Z"],
  "Std.dev..of.body.acceleration.jerk.X.coordinate.in.frequency.domain" = CombinedData[,"fBodyAccJerk-std()-X"],
  "Std.dev..of.body.acceleration.jerk.Y.coordinate.in.frequency.domain" = CombinedData[,"fBodyAccJerk-std()-Y"],
  "Std.dev..of.body.acceleration.jerk.Z.coordinate.in.frequency.domain" = CombinedData[,"fBodyAccJerk-std()-Z"],
  "Mean.of.gyrometer.X.coordinate.in.frequency.domain" = CombinedData[,"fBodyGyro-mean()-X"],
  "Mean.of.gyrometer.Y.coordinate.in.frequency.domain" = CombinedData[,"fBodyGyro-mean()-Y"],
  "Mean.of.gyrometer.Z.coordinate.in.frequency.domain" = CombinedData[,"fBodyGyro-mean()-Z"],
  "Std.dev..of.gyrometer.X.coordinate.in.frequency.domain" = CombinedData[,"fBodyGyro-std()-X"],
  "Std.dev..of.gyrometer.Y.coordinate.in.frequency.domain" = CombinedData[,"fBodyGyro-std()-Y"],
  "Std.dev..of.gyrometer.Z.coordinate.in.frequency.domain" = CombinedData[,"fBodyGyro-std()-Z"],
  "Mean.of.body.acceleration.magnitude.in.frequency.domain" = CombinedData[,"fBodyAccMag-mean()"],
  "Std.dev..of.body.acceleration.magnitude.in.frequency.domain" = CombinedData[,"fBodyAccMag-std()"],
  "Mean.of.body.acceleration.jerk.magnitude.in.frequency.domain" = CombinedData[,"fBodyBodyAccJerkMag-mean()"],
  "Std.dev..of.body.acceleration.jerk.magnitude.in.frequency.domain" = CombinedData[,"fBodyBodyAccJerkMag-std()"],
  "Mean.of.gyrometer.magnitude.in.frequency.domain" = CombinedData[,"fBodyBodyGyroMag-mean()"],
  "Std.dev..of.gyrometer.magnitude.in.frequency.domain" = CombinedData[,"fBodyBodyGyroMag-std()"],
  "Mean.of.gyrometer.jerk.magnitude.in.frequency.domain" = CombinedData[,"fBodyBodyGyroJerkMag-mean()"],
  "Std.dev..of.gyrometer.jerk.magnitude.in.frequency.domain" = CombinedData[,"fBodyBodyGyroJerkMag-std()"]
  )

# Now we save the tidy data to a file called: "TidyDataWide.txt"
write.table(TidyDataWide,file="TidyDataWide.txt")

# Finally, to easily produce the summarized data we convert the tidy data set
# from "wide form" to "long form" using the melt function from the reshape2 library.

library(reshape2)

TidyDataLong <- melt(TidyDataWide, id = c("Subject.Number", "Subject.Group", "Activity"),
                     measure.vars=c("Mean.of.body.acceleration.X.coordinate",
                                    "Mean.of.body.acceleration.Y.coordinate",
                                    "Mean.of.body.acceleration.Z.coordinate",
                                    "Std.dev..of.body.acceleration.X.coordinate",
                                    "Std.dev..of.body.acceleration.Y.coordinate",
                                    "Std.dev..of.body.acceleration.Z.coordinate",
                                    "Mean.of.gravity.acceleration.X.coordinate",
                                    "Mean.of.gravity.acceleration.Y.coordinate",
                                    "Mean.of.gravity.acceleration.Z.coordinate",
                                    "Std.dev..of.gravity.acceleration.X.coordinate",
                                    "Std.dev..of.gravity.acceleration.Y.coordinate",
                                    "Std.dev..of.gravity.acceleration.Z.coordinate",
                                    "Mean.of.body.acceleration.jerk.X.coordinate",
                                    "Mean.of.body.acceleration.jerk.Y.coordinate",
                                    "Mean.of.body.acceleration.jerk.Z.coordinate",
                                    "Std.dev..of.body.acceleration.jerk.X.coordinate",
                                    "Std.dev..of.body.acceleration.jerk.Y.coordinate",
                                    "Std.dev..of.body.acceleration.jerk.Z.coordinate",
                                    "Mean.of.gyrometer.X.coordinate",
                                    "Mean.of.gyrometer.Y.coordinate",
                                    "Mean.of.gyrometer.Z.coordinate",
                                    "Std.dev..of.gyrometer.X.coordinate",
                                    "Std.dev..of.gyrometer.Y.coordinate",
                                    "Std.dev..of.gyrometer.Z.coordinate",
                                    "Mean.of.gyrometer.jerk.X.coordinate",
                                    "Mean.of.gyrometer.jerk.Y.coordinate",
                                    "Mean.of.gyrometer.jerk.Z.coordinate",
                                    "Std.dev..of.gyrometer.jerk.X.coordinate",
                                    "Std.dev..of.gyrometer.jerk.Y.coordinate",
                                    "Std.dev..of.gyrometer.jerk.Z.coordinate",
                                    "Mean.of.body.acceleration.magnitude",
                                    "Std.dev..of.body.acceleration.magnitude",
                                    "Mean.of.gravity.acceleration.magnitude",
                                    "Std.dev..of.gravity.acceleration.magnitude",
                                    "Mean.of.body.acceleration.jerk.magnitude",
                                    "Std.dev..of.body.acceleration.jerk.magnitude",
                                    "Mean.of.gyrometer.magnitude",
                                    "Std.dev..of.gyrometer.magnitude",
                                    "Mean.of.gyrometer.jerk.magnitude",
                                    "Std.dev..of.gyrometer.jerk.magnitude",
                                    "Mean.of.body.acceleration.X.coordinate.in.frequency.domain",
                                    "Mean.of.body.acceleration.Y.coordinate.in.frequency.domain",
                                    "Mean.of.body.acceleration.Z.coordinate.in.frequency.domain",
                                    "Std.dev..of.body.acceleration.X.coordinate.in.frequency.domain",
                                    "Std.dev..of.body.acceleration.Y.coordinate.in.frequency.domain",
                                    "Std.dev..of.body.acceleration.Z.coordinate.in.frequency.domain",
                                    "Mean.of.body.acceleration.jerk.X.coordinate.in.frequency.domain",
                                    "Mean.of.body.acceleration.jerk.Y.coordinate.in.frequency.domain",
                                    "Mean.of.body.acceleration.jerk.Z.coordinate.in.frequency.domain",
                                    "Std.dev..of.body.acceleration.jerk.X.coordinate.in.frequency.domain",
                                    "Std.dev..of.body.acceleration.jerk.Y.coordinate.in.frequency.domain",
                                    "Std.dev..of.body.acceleration.jerk.Z.coordinate.in.frequency.domain",
                                    "Mean.of.gyrometer.X.coordinate.in.frequency.domain",
                                    "Mean.of.gyrometer.Y.coordinate.in.frequency.domain",
                                    "Mean.of.gyrometer.Z.coordinate.in.frequency.domain",
                                    "Std.dev..of.gyrometer.X.coordinate.in.frequency.domain",
                                    "Std.dev..of.gyrometer.Y.coordinate.in.frequency.domain",
                                    "Std.dev..of.gyrometer.Z.coordinate.in.frequency.domain",
                                    "Mean.of.body.acceleration.magnitude.in.frequency.domain",
                                    "Std.dev..of.body.acceleration.magnitude.in.frequency.domain",
                                    "Mean.of.body.acceleration.jerk.magnitude.in.frequency.domain",
                                    "Std.dev..of.body.acceleration.jerk.magnitude.in.frequency.domain",
                                    "Mean.of.gyrometer.magnitude.in.frequency.domain",
                                    "Std.dev..of.gyrometer.magnitude.in.frequency.domain",
                                    "Mean.of.gyrometer.jerk.magnitude.in.frequency.domain",
                                    "Std.dev..of.gyrometer.jerk.magnitude.in.frequency.domain"))

# Now with ddply from the plyr library the summary data set is easily produced.
library(plyr)

TidyDataSummaryLong <- ddply(TidyDataLong,c("Subject.Number", "Activity", "variable"), summarise, AverageValue = mean(value))

# Similarly, we save this data set:
write.table(TidyDataSummaryLong,file="TidyDataSummaryLong.txt")
