#############################
##	Name: Shyam Mohan Kizhakekara     ##
##	Script: CLI for Big Data Analysis 	  	  ##
#############################

#!/bin/bash

# File & Folder Variables
INPUT_DIR_NAME=../inputFiles
INPUT_COMMAND_PARAM_STRING=$INPUT_DIR_NAME/*.txt
OUTPUT_DIR_NAME=../outputFiles
Q1_A_OUTPUT_FILE_NAME=$OUTPUT_DIR_NAME/Q1_A_UniqueWords.txt
Q1_B_OUTPUT_FILE_NAME=$OUTPUT_DIR_NAME/Q1_B_Z_Words.txt
Q1_C_OUTPUT_FILE_NAME=$OUTPUT_DIR_NAME/Q1_C_Words_LessThan4Times.txt
Q2_OUTPUT_FILE_NAME=$OUTPUT_DIR_NAME/Q2_Words_EndingWith_ing.txt
#Q3_OUTPUT_FILE_NAME=$OUTPUT_FOLDER_NAME/Q3_Words_Ending_With_ing.txt
Q4_OUTPUT_FILE_NAME=$OUTPUT_DIR_NAME/Q4_FiveFrequentWords_AfterStopword.txt

# WARN Messages
INPUT_DIR_EXISTS_EMPTY_WARN="WARN: Input directory already exists and is empty!"
OUTPUT_DIR_EXISTS_BUT_NOT_EMPTY_WARN="WARN: The outputFiles directory exists, but is not empty. The existing files would be deleted!"

# ERROR Messages
PROPERTY_FILE_LOAD_ERROR="ERR: Setting the property variables failed. Exitting the program!"
INPUT_DIR_NOT_EXIST_ERROR="ERR: The inputFiles directory does not exist. Exitting the program!"
INPUT_DIR_EXISTS_BUT_EMPTY_ERROR="ERR: No input files were found inside the inputFiles directory. Please download the files and execute the script again. Exitting the program!"
OUTPUT_DIR_NOT_EXIST_ERROR="ERR: The outputFiles directory does not exist. Exitting the program!"
OUTPUT_DIR_CLEAR_ERROR="ERR: All the existing files inside the outputFiles directory could not be deleted. Exitting the program!"

# INFO Messages
PROPERTY_FILE_LOAD_INFO="INFO: All the property variables were successfully set!"
INPUT_DIR_EXISTS_NOT_EMPTY_INFO="INFO: The inputFiles directory exists and contains all input files. Proceeding with the next validation!"
OUTPUT_DIR_EXISTS_INFO="INFO: The outputFiles directory exists. Proceeding with the next validation!"
OUTPUT_DIR_CLEAR_INFO="INFO: All the existing files inside the outputFiles directory were deleted! Proceeding with the next validation!"
PRE_REQUISITE_CHECK_INFO="INFO: All pre-requisites validated successfully. Program execution is good to go!"
