Code Book for Getting and Cleaning Data Course Project
==============
The code in run_analysis.R processes the supplied "Samsung Data"number  source data.  

The source data comes with its own data description.  

It is presumed that both the code and the data is in R's current working directory.  

The code requires the libraries "plyr" and "reshape2".

The following is done:
* Only the features containing mean values or standard deviations are kept (cf. table below).
* The activity-identifying numbers (in `Y_test.txt` & `Y_train.txt`) are mapped to the supplied descriptive labels (in `activity_labels.txt`).
* A new column "Subject Group" is added identifying whether the subject is in the "Train" or in the "Test" group.
* The two data sets are added into one tidy data set with descriptive column names (cf. table below). This data set is in the "wide form", which is natural when each observation contains one instance of each variable.
* This data set is output in text/table format to a file named `TidyDataWide.txt`.
* Average values of each variable are computed for each combination of "Subject Number" and "Activity". This summarised data set is in the "long form".
* This



|Source Data Dimension|Descriptive Name in output|  
|-------|---------|  
|Activity Label|Activity|  
|Subject|Subject Number|  

|Source Data Feature Label |Descriptive Name in output|  
|-------|---------|  
|tBodyAcc-mean()-X	|Mean of body acceleration X-coordinate|  
|tBodyAcc-mean()-Y	|Mean of body acceleration Y-coordinate|  
|tBodyAcc-mean()-Z	|Mean of body acceleration Z-coordinate|  
|tBodyAcc-std()-X	|Std.dev. of body acceleration X-coordinate|  
|tBodyAcc-std()-Y	|Std.dev. of body acceleration Y-coordinate|  
|tBodyAcc-std()-Z	|Std.dev. of body acceleration Z-coordinate|  
|tGravityAcc-mean()-X	|Mean of gravity acceleration X-coordinate|  
|tGravityAcc-mean()-Y	|Mean of gravity acceleration Y-coordinate|  
|tGravityAcc-mean()-Z	|Mean of gravity acceleration Z-coordinate|  
|tGravityAcc-std()-X	|Std.dev. of gravity acceleration X-coordinate|  
|tGravityAcc-std()-Y	|Std.dev. of gravity acceleration Y-coordinate|  
|tGravityAcc-std()-Z	|Std.dev. of gravity acceleration Z-coordinate|  
|tBodyAccJerk-mean()-X	|Mean of body acceleration jerk X-coordinate|  
|tBodyAccJerk-mean()-Y	|Mean of body acceleration jerk Y-coordinate|  
|tBodyAccJerk-mean()-Z	|Mean of body acceleration jerk Z-coordinate|  
|tBodyAccJerk-std()-X	|Std.dev. of body acceleration jerk X-coordinate|  
|tBodyAccJerk-std()-Y	|Std.dev. of body acceleration jerk Y-coordinate|  
|tBodyAccJerk-std()-Z	|Std.dev. of body acceleration jerk Z-coordinate|  
|tBodyGyro-mean()-X	|Mean of gyrometer X-coordinate|  
|tBodyGyro-mean()-Y	|Mean of gyrometer Y-coordinate|  
|tBodyGyro-mean()-Z	|Mean of gyrometer Z-coordinate|  
|tBodyGyro-std()-X	|Std.dev. of gyrometer X-coordinate|  
|tBodyGyro-std()-Y	|Std.dev. of gyrometer Y-coordinate|  
|tBodyGyro-std()-Z	|Std.dev. of gyrometer Z-coordinate|  
|tBodyGyroJerk-mean()-X	|Mean of gyrometer jerk X-coordinate|  
|tBodyGyroJerk-mean()-Y	|Mean of gyrometer jerk Y-coordinate|  
|tBodyGyroJerk-mean()-Z	|Mean of gyrometer jerk Z-coordinate|  
|tBodyGyroJerk-std()-X	|Std.dev. of gyrometer jerk X-coordinate|  
|tBodyGyroJerk-std()-Y	|Std.dev. of gyrometer jerk Y-coordinate|  
|tBodyGyroJerk-std()-Z	|Std.dev. of gyrometer jerk Z-coordinate|  
|tBodyAccMag-mean()	|Mean of body acceleration magnitude|  
|tBodyAccMag-std()	|Std.dev. of body acceleration magnitude|  
|tGravityAccMag-mean()	|Mean of gravity acceleration magnitude|  
|tGravityAccMag-std()	|Std.dev. of gravity acceleration magnitude|  
|tBodyAccJerkMag-mean()	|Mean of body acceleration jerk magnitude|  
|tBodyAccJerkMag-std()	|Std.dev. of body acceleration jerk magnitude|  
|tBodyGyroMag-mean()	|Mean of gyrometer magnitude|  
|tBodyGyroMag-std()	|Std.dev. of gyrometer magnitude|  
|tBodyGyroJerkMag-mean()	|Mean of gyrometer jerk magnitude|  
|tBodyGyroJerkMag-std()	|Std.dev. of gyrometer jerk magnitude|  
|fBodyAcc-mean()-X	|Mean of body acceleration X-coordinate in frequency domain|  
|fBodyAcc-mean()-Y	|Mean of body acceleration Y-coordinate in frequency domain|  
|fBodyAcc-mean()-Z	|Mean of body acceleration Z-coordinate in frequency domain|  
|fBodyAcc-std()-X	|Std.dev. of body acceleration X-coordinate in frequency domain|  
|fBodyAcc-std()-Y	|Std.dev. of body acceleration Y-coordinate in frequency domain|  
|fBodyAcc-std()-Z	|Std.dev. of body acceleration Z-coordinate in frequency domain|  
|fBodyAccJerk-mean()-X	|Mean of body acceleration jerk X-coordinate in frequency domain|  
|fBodyAccJerk-mean()-Y	|Mean of body acceleration jerk Y-coordinate in frequency domain|  
|fBodyAccJerk-mean()-Z	|Mean of body acceleration jerk Z-coordinate in frequency domain|  
|fBodyAccJerk-std()-X	|Std.dev. of body acceleration jerk X-coordinate in frequency domain|  
|fBodyAccJerk-std()-Y	|Std.dev. of body acceleration jerk Y-coordinate in frequency domain|  
|fBodyAccJerk-std()-Z	|Std.dev. of body acceleration jerk Z-coordinate in frequency domain|  
|fBodyGyro-mean()-X	|Mean of gyrometer X-coordinate in frequency domain|  
|fBodyGyro-mean()-Y	|Mean of gyrometer Y-coordinate in frequency domain|  
|fBodyGyro-mean()-Z	|Mean of gyrometer Z-coordinate in frequency domain|  
|fBodyGyro-std()-X	|Std.dev. of gyrometer X-coordinate in frequency domain|  
|fBodyGyro-std()-Y	|Std.dev. of gyrometer Y-coordinate in frequency domain|  
|fBodyGyro-std()-Z	|Std.dev. of gyrometer Z-coordinate in frequency domain|  
|fBodyAccMag-mean()	|Mean of body acceleration magnitude in frequency domain|  
|fBodyAccMag-std()	|Std.dev. of body acceleration magnitude in frequency domain|  
|fBodyBodyAccJerkMag-mean()	|Mean of body acceleration jerk magnitude in frequency domain|  
|fBodyBodyAccJerkMag-std()	|Std.dev. of body acceleration jerk magnitude in frequency domain|  
|fBodyBodyGyroMag-mean()	|Mean of gyrometer magnitude in frequency domain|  
|fBodyBodyGyroMag-std()	|Std.dev. of gyrometer magnitude in frequency domain|  
|fBodyBodyGyroJerkMag-mean()	|Mean of gyrometer jerk magnitude in frequency domain|  
|fBodyBodyGyroJerkMag-std()	|Std.dev. of gyrometer jerk magnitude in frequency domain|  
