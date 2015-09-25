GETTING AND CLEANING DATA WEEK 3 COURSE PROJECT 
=====================

## SOURCE CODE
The code to getting and cleaning the UCI data set is located in _run\_analysis.R_ .

## DATA SET SOURCE
The data set is downloaded from a url site given by the course provider at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This data set is downloaded as _CleanData3.zip_. A copy of the zipped file is
located in this github repository.

## OUTPUT
There are two output files to the source code: 
- _Header.txt_ 
- _Mean Values By Subject and Activity.txt_

Instead of putting the column names in the _Mean Values By Subject and Activity_
file, which makes the data a little hard to read in my opinion, I've decided to
separate out the column headers and written it in another file. This way, it's
easier to navigate through the column headers. Additionally, the _Header_ file
may serve as a Data Dictionary. Fuller description of each measurement variables
are given in the folder within the zipped data set _CleanData3_.
