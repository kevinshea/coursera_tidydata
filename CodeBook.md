What's in these files?

What's the difference between Test and Training?
  Splits the 30 volunteers into 2 groups.
  70% of the volunteers generating the training data and 30% the test data
  Note: Are sets of 9 and 21 people really enough for statistically significant data?

UCI HAR Dataset/test

y_test.txt
  A one column dataframe with 2947 integers, ranging from 1-6.
  Assumption: these values correspond to the activity labels
    1 WALKING
    2 WALKING_UPSTAIRS
    3 WALKING_DOWNSTAIRS
    4 SITTING
    5 STANDING
    6 LAYING

subject_test.txt
  Another one column dataframe with 2947 integers.
  Unique values are 2, 4, 9, 10, 12, 13, 18, 20, 24
  Assumption: these values correspond the volunteer id

X_test.txt
  A dataframe with 561 variables (columns) with 2947 observations (rows)
  The variables correspond to the values listed in features.txt
    Column 1 tBodyAcc-mean()-X
    Column 2 tBodyAcc-mean()-Y
    ...
    ...
    Column 560 angle(Y,gravityMean)
    Column 561 angle(Z,gravityMean)

UCI HAR Dataset/train

Files are structured the same as test dataset. As described above the volunteers were split
into two groups. These files contain the same data as test, but for a different set of people.

y_train.txt
  A one column dataframe with 7352 integers, ranging from 1-6.
  Assumption: these values correspond to the activity labels
    1 WALKING
    2 WALKING_UPSTAIRS
    3 WALKING_DOWNSTAIRS
    4 SITTING
    5 STANDING
    6 LAYING

subject_train.txt
  Another one column dataframe with 2947 integers.
    Unique values are 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30
    Assumption: these values correspond the volunteer id

X_train.txt
  A dataframe with 561 variables (columns) with 7352 observations (rows)
  The variables correspond to the values listed in features.txt
    Column 1 tBodyAcc-mean()-X
    Column 2 tBodyAcc-mean()-Y
    ...
    ...
    Column 560 angle(Y,gravityMean)
    Column 561 angle(Z,gravityMean)

Goals
  Create one R script called run_analysis.R that does the following.
   1. Merges the training and the test sets to create one data set.
   2. Extracts only the measurements on the mean and standard deviation for each measurement.
   3. Uses descriptive activity names to name the activities in the data set
   4. Appropriately labels the data set with descriptive variable names.
   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Goal 1 - Merge the training and test data sets
  Combine the 3 test files into one data set such that we create a set of the following layout, named test_data
  | subject id | activity | measurement 1 | measurement 2 | ...

  In other words
    column 1: subject_test.txt
    column 2: y_test.txt
    columns 3-563: X_test.txt

  Then do the same thing with training data set.

  Now, we have two data sets test_data and training_data. We now rbind those two sets together to form a master data set of har_data with 10,299 observations.

Goal 2 - Extracts only the measurements on the mean and standard deviation for each measurement.

  First off, I'm assuming we're extracting measurements of mean and standard deviation for each of the 10,299 observations. So we'll still have 10,299 rows, but a smaller number of columns. Based on course discussion posting, this appears to the be the correct assumption.

  Now, which columns are actually relevant.

  Standard Deviation is pretty straight-forward, we want any measurements that have names which contain "std()".

  Mean is a little more complicated as we have measurements that contain mean(), meanFreq(), and all of our angle measurements in some way in "mean" in the name.
  Because this is a judgment call we're going to include only those that have mean() (i.e. only the first type described). Why only those? Parallelism - std() and mean()

Goal 4. Appropriately labels the data set with descriptive variable names.
  We're skipping Goal 3 for now because the data set will be a lot easier to work with if we give it useful variable names now.

  from our data set created in Goal 2 we have 68 variables
   variable 1 is the subject_id
   variable 2 is the activity
   variable 3-68 correspond to the mean and standard deviation measurements that we subsetted above.

  We'll use the names from features.txt, which we already stored in mean_and_stdev_ids
  for the rest of the variables, even though I don't like the names, but that's the best we have.

  It would probably be a good idea to eliminate "()" from the variable names, as we probably won't be able to use syntax like "my_data$tBodyAcc-mean()-Y" without R thinking that's a function call.

Goal 3. Uses descriptive activity names to name the activities in the data set

  We'll use the result from Goal 4 change the values in column 2 so that we map the integers as follows:
   1 WALKING
  2 WALKING_UPSTAIRS
   3 WALKING_DOWNSTAIRS
   4 SITTING
   5 STANDING
   6 LAYING

  We can use merge for this

Goal 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  What do we want for this? Like a pivot table with Subject and Activity as rows and average for each measurement

  
