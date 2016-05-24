#Ty Swarts
#24 May 2016

#get all the DATA!
#-----------------------------------------------------------------------------------------------------------------
#Set wD to location of training data and read all files into Variables
setwd("C:/Users/tswarts/Documents/R/Cleaning Data Wk 4/Homework/UCI HAR Dataset/train/Inertial Signals")

body_acc_x_train<-read.csv("body_acc_x_train.txt",header = FALSE, sep = "")
body_acc_y_train<-read.csv("body_acc_y_train.txt",header = FALSE,sep = "")
body_acc_z_train<-read.csv("body_acc_z_train.txt",header = FALSE,sep = "")
body_gyro_x_train<-read.csv("body_gyro_x_train.txt",header = FALSE,sep = "")
body_gyro_y_train<-read.csv("body_gyro_y_train.txt",header = FALSE,sep = "")
body_gyro_z_train<-read.csv("body_gyro_z_train.txt",header = FALSE,sep = "")
total_acc_x_train<-read.csv("total_acc_x_train.txt",header = FALSE,sep = "")
total_acc_y_train<-read.csv("total_acc_y_train.txt",header = FALSE,sep = "")
total_acc_z_train<-read.csv("total_acc_z_train.txt",header = FALSE,sep = "")

#Set wD to location of training data and read all files into Variables
setwd("C:/Users/tswarts/Documents/R/Cleaning Data Wk 4/Homework/UCI HAR Dataset/train")
X_train<-read.csv("X_train.txt",header = FALSE,sep = "")
y_train<-read.csv("y_train.txt",header = FALSE,sep = "")
subject_train<-read.csv("subject_train.txt",header = FALSE,sep = "")

#Set wD to location of Feature data and read all files into Variables

setwd("C:/Users/tswarts/Documents/R/Cleaning Data Wk 4/Homework/UCI HAR Dataset")
features<-read.csv("features.txt",header = FALSE,sep = "")

#-----------------------------------------------------------------------------------------------------------------
#reshape and merge data

#1. Merges the training and the test sets to create one data set.

#get subject data prepped

#single out Column names
features<-features[,2]

#Name columns
names(X_train)<-features
#bind on subject numbers and test
totalTR<-cbind(subject_train,y_train, X_train)
colnames(totalTR)[1] <- "Subject"
colnames(totalTR)[2] <- "Test"
#and we have the first set for training data!

#----------------------------------------------------------------------------------------------
#get test Data
#Set wD to location of training data and read all files into Variables
setwd("C:/Users/tswarts/Documents/R/Cleaning Data Wk 4/Homework/UCI HAR Dataset/test")
X_test<-read.csv("X_test.txt",header = FALSE,sep = "")
y_test<-read.csv("y_test.txt",header = FALSE,sep = "")
subject_test<-read.csv("subject_test.txt",header = FALSE,sep = "")


#Get Test Data Prepped
#Name columns
names(X_test)<-features
#bind on subject numbers and test

totalTE<-cbind(subject_test,y_test, X_test)
colnames(totalTE)[1] <- "Subject"
colnames(totalTE)[2] <- "Test"

#and we have the first set for training data!

#-----------------------------------------------------------------------------------------------
#Combine the two data sets
tot<-rbind(totalTR,totalTE)
#-----------------------------------------------------------------------------------------------
#2. Extracts only the measurements on the mean and standard deviation for each measurement.


library(plyr)
namesmeanSTD<-grep(("mean|std|Test|Subject"),names(tot))
meanSTD<-tot[,namesmeanSTD]

#3. Uses descriptive activity names to name the activities in the data set
#Activity Labels:
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING
#Replace Activity labels
meanSTD$Test<-replace(meanSTD$Test, meanSTD$Test==1, "Walking")
meanSTD$Test<-replace(meanSTD$Test, meanSTD$Test==2, "Walking_Upstairs")
meanSTD$Test<-replace(meanSTD$Test, meanSTD$Test==3, "Walking_Downstairs")
meanSTD$Test<-replace(meanSTD$Test, meanSTD$Test==4, "Sitting")
meanSTD$Test<-replace(meanSTD$Test, meanSTD$Test==5, "Standing")
meanSTD$Test<-replace(meanSTD$Test, meanSTD$Test==6, "Laying")

library(tidyr) #tBodyAcc-mean()-X:fBodyBodyGyroJerkMag-meanFreq()
library(reshape2)

#---------------------------------------------------------------------------------------------------
#5. From the data set in step 4, creates a second, 
#independent tidy data set with the average of 
#each variable for each activity and each subject.

#loop counter
i<-3
#row name counter
j<-1
names<-names(meanSTD)
totalAVTest<-data.frame()

#build the Data frame around average for each test type
while (i <= length(names)) {
        
        Spmean=split(meanSTD[names[i]], meanSTD["Test"])
        sumsplit<-lapply(Spmean,sum)
        numbr<-lapply(Spmean,nrow) 
        avg<-mapply("/",sumsplit,numbr,SIMPLIFY = FALSE)
        avg<-as.data.frame(avg)
        totalAVTest<-rbind(totalAVTest, avg)
        #4. Appropriately labels the data set with descriptive variable names.
        rownames(totalAVTest)[j]<-names[i]
        i<-i+1
        j<-j+1
}
#----------------------------------------------------------------------------------------------
i<-3
#row name counter
j<-1
names<-names(meanSTD)
totalAVSubject<-data.frame()

#build the Data frame around average for each Subject
while (i <= length(names)) {
        #split the data into each subject
        Spmean=split(meanSTD[names[i]], meanSTD["Subject"])
        #get the average for each subject
        sumsplit<-lapply(Spmean,sum)
        numbr<-lapply(Spmean,nrow) 
        avg<-mapply("/",sumsplit,numbr,SIMPLIFY = FALSE)
        avg<-as.data.frame(avg)
        #build into new Data frame
        totalAVSubject<-rbind(totalAVSubject, avg)
        #4. Appropriately labels the data set with descriptive variable names.
        rownames(totalAVSubject)[j]<-names[i]
        #counters
        i<-i+1
        j<-j+1
}
colnames(totalAVSubject)<-paste("Subject",1:30)
#Print out Tidy Data Sets
setwd("C:/Users/tswarts/Desktop")
write.csv(totalAVTest, "AVTest.csv")
write.csv(totalAVSubject, "AVSubject.csv")
#----------------------------------------------------------------------------------------------
#END
