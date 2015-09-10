# General Finance Marketing Response

* USER: https://github.com/dhivyar
* AUTHOR: Dhivya R @grandatos
* LICENSE: Copyright (C) 2015 Grandatos 
* GNU General Public License v3.0
* Version 1.0

# Included:

The Github folder GeneralFinanceMarketing contains the following files:

1. 'README.md'- Explains how all of the scripts work and how they are connected.
2. 'GeneralFinance.R' - The script which performs the following operations: Reads the test and train data. Performs data preprocessing. Builds an extreme gradient boosting model. Predicts the testdata. Exports the output.
3. 'dhivya_submission.csv' - The output after running the script in R
4. 'xgboost_submission.csv','xgboost_submission1.csv',...,'xgboost_submission6.csv' - Outputs collected at the end of iteration 1,2,...,6 respectively

# Instructions:

* Open RStudio and install R package 'xgboost' if you don't have them already using the commands install.packages("xgboost").
* Save the GeneralFinance.R script in your local directory.
* Make the RStudio look in the same directory as in step 2 using the setwd("..") command.
* In the master window of RStudio, open the file "GeneralFinance.R".
* The script will need human intervention to run it through different batches of test data. The overall data set is over 2 GB in size.
* So execute the code line by line using Ctrl+R and follow other instructions in the script messages. 
* Once the script is run, the output will be available as 7 different csv files, which needs to be consolidated.
* The output will have 145233 rows and 2 variables ID and target.
