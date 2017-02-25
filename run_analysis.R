library(dplyr)

#Getting the working directory
wd<-getwd()
if (!file.exists("./UCI HAR Dataset")){stop(message("UCI HAR Dataset folder not found!!!"))}
#Storing the unzipped folder path 
wd2<-paste0(wd,"/UCI HAR Dataset")

#reading activity numbers and their labels in the 'activity_labels'
act_lab<-read.table(paste0(wd2,"/activity_labels.txt"))
#Adding a column to the activity label with a shortened but still comprehendable form of the activity
act_lab<-cbind(act_lab,"Act_short"=c("Walk","Walk_up","Walk_down","Sit","Stand","Lay"))

#reading the variable names from the 'features' table into 'features' dataframe
features<-read.table(paste0(wd2,"/features.txt"))
#storing the variable names as vector in 'feat' object to be used in the datasets
feat<-as.vector(features$V2)

#Storing a new path pointing to the 'train' folder of the unzipped folder
wd1<-paste0(wd2,"/train/")
#---------------------------------------------------------------------------------------------------------------------

#reading the computed data in 'X_train' into 'train' data frame
train<-read.table(paste0(wd1,"X_train.txt"))
#changing variable names from 'V1,V2...' to its descriptive form from 'feat' vector
names(train)<-feat

#reading the activity data in 'y_train' into 'activity_train' data frame
activity_train<-read.table(paste0(wd1,"y_train.txt"))
#Addign a new column 'Act_desc' to the activity dataframe which describes the activity undertaken by joining the activity
#number to its descriptive form from 'act_label' dataframe
activity_train<-activity_train%>%mutate(Act_desc=act_lab[V1,3])
#reading the subject number data in 'subject_train' into 'subject_train' data frame
subject_train<-read.table(paste0(wd1,"subject_train.txt"))
#Creating a new column 'sub_desc' to designate a name for the subject instead of mere number
subject_train<-subject_train%>%mutate(sub_desc=paste0("Subject",V1))

#putting together the subject description from 'subject_train' df, activity description from 'activity_train' df, a new
# column 'Dataset' to show if it is a test or train set and the measurements
train<-cbind("Dataset"="Train","Subject"=subject_train$sub_desc,"Activity"=activity_train$Act_desc,train)
#This concludes the operations on the train data. The same steps need to be done on test data as well
#---------------------------------------------------------------------------------------------------------------------
#Storing the 'test' folder pathway
wd3<-paste0(wd2,"/test/")

#reading the computed measruements of the test data from 'X_test' into 'test' data frame
test<-read.table(paste0(wd3,"X_test.txt"))
#changing variable names from 'V1,V2...' to its descriptive form from 'feat' vector
names(test)<-feat

#reading the activity data from 'y_test' into 'activity_test' data frame
activity_test<-read.table(paste0(wd3,"y_test.txt"))
#Addign a new column 'Act_desc' to the activity dataframe which describes the activity undertaken by joining the activity
#number to its descriptive form from 'act_label' datafrme
activity_test<-activity_test%>%mutate(Act_desc=act_lab[V1,3])

#reading the subject number data in 'subject_test' into 'subject_test' data frame
subject_test<-read.table(paste0(wd3,"subject_test.txt"))
#Creating a new column 'sub_desc' to designate a name for the subject instead of mere number
subject_test<-subject_test%>%mutate(sub_desc=paste0("Subject",V1))

#putting together the subject description from 'subject_test' df, activity description from 'activity_test' df, a new
# column 'Dataset' to show if it is a test or train set and the measurements
test<-cbind("Dataset"="Test","Subject"=subject_test$sub_desc,"Activity"=activity_test$Act_desc,test)
#---------------------------------------------------------------------------------------------------------------------

##Step1:
#Combining the 'train' data frame and 'test' data frame into a new dataframe called 'full_set'
full_set<-rbind(train,test)

##Step2:
#Extracting the mean and std measruement data alone from the 'full_set' data frame into a new data frame called 
#'data_subset_mean'. Variables with mean (or Mean) or std (or Std) in their names are chosen as long as it is not an 
#angle measurment (involving a mean parameter).
data_subset_mean<-full_set[,which((grepl("Dataset|Subject|Activity|*[Mm]ean*|*[Ss]td*",names(full_set))) & 
                                 (!grepl("angle",names(full_set))))]

##Step5:
#Taking average of all 79 measurement variables for each subject and for each activity into a dataframe 
#'mean_data_subset'. Select function removes the dataset variable to avoid errors and is alos irrelevant 
#for this exercise
mean_data_subset<-data_subset_mean%>%select(-Dataset)%>%group_by(Subject,Activity)%>%summarise_each(funs(mean))
#changing the column names to reflect that they are the means of the original variables
colnames(mean_data_subset)[3:79]<-paste("Mean",colnames(mean_data_subset)[3:79],sep = "_")

#removing unnecessary tables and objects
rm(act_lab,activity_test,activity_train,subject_test,subject_train,features,feat,test,train,wd,wd1,wd2,wd3)

