A ticket/request is submitted for a machine, below is the workflow

Have the new machine nearby. It should already have the 'Triage, After_Image, and printer add' scripts in Source
Start the 'Checklist_Hardware' script
-At the 'image machine' to the 'bitlocker' step, this will take place using the 'After Image' script on the target machine step. If some steps from After_Image were already run or not applicable just answer Y on the checklist.
-When these are run, they will output to a file on the network (probably IT\Hardware)
-The checklist should output to the same folder on the network
-Add a battery check step

#THINK ABOUT MERGING 'After_Image' and 'Triage' into one script, and just splitting steps up by 'triage' and 'after image'. The new script can be called Diagnostic_Kit.
#Make this checklist script create a folder FIRST in the network area. after checklist is done, it outputs the list. After 'Diagnostic_Kit' is finished, it will output to the same folder. this should also check to see if the folder was already made. If not it will create it (if it's run standalone). Just output an error if the machine is not on the network and continue anyway.

NOTES:
-Machine diagnostics step should be done BEFORE bitlocker. hard drive tests make bitlocker act up
-Remove capture QA and QA document step, they are redundant
