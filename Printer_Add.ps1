@echo off

:: Define the print server
set "printServer=\\YourPrintServer"

:: Prompt the technician for printer names
set /p printerNames="Enter printer names (separated by commas): "

:: Split the input into an array of printer names
for %%a in (%printerNames%) do (
    :: Install the printer using rundll32
    rundll32 printui.dll,PrintUIEntry /ga /c%printServer% /n%printServer%\%%a

    :: Set the printer as the default
    rundll32 printui.dll,PrintUIEntry /y /n%printServer%\%%a
)

echo Printers installed successfully for all users.
