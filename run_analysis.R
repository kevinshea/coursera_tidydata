# combine test and traning data files into a single data set
# assumes files are in subdirectories of working dir
create_data_file <- function() {
  
  print("reading files...this may take awhile")
  # store contents of test data files
  y_test = read.table("./test/y_test.txt")
  x_test = read.table("./test/X_test.txt")
  subject_test = read.table("./test/subject_test.txt")
  
  print("reading more files....")
  # store contents of training data files
  subject_train <- read.table("./train/subject_train.txt")
  x_train <- read.table("./train/X_train.txt")
  y_train <- read.table("./train/y_train.txt")
  
  # combine test data files
  test_data <- cbind(subject_test, y_test, x_test)
  
  # combine training data files
  training_data <- cbind(subject_train, y_train, x_train)
  
  # combine test and traning data files
  har_data <<- rbind(test_data, training_data)
  
}

# subset our combined data set to include only mean and standard deviation measurements
subset_mean_and_stdev <- function() {
  print("subsetting...")
  # get our list of measurements
  measurements <- read.table("features.txt")
  # find the measurements and ids for only mean() and std() variables
  mean_and_stdev_ids <<- filter(measurements, grepl("mean\\(\\)|std\\(\\)", measurements[,2]))
  # we need to add two to our column ids because we added subject and activity columns to har_data
  filter_columns <- mean_and_stdev_ids$V1 + 2
  # filter har_data to include subject, activity, and mean & std measures
  har_data_only_mean_and_stdev <<- har_data[, c(1:2, filter_columns)]
}

## create useful names for the variables (columns)
## from our data set created above we have 68 variables
## variable 1 is the subject_id
## variable 2 is the activity
## variable 3-68 correspond to the mean and standard deviation measurements that we 
## subsetted above. 
## we'll use the names from features.txt, which we already stored in mean_and_stdev_ids 
## for the rest of the variables, even though I don't like the names, but that's the best
## we have
name_variables <- function() {
  print("in name_variables")
  mean_and_stdev_ids[,2] <- as.character(mean_and_stdev_ids[,2])
  variable_names <- c("subject_id", "activity", mean_and_stdev_ids[,2])
  names(har_data_only_mean_and_stdev) <<- variable_names  
  
}

# rename our activities to something useful
# we'll change the values in column 2 so that we map the integers as follows:
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING
rename_activities <- function() {
  print("in rename")
  activities <- read.table("activity_labels.txt")
  names(activities) <- c("activity_id", "activity_name")
  har_data_only_mean_and_stdev <<- merge(activities, har_data_only_mean_and_stdev, by.x="activity_id", by.y="activity", all=TRUE)
  har_data_only_mean_and_stdev <<- select(har_data_only_mean_and_stdev, -(activity_id))
}

mean_by_activity_and_subject <- function()
{
  group_columns_names <- names(har_data_only_mean_and_stdev)[1:2]
  group_columns_symbols <- lapply(group_columns_names, as.symbol)
  my_data_summary <- har_data_only_mean_and_stdev %>% 
                        group_by_(.dots=group_columns_symbols) %>% 
                        summarise_each(funs(mean))
  write.table(my_data_summary, file="my_tidy_data_summary.txt", sep="\t", row.names=FALSE)
  
}

# run everything
run_analysis <- function()
{
  library(dplyr)
  
  create_data_file()
  subset_mean_and_stdev()
  name_variables()
  rename_activities()
  mean_by_activity_and_subject()
  
}
