::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFDZRTQOKPWX6IrAS7eT36tajrVoTWO0+fJzn07eBLvNLp0blYdsv13lR1d0FCQwVKULlZww7yQ==
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdFu5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQIGelUBLA==
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQIcIQEUYQuQMmK0AfUu7fj0/f7n
::eg0/rx1wNQPfEVWB+kM9LVsJDCmNLmWzCLJcxcTYr8mPp04WUfB/Nc/6z6CBQA==
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWHWN7gIWPQlATQCNXA==
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFDZRTQOKPWX6IrAS7eT36tajp14WQO0vRKPSwPSjL/Id40vjNaQoxnVIjIUJFB44
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
::@Echo Off

::Sets up my local drives
subst D: "C:\Users\Meaghan Denelle\Desktop\Drop Zone"
subst R: "C:\Users\Meaghan Denelle\Dropbox\Denelle Law\Clients\Real Estate Closings"
subst W: "C:\Users\Meaghan Denelle\Dropbox\Denelle Law\Clients\Real Estate Closings\archive\2022 Closings"
subst O: "C:\Users\Meaghan Denelle\Dropbox\Denelle Law\Clients\Real Estate Closings\archive\2021 Closings"
timeout /t 1
PUSHD R:\ 

::Updates the Open File List
del "Our Open Files.txt"
dir /b /o-n /ad>"Our Open Files.txt"

POPD
::Begins the MLC process
set "var=%cd%"
robocopy r:\ "%var%" "Our Open Files.txt" /NFL /NDL /NJH /NJS /nc /ns /np

ren "%cd%\Our Open Files.txt" "dirlist.txt"

::Obtains all files with MLC Request or formal MLC
FOR /F "delims=" %%G in ('dir /B /S /A-D "R:" ^| findstr /I /V /C:"Archive" /I /V /C:"Misc" /I /V /C:"Pending" /I /V /C:"Docs" /I /V /C:"Seller Rep"^|findstr /I /C:"MLC"') do (
Echo %%G>>"Received.txt"
)

::If has only one, reutrns Purchase File Name and pdf name
FOR /F "tokens=1,2,4 delims=\" %%H in (Received.txt) do (
FIND /c "%%I" "Received.txt"> Log.txt | findstr /C:"1" Log.txt > nul && ( Echo %%I\%%J >> "Mid.txt" )
)

::Returns only purchase files with MLC Requests Outstanding and sends to "OS List"
FOR /F "Tokens=1,2 delims=\" %%K in (Mid.txt) do (
Echo "%%L" | FIND /C "MLC Request" > nul && ( Echo %%K>>"OS MLCS.txt")
)

::Returns only purchase files with an Actual MLC saved
FOR /F "tokens=1,2,3,4,5 delims=\" %%G in ('dir /B /S /A-D "R:" ^| findstr /I /V /C:"Archive" /I /V /C:"Misc" /I /V /C:"Pending" /I /V /C:"Docs" /I /V /C:"Seller Rep" /I /V /C:"Request"^|findstr /I /C:"MLC"') do (
Echo %%H>>"OnlyMLCsReceived.txt"
)

::Sets up heading titles
echo.'>temp.txt
echo.Currently Outstanding MLCS>>temp.txt
echo.'>temp2.txt
echo.Please save MLC request to file:>>temp2.txt
echo.'>temp6.txt
echo.Files awaiting signed Contract:>>temp6.txt
echo.'>>temp7.txt
echo.Signed P&S Hot Off the Press:>> temp7.txt


::Merges all three MLC files into one larger file
type "OS MLCS.txt">>Tirlist.txt
type "OnlyMLCsReceived.txt">>Tirlist.txt
type "dirlist.txt">>Tirlist.txt


::Creates the "Unopened files" File by returning only purchases with neither an MLC or MLC Request saved 
FOR /F "tokens=* delims=\" %%J in (Tirlist.txt) do (
FIND /c "%%J" "Tirlist.txt">Log.txt | findstr /C:"1" Log.txt >> nul && ( Echo %%J>>"temp3.txt" )
)

::
::
::

::Creates Actual Morning Report
Echo.--LIZ MORNING REPORT-->>"Morning Report.txt"
date /t>>"Morning Report.txt"
time /t>>"Morning Report.txt"
date /t>>"Run Log.txt"
time /t>>"Run Log.txt"
Echo.---->>"Run Log.txt"
TYPE temp.txt>>"Morning Report.txt"
TYPE "OS MLCS.TXT">>"Morning Report.txt"
TYPE temp2.txt>>"Morning Report.txt"
TYPE temp3.txt | FINDStr /v /C:"Open Real Estate" /v /C:"Seller Rep" /V /C:"Archive" /V /C:"Pending" /V /C:"Tax Letters" /V /C:"Misc" /V /C:"Discharge" /V /C:"1099 Forms" /V /C:"No Qualia">>"Morning Report.txt"

robocopy "C:\Users\Meaghan Denelle\Desktop\Databases\Supporting Objects\Morning" "%var%" Trivia.txt /NFL /NDL /NJH /NJS /nc /ns /np

FOR /F "tokens=* delims=" %%K in (Trivia.txt) do (
Echo %%K>"dayfact.txt"
)

FOR /F "tokens=* delims=" %%L in (Trivia.txt) do (
FIND /c "%%L" "dayfact.txt">Log.txt | findstr /C:"1" Log.txt >> nul && ( Echo %%L>>"temp4.txt" )
)

FOR /F "tokens=* delims=" %%L in (Trivia.txt) do (
FIND /c "%%L" "dayfact.txt">Log.txt | findstr /C:"0" Log.txt >> nul && ( Echo %%L>>"temp5.txt" )
)

TYPE Temp5.txt>"Trivia.txt"

echo.'>>"Morning Report.txt"
echo.'>>"Morning Report.txt"
echo.'>>"Morning Report.txt"
echo.'>>"Morning Report.txt"
TYPE temp6.txt >>"Morning Report.txt"
TYPE "Pending Yesterday.txt" >> "Morning Report.txt"
TYPE temp7.txt >> "Morning Report.txt"
TYPE NewlyIn.txt >> "Morning Report.txt"
echo.Fun Fact of the Day:>>"Morning Report.txt"
TYPE temp4.txt>>"Morning Report.txt"

DEL "OS MLCS.TXT" 
DEL "Received.txt"
DEL "dirlist.TXT"
DEL "OnlyMLCsReceived.txt" 
DEL "temp.TXT" 
DEL "Tirlist.txt"
Del "Mid.txt"
Del "Log.txt"
DEL "temp3.txt"
DEL "temp2.TXT"
DEL "temp4.txt"
DEL "temp5.TXT" 
DEL "dayfact.TXT" 
DEl "Temp6.txt"
Del "Temp7.txt"
Del "NewlyIn.txt"

Start /min /wait Notepad /p "Morning Report.TXT"
robocopy "%var%" "C:\Users\Meaghan Denelle\Desktop\Databases\Supporting Objects\Morning" Trivia.txt /NFL /NDL /NJH /NJS /nc /ns /np
Del Trivia.txt
DEL "Morning Report.txt"

Start C:\Users\"Meaghan Denelle"\Desktop\"Templates for Printables"\"FILE NAMES.xlsm"

EXIT
