---
title: "README_Human Activity Recognition Using Smartphones Dataset"
---

#NOTE: UNZIP THE CONTENT OF ZIP FILE INTO THE WORKING DIRECTORY BEFORE RUNNING THE SCRIPT

# Background information

The aim of the data is to form a predictive algorithm to determine the exact activity that a person is performing based on the data from the accelerometer and gyroscope sensors of the Samsung Galaxy SII phones. For this purpose, the data is divided into training and tesing data in a 7:3 ratio, where the training data is used to set up the model and testing data to test the model and find its accuracy.

The run_analysis.R script uses the dataset obtained from the accelerometer and gyroscope of Samsung Galaxy SII phones,fitted on the waist of 30 subjects as they are asked to perform different activities such as walking, walking up, walking down, sitting, standing and laying. The analysis takes only the mean and standard deviation parameters from the dataset provided. Each reading is sampled in a window lasting 2.56 seconds at a sampling rate of 50Hz (Hence 128 datapoints per window). Later, filters are applied to separate out the actual body acceleration and accceleration due to gravity from the measurement and other computed parameters are also derived as given in the Codebook.md. Mean and standard deviations are calculated on each of the readings, lasting for 2.56seconds, for each of the parameters.

The raw data consist of the data for the computed variables for the training and testing set in the X_train and X_test files respectively. The correpsonding activity codes for each measurement is given in y_test and y_train files. The variable names were given in the feature.txt and the subject information in subject_train and subject_test files.
The first task was to tidy up the dataset for the test and train datasets. And subsequently, the data is used to compute the means of all the variables for each subject for each activity.



#Which files to be combined?

This section describes how the data tables that can be combined are identified despite having no information on the variable names

E.g., in the train folder, if the X_train data is read into R, once can see that its dimension is 7352x561. And y_train has a dimenssion of 7352x1. So, it is eveiden that X_train and y_train can be cbind'ed. The same logic applies to the subject_train which is also 7352x1.

The file name subject_train suggests it has something to do with the subjects' identifier. And it is one column of numbers. This is also verified by seeing the range of values as 1 - 30 and we already know there are 30 subjects in this study. This means, each row represents information about which person the measurement is taken on.

The file features.txt has a size of 561x2 with 1st column a number and the second column the description of the variable. hence it can be deduced that it could be the variable name for the X_train data.

Only missing cog in the mechanism is the activity. As y_train has range of values from 1-6 and we already know that there are 6 activities measured, we come to the conclusion that y_train is the activity for each observation of the X_train. The activity_labels give detailed description of the activites involved and can be linked to y_train's numerical values.

The same logic is applicable for the datatable combination for the test data as well.

# Code Description

Opening the dplyr library to be used in the coding for tidying up the data and deriving the different datasets as per this assignment requirements.

```
library(dplyr)

```
##Directory pathway

This chunk shows the assignment of the paths to the required tables to objects, which are to be used in the next section..

```
***Getting the working directory***

wd<-getwd()

wd2<-paste0(wd,"/UCI HAR Dataset")
wd1<-paste0(wd2,"/train/")
wd3<-paste0(wd2,"/test/")

***checking if the datafolder exists in the default directory. if not, error message is displayed***
if (!file.exists("./UCI HAR Dataset")){stop(message("UCI HAR Dataset folder not found!!!"))}

```

## Reading the data

This chunk deals with the readin of the data into a data frame using read.table() command.

```

***reading activity numbers and their labels in the 'activity_labels'***
act_lab<-read.table(paste0(wd2,"/activity_labels.txt"))

***reading the variable names from the 'features' table into 'features' dataframe***
features<-read.table(paste0(wd2,"/features.txt"))

***reading the computed data in 'X_train' into 'train' data frame***
train<-read.table(paste0(wd1,"X_train.txt"))

***reading the activity data in 'y_train' into 'activity_train' data frame***
activity_train<-read.table(paste0(wd1,"y_train.txt"))

***reading the subject number data in 'subject_train' into 'subject_train' data frame***
subject_train<-read.table(paste0(wd1,"subject_train.txt"))

***reading the computed measruements of the test data from 'X_test' into 'test' data frame***
test<-read.table(paste0(wd3,"X_test.txt"))

***reading the activity data from 'y_test' into 'activity_test' data frame***
activity_test<-read.table(paste0(wd3,"y_test.txt"))

***reading the subject number data in 'subject_test' into 'subject_test' data frame***
subject_test<-read.table(paste0(wd3,"subject_test.txt"))

```
##Tidying Dataset

A tidy dataset is supposed to have the following characteristics

1. Each row is represents one measurement

2. Each column has only one variable

3. The variables are easy to understand

At the end of this sub section, the dataset will be satisfying all of the above features.

```

***storing the variable names as vector in 'feat' object to be used in the datasets***

feat<-as.vector(features$V2)

```
###Adding description to activities

