library(data.table)

# 1. Merges the training and the test sets to create one data set


print("Reading column names for training and test dataset.")
colNames <- read.table("./data/UCI HAR Dataset/features.txt", colClasses = c("numeric", "character"))[[2]]

## making sure colNames are unique

colNames <- make.names(colNames, unique = TRUE)

print("Merging both test and training data.")

trainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = colNames)
testData <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = colNames)

testTrainMerged <- rbind(testData, trainData)

print("Merging Subject data from both test and training datasets.")

subjectTestData <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
subjectTrainData <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

subjectDataMerged <- rbind(subjectTestData, subjectTrainData)

head(testTrainMerged)
head(subjectDataMerged)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

## Finding columns indices for having mean or std in their name

meanStdCols <- grep("mean|std", colNames, ignore.case = TRUE)

## extracting data for mean std columns

meanStdData <- testTrainMerged[,meanStdCols]

head(meanStdData)


# 3. Uses descriptive activity names to name the activities in the data set

print("Meging activity identifier data from both test and training datasets.")

testActivityIds <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
trainActivityIds <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

activityIdsMerged <- rbind(testActivityIds, trainActivityIds)

print("Getting Activity Labels")
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

activityIdsMerged$V1 <- as.factor(activityIdsMerged$V1)

print("Transforming activity ids to labels.")
setattr(activityIdsMerged$V1, "levels", activityLabels$V2)
setnames(activityIdsMerged, old = "V1", new = "activityName", skip_absent=TRUE)

head(activityIdsMerged$activityName)


# 4. Appropriately labels the data set with descriptive variable names.

setnames(subjectDataMerged, old = "V1", new = "subjectId", skip_absent=TRUE)
print("Combining Subject, Activity, and other column names extracted in step 1 into one data.frame")
finalData <- cbind(subjectDataMerged, activityIdsMerged, testTrainMerged)

names(finalData)<-gsub("^t", "time", names(finalData))
names(finalData)<-gsub("Acc", "Accelerometer", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("Mag", "Magnitude", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("^f", "Frequency", names(finalData))
names(finalData)<-gsub("-mean", "Mean", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("-std", "STD", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("-freq", "Frequency", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("BodyBody", "Body", names(finalData))
names(finalData)<-gsub("\\(", "", names(finalData))
names(finalData)<-gsub("\\)", "", names(finalData))
names(finalData)<-gsub("\\-", ".", names(finalData))

head(finalData)
colnames(finalData)


# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.

print("Splitting data by Subject Name and Activity Name and calculating mean accordingly.")

finalData <-aggregate(. ~subjectId + activityName, finalData, mean)
finalData <-finalData[order(finalData$subjectId,finalData$activityName),]

print("Exporting Final Clean Dataset.")
write.table(finalData, file = "analysis_result.txt",row.name=FALSE)