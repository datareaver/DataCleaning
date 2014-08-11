setwd('C:/Users/Thomas Roh/Documents/Data Science')
library(plyr)
library(reshape2)


# Load data into R --------------------------------------------------------


train.x <- read.table('UCI HAR Dataset/train/X_train.txt')
train.y <- read.table('UCI HAR Dataset/train/Y_train.txt')
train.s <- read.table('UCI HAR Dataset/train/subject_train.txt')
features <- read.table('UCI HAR Dataset/features.txt')
test.x <- read.table('UCI HAR Dataset/test/X_test.txt')
test.y <- read.table('UCI HAR Dataset/test/Y_test.txt')
test.s <- read.table('UCI HAR Dataset/test/subject_test.txt')
activities <- read.table('UCI HAR Dataset/activity_labels.txt')
names(activities) <- c('ID','Activity')


# attach column headers to datasets ---------------------------------------


names(train.x) <- features[,2]
names(test.x) <- features[,2]


# attach IDs to data and bind together ------------------------------------

train <- data.frame(train.s,train.y,train.x)
names(train)[1:2] <- c('Subject','ID')
test <- data.frame(test.s,test.y,test.x)
names(test)[1:2] <- c('Subject','ID')
data <- rbind(train,test)
data <- merge(data,activities,by = 'ID')


# filter for mean and SDs for measurements --------------------------------

data <- data[,c(1:2,grep('mean|std',names(data)),ncol(data))]
names(data) <- sub("\\.\\.","",names(data))


# create 2nd tidy data set with mean value for each subject and ac --------

foo <- melt(data,id = c('Subject','Activity'),
            measure.vars = names(data)[4:ncol(data)-1])
tidy.data <- ddply(foo,.(Subject,Activity,variable),summarize,value = mean(value))
tidy.data <- dcast(tidy.data,Subject + Activity ~ variable,value.var = 'value')

write.csv(tidy.data,'tidy.data.csv')
