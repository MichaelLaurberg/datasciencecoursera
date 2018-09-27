#------------------------------------------------------Reading in Raw Data---------------------------------------------------
#The first step I perform, is to set my working directory to point to the directory where I downloaded the raw data
# I've done this by setting setWD to point to the folders on my local drive, where the raw data is saved
setwd("C:\\Projekter\\Data Science specialization\\Getting and Cleaning Data\\Week 4\\FinalProject\\")
myDataPath = file.path("./UCI HAR Dataset")

#-------------------------------------------------------Data description-----------------------------------------------------
#By studying the explanatory files, README and features_info, it several features of the raw data set is revealed
#The data set can generally be split into 4 categories:
#    * Train - This subfolder contain 3 .txt.files that will be combined column by column to form the train dataset
#    * Test - This subfolder contain 3 .txt.files that will be combined column by column to form the test dataset
#    * Activity labels - this file refers to the 6 activity levels that data are subtracted from, ie. Walking, walikng_upstairs, walking_downstairs, sitting, standing and laying 
#    * Features data set - This file describes the features of each of the signals

#-------------------------------------------------------Creating data categories--------------------------------------------

xtrain = read.table(file.path(myDataPath, "train", "X_train.txt"), header = FALSE)
ytrain = read.table(file.path(myDataPath, "train", "y_train.txt"), header = FALSE)
subject_train = read.table(file.path(myDataPath, "train", "subject_train.txt"), header = FALSE)

xtest = read.table(file.path(myDataPath, "test", "X_test.txt"), header = FALSE)
ytest = read.table(file.path(myDataPath, "test", "y_test.txt"), header = FALSE)
subject_test = read.table(file.path(myDataPath, "test", "subject_test.txt"), header = FALSE)

features = read.table(file.path(myDataPath, "features.txt"), header = FALSE)
activityLabels = read.table(file.path(myDataPath, "activity_labels.txt"), header = FALSE)

#In this part the training and test sub-datasets, will be combined into one called CombinedDataSet
#-------------------------------------------------------Merging data--------------------------------------------------------
mrg_Train = cbind(ytrain, subject_train, xtrain)
mrg_Test = cbind(ytest, subject_test, xtest)
CombinedDataSet = rbind(mrg_Test, mrg_Train)

#----------------------------------------Naming columns of combined dataset-------------------------------------------------
#Here the new combined dataset, will be given columns names
#Based on the labels used in the features file, as well as the fields: activityID for the data in ytrain table, and the ID for the participants in the dataset found in the subjects table
colnames(xtrain) = features[, 2]
colnames(CombinedDataSet) = c("activityId", "subjectId", colnames(xtrain))
colnames(activityLabels) <- c('activityId', 'activityType')

#-------------------------------------------Extracting only values containing mean and standard deviation like values-------
#In this part, the subsetting will be done, in order to extract only the mean and std.dev of each of the variables
#This will be done by using the grepl command, to extract all values based on certain text recognition matching the objectives of only extracting mean and standard deviation values
colNames = colnames(CombinedDataSet)
mean_std = (grepl("activityId", colNames) | grepl("subjectId", colNames) | grepl("mean..", colNames) | grepl("std..", colNames))
MeanStdDataSet <- CombinedDataSet[, mean_std == TRUE]
ActivityNames = merge(MeanStdDataSet, activityLabels, by = 'activityId', all.x = TRUE)

#--------------------------New Tidy dataset-------------------------------------
#As the last part of the assignment, this block will create the required new tidy dataset
NewTidyDataSet <- aggregate(. ~ subjectId + activityId, ActivityNames, mean)
NewTidyDataSet <- NewTidyDataSet[order(NewTidyDataSet$subjectId, NewTidyDataSet$activityId),]

#Writing the new tidy dataset to a .txt file
write.table(NewTidyDataSet, "NewTidyDataset.txt", row.name = FALSE)