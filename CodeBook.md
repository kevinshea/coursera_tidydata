#### Description of UCI HAR Dataset

None of the original data files from the UCI dataset were altered prior to use in the run_anlysis.R script.

For manipulations performed on the data set to conduct analysis, please see README.md for description of run_analysis.R


##### Understanding the data files used for this analysis

###### Test and Training

What's the difference between Test and Training?
  Splits the 30 volunteers into 2 groups.

  70% of the volunteers generating the training data and 30% the test data

  Note: Are sets of 9 and 21 people really enough for statistically significant data?

**UCI_README.txt**

  Original README file provided by UCI with brief descriptions of data files. Renamed file from README.txt to avoid confusion with my own README.md file.

**activity_labels.txt**

  List of 6 different tracked activities that volunteers could perform.

  * 1 WALKING
  * 2 WALKING_UPSTAIRS
  * 3 WALKING_DOWNSTAIRS
  * 4 SITTING
  * 5 STANDING
  * 6 LAYING

**features.txt**

 List of 561 different measures tracked by smartphone. These features are various body movement measurements captured as well as summary calculations such as mean and standard deviation calculted for measures.

 See features.txt file for full list of measurements.

**features_info.txt**

  A description of the measurements captured by the smartphone, as provided by UCI.

**/test**

**y_test.txt**

  A one column dataframe with 2947 integers, ranging from 1-6.

  Assumption: these values correspond to the activity labels


**subject_test.txt**

  Another one column dataframe with 2947 integers.

  Unique values are 2, 4, 9, 10, 12, 13, 18, 20, 24

  Assumption: these values correspond the volunteer id

**X_test.txt**

  A dataframe with 561 variables (columns) with 2947 observations (rows)

  The variables correspond to the values listed in features.txt

    * Column 1 tBodyAcc-mean()-X
    * Column 2 tBodyAcc-mean()-Y
    * ...
    * ...
    * Column 560 angle(Y,gravityMean)
    * Column 561 angle(Z,gravityMean)

**/train**

Files are structured the same as test dataset. As described above the volunteers were split
into two groups. These files contain the same data as test, but for a different set of people.

**y_train.txt**

  A one column dataframe with 7352 integers, ranging from 1-6.

  Assumption: these values correspond to the activity labels


**subject_train.txt**

  Another one column dataframe with 2947 integers.

  Unique values are 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30

  Assumption: these values correspond the volunteer id

**X_train.txt**

  A dataframe with 561 variables (columns) with 7352 observations (rows)

  The variables correspond to the values listed in features.txt

    * Column 1 tBodyAcc-mean()-X
    * Column 2 tBodyAcc-mean()-Y
    * ...
    * ...
    * Column 560 angle(Y,gravityMean)
    * Column 561 angle(Z,gravityMean)
