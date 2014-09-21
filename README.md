###A Brief Guide to the code provided

In this repository, you can find a file named run_analysis.R. I have provided explanatory comments in that script so that it becomes clear what it's making in each step. I'll provide a summary of the overall functioning here.

1) First, the files required for the analysis are read and stored on different variables.

2) A new variable is created merging all previous variables according to the structure of the data.

3) The activities are labelled with their respective names, as detailed in the activity_names file. Columns are labelled as well according to the respective file (features.txt).

4) Only the variables containing the strings "mean" and "std" are sorted out of all the variables in the data frame. This variables go into a new data frame.

5) Variables are renamed according to naming conventions. Although the usage of underscores may be controversial at times, they are rather usefull for this particular case.

6) The data we have so far is summarized by activity as well as by subject, taking the mean of the variables for each specific subject-activity pair.

7) The tidy data produce is writting into a TidyData.txt file. To read this data, please use the following code line:

TidyData<-read.table("TidyData.txt",header=T)