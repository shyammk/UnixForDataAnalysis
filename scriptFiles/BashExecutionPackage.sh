#############################
##	Name: Shyam Mohan Kizhakekara     ##
##	Script: CLI for Big Data Analysis 	      ##
#############################

#!/bin/bash

: '
	Function to check the execution status of the command and take appropriate steps. It accepts three parameters -  the exit code of a command, the corresponding success message and corresponding failure message.
'
getCommandExecStatus() {
	if [ $1 -ne 0 ]
	then
		echo $2
		exit
	else
	echo $3
	fi
}

# Loading all the property variables required for the execution of this script.
. LoadBashProperties.sh
getCommandExecStatus $? "$PROPERTY_FILE_LOAD_ERROR" "$PROPERTY_FILE_LOAD_INFO"

: '
	Checking if the inputFiles directory exists and if it contains all the required input files.
	If the input directory already exists and is empty, the program would be terminated.
	If the input directory already exists and is not empty, the execution will continue.	
'
if [ ! -d "$INPUT_DIR_NAME" ]
then
	echo "$INPUT_DIR_NOT_EXIST_ERROR"
	exit
else
	if [ -z "$(ls -A $INPUT_FOLDER_NAME)" ]
	then
		echo "$INPUT_DIR_EXISTS_BUT_EMPTY_ERROR"
		exit
	else
		echo "$INPUT_DIR_EXISTS_NOT_EMPTY_INFO"	
	fi
fi

: '
	Checking if the outputFiles directory exists.
	If the output directory already exists and is empty, the same would be used for execution.
	If the output directory already exists and is not empty, all the existing contents of the directory would be deleted.	
'
if [ ! -d $OUTPUT_DIR_NAME ]
then
	echo "$OUTPUT_DIR_NOT_EXIST_ERROR"
	exit
else
	if [ "$(ls -A $OUTPUT_DIR_NAME)" ]
	then
		echo "$OUTPUT_DIR_EXISTS_BUT_NOT_EMPTY_WARN"
		find $OUTPUT_DIR_NAME -type f -delete
		getCommandExecStatus $? "$OUTPUT_DIR_CLEAR_ERROR" "$OUTPUT_DIR_CLEAR_INFO"
	else
		echo "$OUTPUT_DIR_EXISTS_INFO"
	fi
fi

: '
	Confirmation of completion of all the pre-requisite tasks and checks.
	Includes loading the property variables, checking for existence of the input directory and the input files, and also existence of the output directory and clearing the existing contents inside it, if required.	
'
echo "$PRE_REQUISITE_CHECK_INFO"

# Function to format output structure.
formatOutputStructure() {
cat<< EOF
----------------------------------------------------------
EOF
}

: '
	Use Case 01:
		a) What is the number of distinct words in the corpus? 
		b) How many words start with the letter Z/z? 
		c) How many words appear less than 4 times?
'
bashUseCaseOne() {

	echo "Total no.of distinct words: "
	sed '/^[[:space:]]*$/d;s/[[:space:]]*$//;s/--/ /g;s/[—‘’”“•´-]//g;s/^\xEF\xBB\xBF//g' ${INPUT_COMMAND_PARAM_STRING} | tr -s '[:punct:][:blank:]\r\n' '\n'| tr '[:upper:]' '[:lower:]' | sort -f | uniq -ci > $Q1_A_OUTPUT_FILE_NAME
	cat $Q1_A_OUTPUT_FILE_NAME | wc -l
	formatOutputStructure
	
	echo "No. of words starting with the letter Z/z:"
	sed '/^[[:space:]]*$/d;s/[[:space:]]*$//;s/--/ /g;s/[—‘’”“•´-]//g;s/^\xEF\xBB\xBF//g' ${INPUT_COMMAND_PARAM_STRING} | tr -s '[:punct:][:blank:]\r\n' '\n'| tr '[:upper:]' '[:lower:]' | sort -f | uniq | grep "^[z]" > $Q1_B_OUTPUT_FILE_NAME
	cat $Q1_B_OUTPUT_FILE_NAME | wc -l
	formatOutputStructure
	
	echo "No. of words appearing less than 4 times:"
	sed '/^[[:space:]]*$/d;s/[[:space:]]*$//;s/--/ /g;s/[—‘’”“•´-]//g;s/^\xEF\xBB\xBF//g' ${INPUT_COMMAND_PARAM_STRING} | tr -s '[:punct:][:blank:]\r\n' '\n'| tr '[:upper:]' '[:lower:]' | sort -f | uniq -ci | awk '{if ($1 < 4) printf "%s: %s\n",$2,$1}' > $Q1_C_OUTPUT_FILE_NAME
	cat $Q1_C_OUTPUT_FILE_NAME | wc -l
	formatOutputStructure
}

