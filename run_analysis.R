if(!("stringr" %in% rownames(installed.packages()))){
  install.packages("stringr", dependencies=TRUE)  
}

require(stringr)
destfileVar <- "dataset.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  
extractedFileBaseName <- "UCI HAR Dataset";



if(!exists("featurenames")){
  featurenames <- NULL
}
if(!exists("activity")){
  activity <- NULL
}
if(!exists("subject")){
  subject <- NULL
}
if(!exists("meansfeatures")){
  meansfeatures <- NULL
}
if(!exists("activityData")){
  activityData <- NULL
}
if(!exists("x_data_set")){
  x_data_set <- NULL
}
if(!exists("y_data_set")){
  y_data_set <- NULL
}
if(!exists("subject_data_set")){
  subject_data_set <- NULL
}
if(!exists("x_train_table")){
  x_train_table <- NULL
}
if(!exists("y_train_table")){
  y_train_table <- NULL
}
if(!exists("subject_train_table")){
  subject_train_table <- NULL
}
if(!exists("x_test_table")){
  x_test_table <- NULL
}
if(!exists("y_test_table")){
  y_test_table <- NULL
}
if(!exists("subject_test_table")){
  subject_test_table <- NULL
}
if(!exists("x_data_set")){
  x_data_set <- NULL
}
if(!exists("y_data_set")){
  y_data_set <- NULL
}
if(!exists("subject_data_set")){
  subject_data_set <- NULL
}



GettingCleaningDataCourseProject <- list(
  
  mergesTheTrainingAndTheTestSetsToCreateOneDataSet = function(){
    
    if(!file.exists(extractedFileBaseName)){
      downloadedFile <- download.file(fileUrl, destfile = destfileVar)
      dateDownloaded <- date()         
      unzip(destfileVar)
    }
    
    firstLevelFolder <- list.dirs(path = extractedFileBaseName, full.names = TRUE, recursive = TRUE)
    
    #TODO: hard coded numbers (2 and 4) must be refactored. 
    testFolder <- firstLevelFolder[2]
    trainFolder <- firstLevelFolder[4]
    
    filesUnderTest <- list.files(path=paste(testFolder), pattern="*.*", full.names=T, recursive=F)
    filesUnderTrain <- list.files(path=paste(trainFolder), pattern="*.*", full.names=T, recursive=F)
    
      
      
      
      ##TODO: Try change this lot of ifelse for a switch statement
      for(i in filesUnderTrain){
        if(!grepl(".txt$",i)){
          next
        }
        if(grepl("X",i)){
          if(is.null(x_train_table)){
            x_train_table <<- read.table(i)
          }
        }
        if(grepl("y",i)){
          if(is.null(y_train_table)){
            y_train_table <<- read.table(i)
          }
        }
        if(grepl("subject",i)){
          if(is.null(subject_train_table)){
            subject_train_table <<- read.table(i)
          }
          
        }
      }
      for(i in filesUnderTest){
        if(!grepl(".txt$",i)){
          next
        }
        if(grepl("X",i)){
          if(is.null(x_test_table)){
            x_test_table <<- read.table(i)
          }
          
        }
        if(grepl("y",i)){
          if(is.null(y_test_table)){
            y_test_table <<- read.table(i)
          }
        }
        if(grepl("subject",i)){
          if(is.null(subject_test_table)){
            subject_test_table <<- read.table(i)  
          }
          
        }
      }
      
      x_data_set <<- rbind(x_train_table,x_test_table)
      y_data_set <<- rbind(y_train_table,y_test_table)
      subject_data_set <<- rbind(subject_train_table,subject_test_table)
      
    },
  
  extractsOnlyTheMeasurementsOnTheMeanAndStandardDeviationForEachMeasurement = function(){
    if(is.null(featurenames)){
      featurenames   <<- read.table(paste0(extractedFileBaseName,"/features.txt"));
    }
    if(is.null(activityData)){
      meansfeatures  <<- grepl("(-std\\(\\)|-mean\\(\\))",featurenames$V2)    
    }
    activityData <- x_data_set[, which(meansfeatures == TRUE)]
  },
  
  usesDescriptiveActivityNamesToNameTheActivitiesInTheDataSet = function(){
    activityLabels  <- read.table(paste0(extractedFileBaseName,"/activity_labels.txt"));
    if(is.null(activity)){
      activity <<- as.factor(y_data_set$V1)
    }
    levels(activity) <- activityLabels$V2
    if(is.null(activityData)){
      subject <<- as.factor(subject_data_set$V1)
    }
    if(is.null(activityData)){
      activityData <<- cbind(subject,activity,activityData)    
    }
  },
  
  appropriatelyLabelTheDataSetWithDescriptiveVariableNames = function(){
    filteredfeatures <- (cbind(featurenames,meansfeatures)[meansfeatures==TRUE,])$V2
    cleaner <- function(featurename) {
      tolower(gsub("(\\(|\\)|\\-)","",featurename))
    }
    filteredfeatures <- sapply(filteredfeatures,cleaner)
    names(activityData)[3:ncol(activityData)] <- filteredfeatures
    write.csv(activityData,file="dataset1.csv")
    write.table(activityData, "dataset1.txt", sep="\t")
    
  },
  
  createsSecondIndependentTidyDataSetWithAverageEach = function(){
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))
    subject <- rbind(subject_test, subject_train)
    averages <- aggregate(x_data_set, by = list(activity = y_data_set[,1], subject = subject[,1]), mean)
    write.csv(averages, file='result.txt', row.names=FALSE)
  }
  
  
)

#1 - Merges the training and the test sets to create one data set.
GettingCleaningDataCourseProject$mergesTheTrainingAndTheTestSetsToCreateOneDataSet()

#2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
GettingCleaningDataCourseProject$extractsOnlyTheMeasurementsOnTheMeanAndStandardDeviationForEachMeasurement()

#3 - Uses descriptive activity names to name the activities in the data set
GettingCleaningDataCourseProject$usesDescriptiveActivityNamesToNameTheActivitiesInTheDataSet()

#4 - Appropriately labels the data set with descriptive variable names. 
GettingCleaningDataCourseProject$appropriatelyLabelTheDataSetWithDescriptiveVariableNames()

#5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
GettingCleaningDataCourseProject$createsSecondIndependentTidyDataSetWithAverageEach()