The activites are not mentioned explicitly in the datasets. Each row is supposed to represent one activity done by a subject. It is tidyer if the activity information is available in the dataside alongside the observation. This subsection only derives a column which describes the activity based on the numerical value. The actual linking of the activity description to the measurement observation happens later on in the code.

```

***Adding a column to the activity label with a shortened but still comprehendable form of the activity***
act_lab<-cbind(act_lab,"Act_short"=c("Walk","Walk_up","Walk_down","Sit","Stand","Lay"))

***Addign a new column 'Act_desc' to the activity dataframe which describes the activity undertaken by joining the activity number to its descriptive form from 'act_label' dataframe***
activity_train<-activity_train%>%mutate(Act_desc=act_lab[V1,3])
activity_test<-activity_test%>%mutate(Act_desc=act_lab[V1,3])

```
###Adding Subject names to numbers

The subject names are not mentioned explicitly in the datasets. Each row is supposed to represent one activity done by a subject. It is tidyer if the subject information is available in the dataside alongside the observation. This subsection only derives a column which describes the subject description from the numerical value. The actual linking of the subject description to the measurement observation happens later on in the code.

```

***reading the subject number data in 'subject_train' into 'subject_train' data frame***
subject_train<-subject_train%>%mutate(sub_desc=paste0("Subject",V1))
subject_test<-subject_test%>%mutate(sub_desc=paste0("Subject",V1))

```

###Adding variable names to the test and train dataset

The variables names that are associated with the train and test dataset do not give any information about their relevance and has to be changed into something which makes the user understand. Hence the column names are changed into a descriptive name

```

***changing variable names from 'V1,V2...' to its descriptive form from 'feat' vector***
names(train)<-feat
names(test)<-feat

```
###Consolidating the dataset

It is essential to differentiate between the test and training data for the next level of analysis (outside the scope of this exercise) to make a prediction model for the activity. So a separate column called 'Dataset' is created to show if the observation belongs to a test or train set. The train set will be used for the development of the prediction model and the model will be tested for its accuracy with the training set.

```

***putting together the subject description from 'subject_train' and 'subect_test' df, activity description from 'activity_train' and 'activity_tst' df, a new  column 'Dataset' to show if it is a test or train set and the measurements***
train<-cbind("Dataset"="Train","Subject"=subject_train$sub_desc,"Activity"=activity_train$Act_desc,train)
test<-cbind("Dataset"="Test","Subject"=subject_test$sub_desc,"Activity"=activity_test$Act_desc,test)

```
##Step1: Combining test and training dataset

The training and testing dataset with 7352 and 2947 observations respectively are combined into one single dataset using the rbind function

```

***Combining the 'train' data frame and 'test' data frame into a new dataframe called 'full_set'***
full_set<-rbind(train,test)

```

##Step2: Extracting only mean and std measurement from merged data

grel command is used to get a vector containing the variable names with a word Mean/mean or Std/std in them. It was seen that the angle measurement variables also have the mean in their names but they are not an actual 'mean' data and hence dropped from the analysis. The Freqmean variables are allowed into the data.

```

***Extracting the mean and std measruement data alone from the 'full_set' data frame into a new data frame called data_subset_mean'. Variables with mean (or Mean) or std (or Std) in their names are chosen as long as it is not an angle measurment (involving a mean parameter)***
data_subset_mean<-full_set[,which((grepl("Dataset|Subject|Activity|*[Mm]ean*|*[Ss]td*",names(full_set))) & 
                                 (!grepl("angle",names(full_set))))]
                                 
```
##Step5: Variable means for each subject for each activity

This exercise doesn't require the differentiation between the test and training set and hence the 'Dataset' variable is dropped using the "select"" command.

```

***Taking average of all 79 measurement variables for each subject and for each activity into a dataframe 'mean_data_subset'. The "select" function removes the dataset variable to avoid errors and is alos irrelevant for this exercise***
mean_data_subset<-data_subset_mean%>%select(-Dataset)%>%group_by(Subject,Activity)%>%summarise_each(funs(mean))

***changing the column names to reflect that they are the means of the original variables***
colnames(mean_data_subset)[3:79]<-paste("Mean",colnames(mean_data_subset)[3:79],sep = "_")

***Writes the table into a txt file for upload***
write.table(mean_data_subset,"./Getting_Cleaning_Data_Assignment.txt",row.name=FALSE)

```
#File Description

This section is to make the user understand the purpose of each of the files uploaded into the github repository

##run_analysis.R

This is the r-script for executing the assignment tasks. The Samsung data zip folder has to be unzipped into the working directory for the R-Script to work

##README.md

This is the information file which describes the background of the exercise, how the data are collected, how they are tidyed up and how they are analyzed. It also outlines the files in the repository and their contents. It may be downloaded and knitted in R to get the html view.

##Codebook.md

This file describes the variables of the output datasets and their units so that the user can easily comprehend the data.