: '
	Use Case 02:
		a) What are the most frequent words that end in "-ing"?
'
bashUseCaseTwo() {

	echo "Ten most frequent words that end with '-ing': "
	sed '/^[[:space:]]*$/d;s/[[:space:]]*$//;s/--/ /g;s/[—‘’”“•´-]//g;s/^\xEF\xBB\xBF//g' ${INPUT_COMMAND_PARAM_STRING} | tr -s '[:punct:][:blank:]\r\n' '\n'| tr '[:upper:]' '[:lower:]' | sort -f | uniq -ci | grep "ing$" | sort -nr | awk '{ printf "%s: %s\n",$2,$1 }' > $Q2_OUTPUT_FILE_NAME 
	cat $Q2_OUTPUT_FILE_NAME | head -10
	formatOutputStructure
}

: ' 
	Use Case 03:
		a) Which is more frequent: me/my/mine/I or us/our/ours/we?
'
bashUseCaseThree() {
	
	echo "Most frequent - me/my/mine/I or us/our/ours/we?: "
	sed '/^[[:space:]]*$/d;s/[[:space:]]*$//;s/--/ /g;s/[—‘’”“•´-]//g;s/^\xEF\xBB\xBF//g' ${INPUT_COMMAND_PARAM_STRING} | tr -s '[:punct:][:blank:]\r\n' '\n'| tr '[:upper:]' '[:lower:]' | sort -f | uniq -ci | awk 'BEGIN{ sum1=0; sum2=0;} {if($2 ~ /^me$|^my$|^mine$|^I$/ ) sum1=sum1+$1; else if($2 ~ /^us$|^our$|^ours$|^we$/) sum2=sum2+$1} END{ if (sum1 > sum2) printf "%s: %d\n", "Group me/my/mine/I",sum1; else printf "%s: %d\n", "Group us/our/ours/we",sum2}'
	formatOutputStructure
}

: '
	Use Case 04:
		a) Take one stopword (e.g., the, and) and compute the five words that appear the most after it. E.g. "the cat belongs to the old lady from the hamlet" ! "cat ", "old" and "hamlet" would be candidates. 
		The output should contains 5 lines with the words and their frequency.
		The user has to enter a stopword of his/her choice and the five words that appear the most after this specific stopword would be dsplayed as the output.
'
bashUseCaseFour() {
	
	echo "Enter any stopword of your choice: "
	read stopWord
	stopWord=`echo ${stopWord} | tr '[:upper:]' '[:lower:]'`
	
	echo "Five words that appear the most after the stopword '$stopWord':"
	sed '/^[[:space:]]*$/d;s/[[:space:]]*$//;s/[—‘’”“•´-]//g;s/^\xEF\xBB\xBF//g' ${INPUT_COMMAND_PARAM_STRING} | tr -s '\r\n' '\n' | tr -s '[:punct:][:blank:]' ' ' | tr '[:upper:]' '[:lower:]' | awk '{for(i=1;i<NF;i++) if ($i=="'${stopWord}'") {i++;print $i;} }' | sort | uniq -ci | sort -nr > $Q4_OUTPUT_FILE_NAME
	cat $Q4_OUTPUT_FILE_NAME | head -5
	formatOutputStructure
}

: '
	The user gets to choose the specific operation he/she wishes to perform through the script.
	A user menu for the script would be displayed.
	The user has to choose an option from the list (single character).
	The corresponding operation would be performed and the output(s) would be displayed.
	The entry of an invalid input character would exit the program.
	There is an option for the user to exit the program as well.
'
while :
do
cat<< EOF
==========================================================
COMP47470 - PART 01 - CLI For Big Data
----------------------------------------------------------
Please enter your choice from the below menu (1/2/3/4/5):

(1) Command to execute CLI-Use Case 01
(2) Command to execute CLI-Use Case 02
(3) Command to execute CLI-Use Case 03
(4) Command to execute CLI-Use Case 04
(5) Exit	The Program
----------------------------------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "1")  echo "You chose Option 1: Command to execute Use Case 01" 
		formatOutputStructure
		bashUseCaseOne ;;
    "2")  echo "You chose Option 2: Command to execute Use Case 02" 
		formatOutputStructure
		bashUseCaseTwo ;;
    "3")  echo "You chose Option 3: Command to execute Use Case 03" 
		formatOutputStructure
		bashUseCaseThree ;;
	"4")  echo "You chose Option 4: Command to execute Use Case 04" 
		formatOutputStructure
		bashUseCaseFour ;;
	"5")  echo "You chose Option 5: Exit the Program!" 
		formatOutputStructure
		exit ;;
     *)  echo "Invalid Option. Exitting the program!"
		formatOutputStructure
		exit ;;
    esac
    sleep 1
done
