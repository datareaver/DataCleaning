DataCleaning
============


This script uses the data from a Samsung device monitoring study. The data is first loaded into R assuming the data has been extracted in the present working directory.

The testing and training transformed measurements (mean,std,min,max,etc.) are row binded together and then the columns are named using list provided. 'Subject' refers to the unique individual in the study and 'ID' is a numeric indicator for the activity the subject performed.

The data is then merged with the activity list to obtain the actual names of the activities.

Regex commands are used to filter the measurements to only those that are the mean or the standard deviation.

The dataset is then further reduced to take the mean of each of those measurements by Subject and Activity.

The tidy dataset is then written to a .CSV file for easy transfer.
