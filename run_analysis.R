### Download data set
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,"./CleanData3.zip",method = "curl")
unzip("CleanData3.zip")

### Set work directory
setwd("./UCI HAR Dataset/")

### Getting data labels for measurements and activity names
features <- read.table("features.txt")
lbl.features <- make.names(features[,2])
lbl.activity <- read.table("activity_labels.txt")

### Getting data from 'test' folder
setwd("./test")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subj_test <- read.table("subject_test.txt")

### Getting data from 'train' folder
setwd("../train")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subj_train <- read.table("subject_train.txt")

### Reset work directory
setwd("../..")

### Cleaning data
library(dplyr)

# [1] Merge measurement data and free up unused variables
X_df <- bind_rows(X_test,X_train)
rm(X_test, X_train)

# [2] Extract measurements of mean() and std() only
lbl <- c(grep("\\.mean\\.",lbl.features),grep("\\.std\\.",lbl.features))
lbl <- sort(lbl)
X_df <- X_df[,lbl]
names(X_df) <- features[lbl,2]

# Prepare activity and subject data
activity <- bind_rows(y_test, y_train)
subject <- bind_rows(subj_test, subj_train)

# [3] Match activity name to provided index
activity <- activity %>% left_join(lbl.activity, by="V1") %>% select(V2)

# Binding into one data set with Subject, Activity and Measurements
df_tidy <- bind_cols(subject, activity, X_df)

# [4] Labels for tidy data set
header <- c("Subject_ID", "Activity", names(X_df))
names(df_tidy) <- header

### [5] Tidying data
rm(X_df, y_test, y_train, subj_test, subj_train, features, activity, subject)
rm(lbl, lbl.features, lbl.activity)
df_tidy <- df_tidy %>% group_by(Subject_ID,Activity) %>% summarize_each(funs(mean))

# Record tidied data into a text file (Header file and data are separated to provide clarity)
write.table(header,"Header.txt", quote = FALSE, row.names = TRUE, col.names = FALSE)
write.table(df_tidy,"Mean Values By Subject and Activity.txt", row.names = FALSE, col.names = FALSE)
