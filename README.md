# Wearables_DataCleaning

This repository contains code to analyze the Human Activity Recognition Using Smartphones Dataset (Version 1.0). The R script `run_analysis.R` does the following :

1.  Reads in both the training and testing datasets.
2.  Reads in column labels for the datasets and renames columns based on those labels.
3.  Reads in supporting datasets, including activity labels and subject numbers for both the training and testing datasets and merges those columns with the training and testing datasets.
3.  Joins the training and testing datasets.
4.  Selects only columns with mean and standard deviation values.
5. Converts activity numbers to activity names
6. Creates a summary dataset with average of each variable for each activity and each subject.
7. Writes the summary dataset to file. 
