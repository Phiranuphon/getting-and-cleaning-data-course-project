# Getting and Cleaning data course project
**This is a code book for tidying and analyzing data**

## Let's start with downloading the data
**download file and unzip**

>      url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
>      unzipfile<- tempfile()
>      download.file(url,unzipfile)
>      list.files <- unzip(unzipfile,list=TRUE)

**set directory to the unzipped folder**
>      setwd(dir()[1])

**Import all data**
>      Test.dataX<- read.table(list.files[17,1], header = FALSE)
>      Train.dataX<- read.table(list.files[31,1], header = FALSE)
>      Test.dataY<- read.table(list.files[18,1], header = FALSE)
>      Train.dataY<- read.table(list.files[32,1], header = FALSE)
>      Test.Subject<- read.table(list.files[16,1], header = FALSE)
>      Train.Subject<- read.table(list.files[30,1], header = FALSE)
**import Features **
>      Features <- read.table(list.files[2,1], header = FALSE)
**import Activity**
>      Activitylist <- read.table(list.files[1,1], header = FALSE)

## After importing all data needed, merging all file will make data way easier to be manipulated
**merge data X**
>      AllX<- rbind(Train.dataX,Test.dataX)
**merge Activity (data Y)**
>      AllActivity<- rbind(Train.dataY,Test.dataY)
**merge subject**
>      AllSubject<-rbind(Train.Subject,Test.Subject)

**Giving the column label** 
>      colnames(AllX) <- Features[,2]
>      colnames(AllActivity) <- "Activity"
>      colnames(AllSubject) <- "Subject"

**merge all data**
>      AllData<- cbind(AllX,AllActivity,AllSubject)

##select mean and std data
>      AllDataMeanSTD <- grep(".*Mean.*|.*Std.*", names(AllData), ignore.case=TRUE)

##Uses descriptive activity names to name the activities in the data set
>      Activitylist[,2]<- as.character(Activitylist[,2])
>      for(i in 1:6) AllData$Activity[AllData$Activity==i]<- Activitylist[i,2]

**Appropriately labels the data set with descriptive variable names.**
>      names(AllData) <- gsub("Acc", "Accelerator", names(AllData))
>      names(AllData) <- gsub("^t", "Time", names(AllData))
>      names(AllData) <- gsub("^f", "Frequency", names(AllData))
>      names(AllData) <- gsub("Mag", "Magnitude", names(AllData))
>      names(AllData) <- gsub("Gyro", "Gyroscope", names(AllData))

##From the data set in step 4, creates a second, independent tidy data (IndyData) set with the average of each variable for each activity and each subject.
>      AllData$Activity <- sapply(AllData$Activity,as.factor)#as.factor cannot be used directly
>      AllData$Subject <- sapply(AllData$Subject,as.factor)
>      IndyData<- aggregate(. ~Subject + Activity, AllData, mean)
>      write.table(IndyData, file = "IndyData.txt", row.names = FALSE)
