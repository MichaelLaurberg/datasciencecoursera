---
title: "Codebook for Samsung data"
---

How the script works: 

**Step 1 - Setting the working directory**
The first step in the script is to set the working directory of the context to point where the raw data is stored

**Step 2 - Creating R objects to handle the different pieces of data**
The second step in the script ensures that the data contained in the sourse folder, is collected and treated appropriately
By studying the explanatory files: README and features_info, several features of the raw data set is revealed
The data set can generally be split into 4 categories:

    *Train - This subfolder contain 3 .txt.files that will be combined column by column to form the train dataset
    *Test - This subfolder contain 3 .txt.files that will be combined column by column to form the test dataset
    *Activity labels - this file refers to the 6 activity levels that data are subtracted from, ie. Walking, walikng_upstairs, walking_downstairs, sitting, standing and laying 
    *Features data set - This file describes the features of each of the signals

The code script first handles the train and test data by combining the data on the activities with the subjecID's and activityIDs
 - This is done for both the test and the train data

Next the script further creates two object, holding the features labels and the activitylabels

**Step 3 - Merging the training and test data into a combined dataset**
By using the merge() command, the train and test sub-sets of data, are combined into a new dataset

**Step 4 - naming the columns of the combined dataset**
Here the new combined dataset, will be given columns names, based on the labels used in the features file, 
as well as the fields: activityID for the data in ytrain table, and the ID for the participants in the dataset found in the subjects table

**Step 5 - Extracting only the mean and standard deviation values**
This step handles the extraction of the data of interest
Given the assingment, the grepl() command for text recognition is used to search the dataset for variables containing the words "mean" and "std.." to 
extraxt only values for variabels containing data on means and standard deviations

**Step 6 - Creating a new combined dataset, taking the averages of the mean and standard deviation varibles from step 5**
This part of the scrip, ensures that the new tidydataset, contains only the averages of the mean and standard deviations extracted step 5


*Codebook*

The new tidy dataset, contains the average of the means or standard deviations for each of the features in the original dataset. In the new dataset, the averaged data is collected and organized 
by subject id and by activity id

Subject id refers to each of the subjects (persons) who orignally to part in collection the data
The activityID ranges from 1-6, and refers to each of the activities that were performed ie. Walking, walking_upstairs, walking_downstairs, sitting, standing, laying

 