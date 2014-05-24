
# Merging the training and the test sets to create one data set
X_train <- read.table("train/X_train.txt", header=FALSE, quote="")
Y_train <- read.table("train/Y_train.txt", header=FALSE)
Subject_train <- read.table("train/subject_train.txt", header=FALSE)
X_test <- read.table("test/X_test.txt", header=FALSE, quote="")
Y_test <- read.table("test/Y_test.txt", header=FALSE, quote="")
Subject_test <- read.table("test/subject_test.txt", header=FALSE)
X <- rbind(X_train, X_test)
Y <- rbind(Y_train, Y_test)
subject <- rbind(Subject_train, Subject_test)
header <- read.table("features.txt", header=FALSE)
header <- header[,2]
names(X) <- header

# Extracting only the measurements on the mean and standard deviation for each measurement.
header <- sapply(header, as.character)
sub_header <- grep(".*mean.*|.*std.*", header, perl=TRUE, value=TRUE)
X <- X[,sub_header]

# Merging subject data to the table
names(subject) = c("subject")
X <- cbind(X, subject)

#Using descriptive activity names to name the activities in the data set
desc_names <- read.table("activity_labels.txt", header=FALSE)
Y <- merge (Y, desc_names, by.x="V1", by.y="V1", sort=FALSE)
X$label = Y$V2

