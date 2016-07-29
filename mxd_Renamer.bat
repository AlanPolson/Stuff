ECHO OFF
REM Note: This program will work just as well, with just the line marked 'renaming bit'. The rest is just credits, instructions and precautions
REM Credits: http://www.makeuseof.com/tag/write-simple-batch-bat-file/
::http://stackoverflow.com/questions/9885241/changing-all-files-extensions-in-a-folder-with-one-command-on-windows
::http://superuser.com/questions/395836/how-to-copy-a-list-of-file-names-to-text-file
::http://stackoverflow.com/questions/6401928/batch-file-remove-second-file-extension
::http://stackoverflow.com/questions/1223721/in-windows-cmd-how-do-i-prompt-for-user-input-and-use-the-result-in-another-com
::http://www.easydos.com/choice.html
::http://ss64.com/nt/choice.html
::http://stackoverflow.com/questions/8526946/commenting-multiple-lines-in-dos-batch-file
::https://technet.microsoft.com/en-us/library/bb490986.aspx
::https://brett.batie.com/scripting/count-number-of-lines-in-a-file-using-dos/
::http://superuser.com/questions/32771/list-all-files-in-all-subfolders
::http://stackoverflow.com/questions/5664761/how-to-count-no-of-lines-in-text-file-and-store-the-value-into-a-variable-using
::http://stackoverflow.com/questions/3097044/batch-echo-or-variable-not-working

REM Author - Alan Polson

CLS
if not exist *.mxd.doc GOTO START
DIR /b /s *.mxd.doc >>filelist.txt
CHOICE /D N /T 10 /M "Feeling Lucky?"
IF ERRORLEVEL==2 GOTO START
IF ERRORLEVEL==1 GOTO renaming_bit

:START
ECHO This file was created to convert ArcGIS map file (.mxd files)
ECHO which have a .doc extension added to them.
ECHO It will do this for all files within folders within this folder as well
ECHO.
ECHO Instructions for use:
ECHO 1) Place .bat file in folder with map files that have '.doc' extensions. 
ECHO 2) Double Click .bat file to run it.
ECHO Your map files should have the .doc extension removed.
ECHO.
ECHO Hint: If you know exactly what this program will do, 
ECHO enter 'Y' at the "Feeling Lucky?" prompt

CHOICE /M "Is this file is in a folder that has a '.mxd.doc'?"
IF ERRORLEVEL==2 exit
IF ERRORLEVEL==1
CLS

::getting the number of files that have .mxd.doc
setlocal EnableDelayedExpansion
set "cmd=findstr /R /N "^^" filelist.txt | find /C ":""
for /f %%a in ('!cmd!') do set number=%%a

:safety_prompt
ECHO This program will now convert %number% file(s) 
ECHO.
ECHO If this seems right, enter Y in the next 10 seconds
ECHO Else enter N to exit 
CHOICE /C YNF /D N /T 10 /M "or F to see the names and locations of the %number% file(s)"

IF ERRORLEVEL==3 GOTO name_files
IF ERRORLEVEL==2 GOTO STOP
IF ERRORLEVEL==1 GOTO renaming_bit

:name_files
CLS
ECHO The files are:
ECHO.
TYPE filelist.txt
PAUSE
GOTO safety_prompt

:renaming_bit
FOR /R %%f IN (*.mxd.doc) DO RENAME "%%f" "%%~nf"

:STOP
DEL filelist.txt
PAUSE