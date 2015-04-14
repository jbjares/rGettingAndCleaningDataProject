# Getting and Cleaning Data Course Project

The Course Project uses data from this URL: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )  

To reproduce the steps described below, and to use the run_analysis.R file, you need to download the
above zip file, decompress the file, and have the run_analysis.R file in the top level folder of the unzipped 
package.  

The codebook for this project is available within this repository:
[https://github.com/jbjares/rGettingAndCleaningDataProject/blob/master/CodeBook.md](https://github.com/jbjares/rGettingAndCleaningDataProject/blob/master/CodeBook.md) 

## Overall Process

The five essential tasks to complete the Course Project are as follows.

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. Creates a second, independent tidy data set with the average of each
    variable for each activity and each subject.

These five steps will be accomplished via the process described below. Readers should also
examine the codebook, and the full comments in the run_analysis.R file.

### 1. Merge training and test sets to create one data set.



```
GettingCleaningDataCourseProject$mergesTheTrainingAndTheTestSetsToCreateOneDataSet()
```

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 
```
GettingCleaningDataCourseProject$extractsOnlyTheMeasurementsOnTheMeanAndStandardDeviationForEachMeasurement()
```

### 3. Uses descriptive activity names to name the activities in the data set.


```
GettingCleaningDataCourseProject$usesDescriptiveActivityNamesToNameTheActivitiesInTheDataSet()
```

### 4. Appropriately label the data set with descriptive variable names. 

```
GettingCleaningDataCourseProject$appropriatelyLabelTheDataSetWithDescriptiveVariableNames()
```


### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


```
GettingCleaningDataCourseProject$createsSecondIndependentTidyDataSetWithAverageEach()
```




