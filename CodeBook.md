Introduction

The script run_analysis.r does the following:

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names.
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The Original Dataset

The original data set is split into training and test sets; where each set type is also split into three files that contain:

    1. Measurements from the accelerometer and gyroscope
    2. Activity labels
    3. Identifier of the subject

Getting and Cleaning the Data

Before you get going, ensure that the DPLYR and PLYR packages are installed. This is because the DPLYR, PLYR and STRINGR libraries will be required for this script.

The Data can be downloaded directly from the UCI repository (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The Tidying up process goes as follows:

    1. The X sets of the data are read in and combined by rows; as are the Y and Subject sets of the data.
    2. The merged X and the merged Y data are then combine by columns. Then followed by the merged Subject data.
    3. The Features table is read in and used to isolate columns with Mean and Std Deviation data in combined dataset.
    4. Meaningful names for the activities are given to replace the number codes
    5. The Variable Names are changed to give meaning to the abbreviations.

Finally the tidied data is written to a CSV file.