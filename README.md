Coursera-getdata-004-Project
============================

This repo contains script and code book for the Course Project of Getting and Cleaning Data Coursera course (getdata-004).  

The code in `run_analysis.R` processes the supplied "Samsung Data" source data producing two tidy data sets with descriptive variable names.  

The script as well as the unzipped source data must be in R's current working directory before running it (with `source(run_analysis.R)`).

The code requires the R libraries "plyr" and "reshape2".

The following is done:
* Only the features containing mean values or standard deviations are kept (cf. code book).
* The activity-identifying numbers (in `Y_test.txt` & `Y_train.txt`) are mapped to the supplied descriptive labels (in `activity_labels.txt`).
* A new column "Subject Group" is added identifying whether the subject is in the "Train" or in the "Test" group.
* The two data sets are added into one tidy data set with descriptive column names (cf. code book). This data set is in the "wide form", which is natural when each observation contains one instance of each variable.
* This data set is output in text/table format to a file named `TidyDataWide.txt`.
* Average values of each variable are computed for each combination of "Subject Number" and "Activity". This summarised data set is in the "long form" (where each value has its own row).
* This data set is output in text/table format to a file named `TidyDataSummaryLong.txt`.
