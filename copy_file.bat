REM Batch Script to rename csvs, one file at a time

dir *.csv /b/OD>csvlist.txt & REM lists files ending in csv, ordered by date of creation and truncates it to just file names ('rem'-arks are ignored)
:: type csvlist.txt & REM reads the file (commented out)
for /f %%a in ('type csvlist.txt^|find /c /v ""') do set a=%%a
if %a%==1 GOTO:End
::FINDSTR /R /N "^.*" csvlist.txt | FIND /C ":"
::if type csvlist.txt | find /c /v ""==1 GOTO End
more /E +1 "csvlist.txt" > "csvlist2.txt" & REM deletes the first line (assuming this to be the 'location_labels.csv'
set /p texte=<csvlist2.txt & REM sets the variable texte to the first line of the list
copy .\%texte% .\Done\ & REM copies this file to the 'done' folder
DEL location_labels.csv
rename .\%texte% location_labels.csv
DEL csvlist2.txt
:End
  DEL csvlist.txt