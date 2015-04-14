if(!("stringr" %in% rownames(installed.packages()))){
  install.packages("stringr", dependencies=TRUE)  
}

require(stringr)
destfileVar <- "dataset.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  
extractedFileBaseName <- "UCI HAR Dataset";




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
    featurenames   <- read.table(paste0(extractedFileBaseName,"/features.txt"));
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
    library(reshape2)
    molten <- melt(activityData,id.vars=c("subject","activity"))
    tidy <- dcast(molten,subject + activity ~ variable,mean)
    write.table(tidy, "dataset2.txt", sep="\t")
  }
  
  
)

