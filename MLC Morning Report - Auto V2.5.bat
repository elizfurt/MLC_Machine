::MLC Machine 
::By Liz Furtado
::------------------------
::For further instructions on set-up, please review the ReadMe!
::This program is designed to work in conjunction with Autophile, by David Khann.
::You can download Autophile here: http://davidkann.blogspot.com/2014/07/autophile-automatically-sort-files-into.html

::@Echo Off

::Sets up your local drives.
subst D: "C:\Users\Liz Furtado\Drop Zone"
subst R: "C:\Users\Liz Furtado\Client Files"
subst W: "C:\Users\Liz Furtado\Client Files\2022 Client Files"
subst O: "C:\Users\Liz Furtado\Client Files\2021 Client Files"
timeout /t 1

::Adds date and time this program was run to the "Run Log"
date /t>>"Run Log.txt"
time /t>>"Run Log.txt"
Echo.---->>"Run Log.txt"

PUSHD R:\ 

::Deletes yesterday's Open File list and replaces it with the updated list in the Client Files folder.
del "Our Open Files.txt"
dir /b /o-n /ad>"Our Open Files.txt"

POPD
::Begins the MLC process
set "var=%cd%"
robocopy r:\ "%var%" "Our Open Files.txt" /NFL /NDL /NJH /NJS /nc /ns /np

ren "%cd%\Our Open Files.txt" "dirlist.txt"

::Obtains all files with "MLC Request" or "MLC" in the file title. 
::Program excludes files I do not want the program to search in.
FOR /F "delims=" %%G in ('dir /B /S /A-D "R:" ^| findstr /I /V /C:"Archive" /I /V /C:"Misc" /I /V /C:"Pending" /I /V /C:"Docs" /I /V /C:"Seller Rep"^|findstr /I /C:"MLC"') do (
Echo %%G>>"Received.txt"
)

::Program returns folders that only have either the MLC Request or the MLC, but not both.
FOR /F "tokens=1,2,4 delims=\" %%H in (Received.txt) do (
FIND /c "%%I" "Received.txt"> Log.txt | findstr /C:"1" Log.txt > nul && ( Echo %%I\%%J >> "Mid.txt" )
)

::Program returns folders with that have MLC Requests, but no recieved MLC.
FOR /F "Tokens=1,2 delims=\" %%K in (Mid.txt) do (
Echo "%%L" | FIND /C "MLC Request" > nul && ( Echo %%K>>"OS MLCS.txt")
)

::Program returns only folders with a received MLC saved, but no MLC Request saved.
FOR /F "tokens=1,2,3,4,5 delims=\" %%G in ('dir /B /S /A-D "R:" ^| findstr /I /V /C:"Archive" /I /V /C:"Misc" /I /V /C:"Pending" /I /V /C:"Docs" /I /V /C:"Seller Rep" /I /V /C:"Request"^|findstr /I /C:"MLC"') do (
Echo %%H>>"OnlyMLCsReceived.txt"
)

::Sets up heading titles for the Morning Report.
echo.'>header1.txt
echo.Currently Outstanding MLCS>>header1.txt
echo.'>header2.txt
echo.Please save MLC request to file:>>header2.txt


::Merges all three lists into one long list.
type "OS MLCS.txt">>Tirlist.txt
type "OnlyMLCsReceived.txt">>Tirlist.txt
type "dirlist.txt">>Tirlist.txt


::Creates an "Unopened files" list by returning folders with neither an MLC or MLC Request saved.
::In our organization system, this indicates that the Client Contract has not been "opened" or logged in our system.
FOR /F "tokens=* delims=\" %%J in (Tirlist.txt) do (
FIND /c "%%J" "Tirlist.txt">Log.txt | findstr /C:"1" Log.txt >> nul && ( Echo %%J>>"temp.txt" )
)

::Creates Actual Morning Report Printout
Echo.--LIZ MORNING REPORT-->>"Morning Report.txt"
date /t>>"Morning Report.txt"
time /t>>"Morning Report.txt"

TYPE header1.txt>>"Morning Report.txt"
TYPE "OS MLCS.TXT">>"Morning Report.txt"
TYPE header2.txt>>"Morning Report.txt"
TYPE temp.txt | FINDStr /v /C:"Open Real Estate" /v /C:"Seller Rep" /V /C:"Archive" /V /C:"Pending" /V /C:"Tax Letters" /V /C:"Misc" /V /C:"Discharge" /V /C:"1099 Forms" /V /C:"No Qualia">>"Morning Report.txt"


::This next part of the program adds a daily trivia fact to the bottom of the print out. 
:: TO OMIT TRIVIA FACT, DELETE FROM HERE -------------------
::Makes a copy of the trivia fact list to the folder program is operating out of.
robocopy "C:\Users\Liz Furtado\Databases\Supporting Objects\Morning" "%var%" Trivia.txt /NFL /NDL /NJH /NJS /nc /ns /np

::Program obtains trivia fact that is last in the list. This is the "Daily Fact."
FOR /F "tokens=* delims=" %%K in (Trivia.txt) do (
Echo %%K>"dailyfact.txt"
)

::Program searches for the "Daily Fact" and removes it from the trivia list. 
FOR /F "tokens=* delims=" %%L in (Trivia.txt) do (
FIND /c "%%L" "dailyfact.txt">Log.txt | findstr /C:"1" Log.txt >> nul && ( Echo %%L>>"temp1.txt" )
)

FOR /F "tokens=* delims=" %%L in (Trivia.txt) do (
FIND /c "%%L" "dailyfact.txt">Log.txt | findstr /C:"0" Log.txt >> nul && ( Echo %%L>>"temp2.txt" )
)

TYPE Temp2.txt>"Trivia.txt"

::Program adds the daily trivia fact to the bottom of the Morning Report.
echo.'>>"Morning Report.txt"
echo.'>>"Morning Report.txt"
echo.'>>"Morning Report.txt"
echo.'>>"Morning Report.txt"
TYPE header3.txt >>"Morning Report.txt"
echo.Fun Fact of the Day:>>"Morning Report.txt"
TYPE dailyfact.txt>>"Morning Report.txt"

:: TO OMIT TRIVIA FACT, DELETE TO HERE -------------------

::Program now deletes all of the extra files it created.
DEL "OS MLCS.TXT" 
DEL "Received.txt"
DEL "dirlist.TXT"
DEL "Tirlist.txt"
DEL "OnlyMLCsReceived.txt" 
Del "Mid.txt"
Del "Log.txt"
DEL "temp.TXT" 
DEL "header1.txt"
DEL "header2.TXT" 
DEL "header3.txt"

::Program prints out the daily report.
Start /min /wait Notepad /p "Morning Report.TXT"


::TO OMIT TRIVIA FACT, DELETE FROM HERE ------------------------------
::Programs overwrites original list with updated list.
robocopy "%var%" "C:\Users\Liz Furtado\Databases\Supporting Objects\Morning" Trivia.txt /NFL /NDL /NJH /NJS /nc /ns /np

::Program deletes the trivia list in our working folder.
Del Trivia.txt
DEL "dailyfact.TXT" 
DEL "temp2.txt"
DEL "temp3.TXT"

::TO OMIT TRIVIA FACT, DELETE TO HERE ------------------------------

::Program deletes the morning report text file.
DEL "Morning Report.txt"

EXIT
