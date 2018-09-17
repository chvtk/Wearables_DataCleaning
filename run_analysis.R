library(dplyr)

#Can I read this in faster??
#reading in testing and training measurements
test  <-  read.table("UCI HAR Dataset/test/X_test.txt")

train  <-  read.table("UCI HAR Dataset/train/X_train.txt")

#reading in testing and training activity codes
test_labels  <-  read.table("UCI HAR Dataset/test/y_test.txt")
  
train_labels  <-  read.table("UCI HAR Dataset/train/y_train.txt")

#reading in column names for testing/training datasets 
features  <-  read.table("UCI HAR Dataset/features.txt")

#reading in activity labels
activity_labels  <-  read.table("UCI HAR Dataset/activity_labels.txt")

#reading in subject numbers corresponding to train/test measurement datasets
subject_train  <- read.table("UCI HAR Dataset/train/subject_train.txt")

subject_test  <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Changing column names

#creating unique names for each entry in features dataset (there are duplicates)
newnames = make.unique(as.character(features$V2))

#setting column names of training dataset to be names in "newnames"
train2  <- train %>%
  setNames(newnames)# %>%

#adding activity number, dataset identifier (training vs testing), and subject info. 
train3  <-  mutate(train2, 
                   activity = train_labels$V1, 
                   dataset = "train", 
                   subject = subject_train$V1)

#setting column names of testing dataset to be names in "newnames"
test2  <- test %>%
  setNames(newnames)

#adding activity number, dataset identifier (training vs testing), and subject info. 
test3  <- mutate(test2, 
                 activity = test_labels$V1, 
                 dataset = "test",
                 subject = subject_test$V1)

#Merging data sets 

combo <- full_join(train3, test3)

#selecting  mean and sd measurements and activity, subject, and dataset cols
combo2  <- combo %>% select(matches("*-std()*"), 
                            matches("*-mean()*"), 
                            activity,
                            subject)

#Naming activities 
combo3  <- combo2 %>% 
            mutate(activity = ifelse(activity == 1, "WALKING",
                                           ifelse(activity == 2, "WALKING_UPSTAIRS",
                                                   ifelse(activity == 3, "WALKING_DOWNSTAIRS",
                                                           ifelse(activity == 4, "SITTING",
                                                                   ifelse(activity == 5, "STANDING", "LAYING")
)))))



#Creating summary dataset with average of each variable 
#for each activity and each subject.

summary_combo  <-  combo3 %>% 
                  group_by(activity, subject) %>% 
                    summarise_each(funs(mean)) 

#Writing file 
write.table(summary_combo, file = "Wearables_summary.txt", row.names = FALSE)

