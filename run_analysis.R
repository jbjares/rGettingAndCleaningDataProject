x_data_set <- NULL
y_data_set <- NULL
subject_data_set <- NULL
destfileVar <- "dataset.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  



##TODO: Try it create this vars in other scope more generic to do the caching
if(is.null(x_train_table) &&
     is.null(y_train_table) &&
     length(subject_train_table) &&
     is.null(x_test_table) &&
     is.null(y_test_table) &&
     is.null(subject_test_table)){
  x_train_table <- NULL
  y_train_table <- NULL
  subject_train_table <- NULL
  x_test_table <- NULL
  y_test_table <- NULL
  subject_test_table <- NULL
  
}

GettingCleaningDataCourseProject <- list(
  
  mergesTheTrainingAndTheTestSetsToCreateOneDataSet = function(){
    
      if(!file.exists(extractedFileName)){
        downloadedFile <- download.file(fileUrl, destfile = destfileVar)
        dateDownloaded <- date()
        #extractedFileName <-  paste(unzip(destfileVar)[1])
        extractedFileName <- "UCI HAR Dataset/activity_labels.txt"    
      }
      
    
    #TODO: hard coded numbers (1 and 18) must be refactored. 
    extractedFileBaseName <- substring(extractedFileName,1,18)
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
            x_train_table <- read.table(i)
          }
        }
        if(grepl("y",i)){
          if(is.null(y_train_table)){
            y_train_table <- read.table(i)
          }
        }
        if(grepl("subject",i)){
          if(is.null(subject_train_table)){
            subject_train_table <- read.table(i)
          }
          
        }
      }
      for(i in filesUnderTest){
        if(!grepl(".txt$",i)){
          next
        }
        if(grepl("X",i)){
          if(is.null(x_test_table)){
            x_test_table <- read.table(i)
          }
          
        }
        if(grepl("y",i)){
          if(is.null(y_test_table)){
            y_test_table <- read.table(i)
          }
        }
        if(grepl("subject",i)){
          if(is.null(subject_test_table)){
            subject_test_table <- read.table(i)  
          }
          
        }
      }
      
      return(
        
        list(
          getX = function(){
            x_data_set <- rbind(x_train_table,x_test_table)
            return(x_data_set)
          },
          
          getY = function(){
            y_data_set <- rbind(y_train_table,y_test_table)
            return(y_data_set)
          },
          
          getSubject = function(){
            subject_data_set <- rbind(subject_train_table,subject_test_table)
            return(subject_data_set)
          }
        )
        
      )
      
    },
  
  extractsOnlyTheMeasurementsOnTheMeanAndStandardDeviationForEachMeasurement = function(){
    print("owww")
  }
)

