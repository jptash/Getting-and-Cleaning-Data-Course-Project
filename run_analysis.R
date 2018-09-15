library(dplyr)

##Step 0: read in the raw data

# test data
x_test <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/y_test.txt"))
subject_test <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/subject_test.txt"))

# training data
x_train <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/y_train.txt"))
subject_train <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/subject_train.txt"))

# features and labels
features <- read.table(paste0(getwd(),"/UCI HAR Dataset/features.txt"))
labels <- read.table(paste0(getwd(),"/UCI HAR Dataset/activity_labels.txt"))

##Step 1: merge the training and the test sets to create a single data set
data.test <- bind_cols(subject_test, x_test, y_test)
data.train <- bind_cols(subject_train, x_train, y_train)
data.all <- bind_rows(data.test, data.train)

## Step 2: extract only the mean and SD for each measurement.

# first add column names from features data
cnames <- c("subjectID", as.character(features[,2]), "labelID") #build vector of names
names(data.all) <- cnames #assign the names

# then extract columns that are means and stds
cols <- grepl("subject|label|mean|std", colnames(data.all))
data.meanstd <- data.all[,cols]

## Step 3: use descriptive activity names to name the activities in the data set

data.meanstd$labelID <- factor(data.meanstd$labelID, labels = labels[, 2])

## step 4: give the data set more descriptive variable names
names(data.meanstd) <- gsub("^t", "Time", names(data.meanstd))
names(data.meanstd) <- gsub("^f", "Freq", names(data.meanstd))
names(data.meanstd) <- gsub("-mean\\(\\)", "Mean", names(data.meanstd))
names(data.meanstd) <- gsub("-std\\(\\)", "Std", names(data.meanstd))
names(data.meanstd) <- gsub("-", "_", names(data.meanstd))
names(data.meanstd) <- gsub("BodyBody", "Body", names(data.meanstd))

## summarize the data by taking the mean of 
## each variable for each activity and each subject

data.mean_bySub_byAct <- data.meanstd %>%
                        group_by(subjectID, labelID) %>%
                        summarise_all(mean)

# write the data to disk
write.csv(data.mean_bySub_byAct, file = paste0(getwd(),"/tidy.data.csv"))







                    