# Getting and Cleaning Data / Project 1

# create data directory
if (! file.exists("data")) {
    dir.create("data")
}

# download data files
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (! file.exists("data/uci_har_dataset.zip")) {
    download.file(url, destfile="./data/uci_har_dataset.zip", method="wget")
}

# uncompress data files
if (! file.exists("data/UCI HAR Dataset")) {
    unzip("data/uci_har_dataset.zip", exdir="data")
}

# load activity descriptions
descriptions <- read.table("data/UCI HAR Dataset/activity_labels.txt")
names(descriptions) <- c("class", "description")

# load subjects and combine
train_subjects <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
test_subjects <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
subjects <- rbind(train_subjects, test_subjects)

# load labels and combine
train_labels <- read.table("data/UCI HAR Dataset/train/y_train.txt")
test_labels <- read.table("data/UCI HAR Dataset/test/y_test.txt")
labels <- rbind(train_labels, test_labels)

# load data sets and combine
train_dataset <- read.table("data/UCI HAR Dataset/train/X_train.txt")
test_dataset <- read.table("data/UCI HAR Dataset/test/X_test.txt")
combined <- rbind(train_dataset, test_dataset)

# load feature names
features <- read.table("data/UCI HAR Dataset/features.txt")
names(combined) <- features[,2]

# create new data set with needed columns
dataset <- cbind(subjects, labels)
names(dataset) <- c("subject", "class")
meanstd <- grep("-(mean|std)\\(", names(combined))
dataset <- cbind(dataset, combined[meanstd])

# rename variables (remove special characters and convert to lower case)
names(dataset) <- gsub("\\(|\\)|\\-", "", names(dataset))
names(dataset) <- tolower(names(dataset))

# merge with activity labels and drop class column
dataset <- merge(descriptions, dataset, by="class")
dataset[,c("class")] <- list(NULL)

# create tidy dataset using aggregate
tidyset <- aggregate(dataset[,-c(1,2)], by=list(subject=dataset$subject,
    activity=dataset$description), FUN=mean)

# write out tidy data to text file
write.table(tidyset, "dataset.txt", sep="\t")

