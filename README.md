# Getting-and-Cleaning-Data-Course-Project

## Introduction
This repository contains my work for the course project for the Coursera course "Getting and Cleaning data", part of the Data Science specialization. What follows first are my notes on the original data.

## Raw data
The data for this project were collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Processing
I created a script called run_analysis.R which will merge the test and training sets together. Prerequisites for this script:

the UCI HAR Dataset must be extracted and..
the UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset"
After merging testing and training, labels are added and only columns that have to do with mean and standard deviation are kept.

Lastly, the script will create a tidy data set containing the means of all the columns per test subject and per activity. This tidy dataset will be written to a tab-delimited file called tidy.txt, which can also be found in this repository.

## Code Book
The CodeBook.md file explains the transformations performed and the resulting data and variables.
