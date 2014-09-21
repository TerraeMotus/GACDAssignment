##First, we read all the necessary files for the code.

  x_test<-read.table("test/X_test.txt")
  y_test<-read.table("test/y_test.txt")
  subject_test<-read.table("test/subject_test.txt")
  x_train<-read.table("train/X_train.txt")
  y_train<-read.table("train/y_train.txt")
  subject_train<-read.table("train/subject_train.txt")
  features<-read.table("features.txt")
  activity_labels<-read.table("activity_labels.txt")

##Then we proceed to merge the data according to its dimensions.

  data<-rbind(cbind(x_train,subject_train,y_train),cbind(x_test,subject_test,y_test))

##Now we have all the data in a data frame called 'data'. Variables are yet to be
##identified, so we proceed to label the data.

##First, we label the activities in the data according to activity_labels.txt

  activity_labels[,2]<-as.character(activity_labels[,2])
  activity_labels[,1]<-as.numeric(activity_labels[,1])
  for(i in 1:nrow(data)){
    for(j in 1:6){
      if(data[i,563]==j){
        data[i,563]<-activity_labels[j,2]
      }
    }
  }

##Then we label the colums according to features.txt

  features[,2]<-as.character(features[,2])
  for(i in 1:563){colnames(data)[i]<-features[i,2]}
  colnames(data)[562:563]<-c("subject","activity") ##This last two are labeled manually.

##Now we have to identify which colums are of interest (mean and standard deviation)
##which can be done easily with the grep function.

  mean_index<-grep("mean()",colnames(data))
  std_index<-grep("std()",colnames(data))

##Based on our selection, we proceed to create a new data frame containing only the
##columns of interest.

selected<-data[,c(mean_index,std_index,562,563)]

##And we modify the column labels so that they agree with labeling conventions and
##using underscores so as to make the labels more readable.
## Note: I do realize that using underscores may be controversial at times, but
## I do think it fits quite appropiately in this case, as the names would seem
## rather unreadable otherwise.

colnames(selected)<-tolower(colnames(selected))
colnames(selected)<-gsub("\\()","",colnames(selected))
colnames(selected)<-gsub("-","_",colnames(selected))

##Finally we create a new data frame, summarizing the previous one by activity and subject.

new<-as.data.frame(matrix(nrow=30,ncol=ncol(selected)))
k<-1
colnames(new)<-colnames(selected)
for(i in 1:30){
  for(j in 1:6){
    activity_split<-split(selected,selected$activity)[[j]]
    new[k,1:80]<-colMeans(split(activity_split,activity_split$subject)[[i]][,1:80])
    new[k,81]<-activity_split[1,81]
    k<-k+1
  }
}
  
## And we end up writing a new table with the data of interest.
  
write.table(new,"TidyData.txt",row.names=F)