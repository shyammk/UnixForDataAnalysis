# UnixForDataAnalysis
Using Unix commands to perform data analysis

Pre-Requisites:
-----------------
1) This script must be executed on a Unix machine (bash) only.
2) The folder structure displayed in Section 2, must be followed as such. Any modification of the folder structure will result in the failure of the program.
3) The logged in user must have enough privileges to execute the set of commands used in the project.


Steps:
--------

--> Download all the relevant input files using the URLs given:
			wget -i ./otherFiles/Download_URLS.txt -P ./inputFiles/
			
--> Now, navigate to the "scriptFiles" directory using the below command.
			cd scriptFiles/
			
--> Ensure that the bash script files "BashExecutionPackage.sh" & "LoadBashProperties.sh", present inside the scriptFiles directory have the appropriate execution permissions. To be on the safer side, execute the below command once.
			chmod 777 ./*
			
--> Now execute the script "BashExecutionPackage.sh". 
			./BashExecutionPackage.sh

--> Please note that the other script "LoadBashProperties.sh" is used to set and define all the relevant property variables required for the execution of the main script. All the properties are already defined in the file and hence, this file need not be modified.

--> The script validates the folder structures and the existence of the required files in them. If any error is encountered during the validation or while loading the property variables using "LoadBashProperties.sh", the program would be terminated.

--> The script is developed as an interactive Unix application. The instructions, user-prompts and menu options have been made as much user-friendly as possible. As you can see, a menu is displayed with an option corresponding to each use-case (question). Select any option of your choice by entering 1/2/3/4/5.

--> Note that the execution of the script continues till the user chooses option 5 or enters any invalid option i.e., any character other than 1/2/3/4/5. This avoids the overhead of executing the script multiple times to get the outputs for different questions.		
					
--> Upon selection of option 1, the script executes the three different cases mentioned in question 1, i.e., find the count of unique words, the no. of words starting with z/Z and the no. of words appearing less than 4 times. The output for this use case will be displayed on the console. Three different output files namely, "Q1_A_UniqueWords.txt", "Q1_B_Z_Words.txt", and "Q1_C_Words_LessThan4Times.txt", would be generated corresponding to each use case. These files would be present in the outputFiles directory.

--> Upon selection of option 2, the script executes the command to which finds most frequent words that end in ‘-ing’, as given in question 2. The top 10 words would be displayed as the output for this use case. The output file "Q2_Words_EndingWith_ing.txt", would be generated corresponding to this use case and they would be available in the outputFiles directory. 

--> Upon selection of option 3, the script executes the command to find which is more frequent: me/my/mine/I or us/our/ours/we, as mentioned in question 3. The most common group and the sum of its occurrences would be displayed on the console. No output file would be generated corresponding to this use case.

--> Upon selection of option 4, the script executes the command to compute the five words that appear the most after a specific stop-word, as mentioned in question 4. Here, the user would be prompted to enter a stop-word of his/her choice and based on the input, the five most frequent words after the stop-word and are displayed. An output file "Q4_FiveFrequentWords_AfterStopword.txt", would be generated corresponding to this use case and would be present in the outputFiles directory.

--> Upon selection of option 5, the script execution would be terminated.
