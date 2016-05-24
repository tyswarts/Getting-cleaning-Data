Codebook/Read Me

#Section 1: Get all the DATA!
#In section 1 the WD is set and each of the CSV files are read into R and saved as variables associated
#with their names. 
#This is done first for the subject data.
Variables:
body_acc_x_train= csv "body_acc_x_train.txt"
body_acc_y_train= csv "body_acc_y_train.txt"
body_acc_z_train= csv "body_acc_z_train.txt"
body_gyro_x_train= csv "body_gyro_x_train.txt"
body_gyro_y_train= csv "body_gyro_y_train.txt"
body_gyro_z_train= csv "body_gyro_z_train.txt"
total_acc_x_train= csv "total_acc_x_train.txt"
total_acc_y_train= csv "total_acc_y_train.txt"
total_acc_z_train= csv "total_acc_z_train.txt"
X_train= csv "X_train.txt"
y_train= csv "y_train.txt"
subject_train= csv "subject_train.txt"
features= csv "features.txt"
totalTR = combined data of subject, y test, and X test for the Training data

#Section 2: reshape and merge data
#The features variable is used for the column names that will describe the date.Finally the subject and
#test columns are bound to the data and given names.
#This process is repeated for the test data.
#(Answers #1) Finally the two data sets are bound along the rows in the variable "tot"

Variables:
X_test= csv "X_test.txt"
y_test= csv "y_test.txt"
subject_test= csv "subject_test.txt"
totalTE = combined data of subject, y test, and X test for the Test data
tot = combined TotalTE and TotalTR

#Section 3: 
#Answer #2 & #4. Extracts only the measurements on the mean and standard deviation for each measurement.
#NamesmeanSTD is used to hold only the column names in the "tot" which contain, mean, std, test, or subject.
#This is then used to filter out only these columns in tot and is called meanSTD.

Variables:
namesmeanSTD<-Names of columns with mean,std, test or subject
meanSTD<- filtered tot by namesmeanSTD

#Section 4
#Answers3. Uses descriptive activity names to name the activities in the data set 
#the replace function is used to replace the test values of 1:6 with their associated values found in the activity
label text. 

#Section 5
#Answers #5. From the data set in step 4, creates a second, 
#independent tidy data set with the average of 
#each variable for each activity and each subject.

#Two seperate loops are created for both test type and subject, the split function is used on MeanSTD
#by both test and subject. these values are then summed, counted, and divided giving the average for each
value. This information is then built into the data fram totalAVTest and TotalAVSubject with appropriate names
given for rows and columns. 

Variables:
names<-names in meanSTD
totalAVTest<- data frame used to hold all of the activities being built in loop for each test type
totalAVSubject<- data frame used to hold all of the activities being built in loop for each subject
Spmean<- Split meanSTD
sumsplit<- sum of each group
numbr<- number of rows for each group
avg<- average of each group
