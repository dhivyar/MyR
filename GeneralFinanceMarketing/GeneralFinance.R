# General Finance Company Direct Mail Marketing Response

"Background: Direct mail is one important way for the General Finance's team to connect with customers whom
may be in need of a loan. Direct offers provide huge value to customers who need them, and are a fundamental 
part of the company's marketing strategy. In order to improve their targeted efforts, the company must be 
sure they are focusing on the customers who are likely to respond and be good candidates for their services.

Using a large set of anonymized features, the objective is to predict which customers will respond to a 
direct mail offer."

"Data: You are provided a high-dimensional dataset of anonymized customer information. Each row corresponds
to one customer. The response variable is binary and labeled target. You must predict the target variable 
for every row in the test set.

The features have been anonymized to protect privacy and are comprised of a mix of continuous and 
categorical features. You will encounter many placeholder values in the data, which represent cases such as
missing values. These are intentionally preserved with their encoding to match with internal systems. The 
meaning of the features, their values, and their types are provided as-is."

"************************************************
AUTHOR: Dhivya R @grandatos
LICENSE: Copyright (C) 2015 Grandatos 
GNU General Public License v3.0
*************************************************"

# Using the package "xgboost" for Extreme gradient boosting
library(xgboost)

# Start a session pointing to the working directory
# Print information
cat("Reading the test and train data\n")
# Reading the test and train data (Only the first 20000 rows since the csv files are 921 MB and 920 MB resp.)
train <- read.csv("train.csv",nrows=20000)
test <- read.csv("test.csv",nrows=20000)

# Print information
cat("Finding if character rows are present\n")

# Perform variable class analyses to check for character classed variables
class <- lapply(train,class)
table(class)

# Print information
cat("Finding if some rows are characters and replacing with numbers\n")
# The variable names of the train dataset, except the first column- ID and last column- target
feature.names <- names(train)[2:(ncol(train)-1)]

#Print information
cat("assuming text variables are categorical & replacing them with numeric ids\n")
# There are 1919 variables/ predictors and 1,45,175 customer data rows in the training data set
# Out of this 1,45,175 rows, 20000 rows are sampled because the system RAM capacity is 6 GB.
# which cannot handle huge data sets in one go
for (f in feature.names) {
  
  #For each unique feature name, assign a ID with unique levels
  if (class(train[[f]])=="character") {
    levels <- unique(c(train[[f]], test[[f]]))
    train[[f]] <- as.integer(factor(train[[f]], levels=levels))
    test[[f]]  <- as.integer(factor(test[[f]],  levels=levels))
  }
}

# Print information
# Missing value treatment for the training and test data set
cat("replacing missing values with -1\n")
train[is.na(train)] <- -1
test[is.na(test)]   <- -1

# Print information
cat("training a XGBoost classifier\n")
# Training a extreme grandient boosting classifier object for the train data
# Data = Train data predictors
# Label = variable to predict in the test data set
# nrounds = The maximum no. of iterations
# Objective = Binary logistic regression for classification (target is 0 or 1)
# Evaluation metric: (AUC) Area under Curve
clf <- xgboost(data        = data.matrix(train[,feature.names]),
               label       = train$target,
               nrounds     = 20,
               objective   = "binary:logistic",
               eval_metric = "auc")

# Print information
cat("making predictions in batches due to 6GB RAM/ memory limitation\n")
# Creating a submission file with the customer ID column and target column
submission <- data.frame(ID=test$ID)
submission$target <- NA

# Iteration 1
#Making predictions on the test data set in batches due to the 6 GB memory limitation
for (rows in split(1:nrow(test), ceiling((1:nrow(test))/10000))) {
  submission[rows, "target"] <- predict(clf, data.matrix(test[rows,feature.names]))
}

# Print information
cat("saving the submission file\n")
# Export the csv submission file with the predicted data
write.csv(submission, "xgboost_submission.csv")

#**********************************************************************************************

"We only sampled 20000 out of 145233 rows in the test data set.
So we frame 7 iterations to load and predict all 145233 rows in the test dataset with the following values
Iteration 1: nrows=20000
Iteration 2: nrows=20000, skip=20000
Iteration 3: nrows=20000, skip=40000
Iteration 4: nrows=20000, skip=60000
Iteration 5: nrows=20000, skip=80000
Iteration 6: nrows=20000, skip=100000
Iteration 7: skip=120000"

# Iteration 1 code
test1 <- read.csv("test.csv",nrows=20000)
# Iteration 6 code
test1 <- read.csv("test.csv",nrows=20000,skip=100000)
# Iteration 7 code
test1 <- read.csv("test.csv",skip=120000)

# The new test data sets in each iteration should be assigned the feature names of the train data set
names(test1)[2:(ncol(test1)-1)] <- feature.names
features <- names(test1)[2:(ncol(test1)-1)]
# Renaming first and last columns
names(test1)[1] <- "ID"
names(test1)[ncol(test1)] <- "target"

# Print information
cat("replacing missing values with -1\n")
# Missing value treatment for new sets of test data
test1[is.na(test1)]   <- -1

cat("making predictions in batches due to 6GB memory limitation\n")
# Creating a new submission file
submission1 <- data.frame(ID=test1$ID)
submission1$target <- NA 
# Prediction for nth iteration
for (rows in split(1:nrow(test1), ceiling((1:nrow(test1))/10000))) {
  submission1[rows, "target"] <- predict(clf, data.matrix(test1[rows,features]))
}

# Print information
cat("saving the submission file\n")
# Export the csv of the predicted data with a new name for each of the 7 iterations
write.csv(submission1, "xgboost_submission6.csv")

#*********************************************************************************************
# Pre-requisite before the next iteration: Removing previous two data and trying again
# Saves space in the environment
rm(submission1,test1)

# The exported data can be cancatenated for a single csv file with the predicted values for all customer data in the test set
