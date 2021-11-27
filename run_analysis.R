#bind test and train data with cbind
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
BindData <- cbind(Subject, y, x)
#Extracts only the measurements on the mean and standard deviation for each measurement.
TData <- BindData %>% select(subject, code, contains("mean"), contains("std"))
#Uses descriptive activity names to name the activities in the data set
TData$code <- activities[TData$code, 2]
#Appropriately labels the data set with descriptive variable names
names(TData)[2] = "activity"
names(TData)<-gsub("Acc", "Accelerometer", names(TData))
names(TData)<-gsub("Gyro", "Gyroscope", names(TData))
names(TData)<-gsub("BodyBody", "Body", names(TData))
names(TData)<-gsub("Mag", "Magnitude", names(TData))
names(TData)<-gsub("^t", "Time", names(TData))
names(TData)<-gsub("^f", "Frequency", names(TData))
names(TData)<-gsub("tBody", "TimeBody", names(TData))
names(TData)<-gsub("-mean()", "Mean", names(TData), ignore.case = TRUE)
names(TData)<-gsub("-std()", "STD", names(TData), ignore.case = TRUE)
names(TData)<-gsub("-freq()", "Frequency", names(TData), ignore.case = TRUE)
names(TData)<-gsub("angle", "Angle", names(TData))
names(TData)<-gsub("gravity", "Gravity", names(TData))
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
FData <- TData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FData, "FinalData.txt", row.name=FALSE)