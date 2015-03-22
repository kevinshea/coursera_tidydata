### Instuctions for Creating Tidy Data for UCI HAR Dataset

##### run_analysis.R
This script contains all the necessary functions to create a tidy data set.
It performs the following actions:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The dplyr package must be installed for this script to work.

A separate function is written to perform each of these actions. Data that is used for subsequent fuctions is written to the global environment so it can be properly accessed.

The script assumes that you always want to perform all of these actions and thus a master function has been written which executes everything.

We also assume that you're working directory is the directory containing run_analysis.R and that the data inputs follow the folder structure outlined in Data Inputs.

To execute this script after loading, use the command run_analysis()

######### Data Inputs
Assumes you're running from the UCI HAR Dataset folder. For further information on what's in these files see CodeBook.md
  * ./test/y_test.txt
  * ./test/X_test.txt
  * ./test/subject_test.txt
  * ./train/y_train.txt
  * ./train/X_train.txt
  * ./train/subject_train.txt
  * features.txt
  * activity_labels.txt

######### Data Output
Writes to working directory, a tab-separated .txt file
  * my_tidy_data_summary.txt

######### Details and Assumptions of Script Actions

########### Goal 1 - Merge the training and test data sets
  * Function - create_data_file

  Combine the 3 test files into one data set such that we create a set of the following layout, named test_data
  | subject id | activity | measurement 1 | measurement 2 | ...

  In other words
    * column 1: subject_test.txt
    * column 2: y_test.txt
    * columns 3-563: X_test.txt

  Then do the same thing with training data set.

  Now, we have two data sets test_data and training_data. We now rbind those two sets together to form a master data set of har_data with 10,299 observations.


###########  Goal 2 - Extracts only the measurements on the mean and standard deviation for each measurement.

  * Function - subset_mean_and_stdev

  First off, I'm assuming we're extracting measurements of mean and standard deviation for each of the 10,299 observations. So we'll still have 10,299 rows, but a smaller number of columns. Based on course discussion posting, this appears to the be the correct assumption.

  Now, which columns are actually relevant.

  Standard Deviation is pretty straight-forward, we want any measurements that have names which contain "std()".

  Mean is a little more complicated as we have measurements that contain mean(), meanFreq(), and all of our angle measurements in some way in "mean" in the name.
  Because this is a judgment call we're going to include only those that have mean() (i.e. only the first type described). Why only those? Parallelism - std() and mean()

###########  Goal 4. Appropriately labels the data set with descriptive variable names.

  * Function - name_variables

  We're skipping Goal 3 for now because the data set will be a lot easier to work with if we give it useful variable names now.

  From our data set created in Goal 2 we have 68 variables
   * variable 1 is the subject_id
   * variable 2 is the activity
   * variable 3-68 correspond to the mean and standard deviation measurements that we subsetted above.

  We'll use the names from features.txt, which we already stored in mean_and_stdev_ids
  for the rest of the variables, even though I don't like the names, but that's the best we have.

  Note: In the future, it would probably be a good idea to eliminate "()" from the variable names, as we probably won't be able to use syntax like "my_data$tBodyAcc-mean()-Y" without R thinking that's a function call.

###########  Goal 3. Uses descriptive activity names to name the activities in the data set

  * Function - rename_activities

  We'll use the result from Goal 4 change the values in column 2 so that we map the integers as follows:
   * 1 WALKING
   * 2 WALKING_UPSTAIRS
   * 3 WALKING_DOWNSTAIRS
   * 4 SITTING
   * 5 STANDING
   * 6 LAYING

  We can use merge for this

###########  Goal 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  * Function - mean_by_activity_and_subject

  This will be like a pivot table with Subject and Activity as rows and average for each measurement. We can use the dplyr group_by and summarise_each functions.
