@echo off

set "text=  	 	  	 	x	  Hello Thuku!	  x  	 	  	 	"

echo.
call :test_rtrim
echo.
call :test_ltrim
echo.
call :test_trim
echo.
goto :eof

REM Test rtrim
:test_rtrim
echo Testing rtrim...
set "val=%text%"
echo - before "%val%"
call :rtrim val
echo - after  "%val%"
goto :eof

REM Test ltrim
:test_ltrim
echo Testing ltrim...
set "val=%text%"
echo - before "%val%"
call :ltrim val
echo - after  "%val%"
goto :eof

REM Test trim
:test_trim
echo Testing trim...
set "val=%text%"
echo - before "%val%"
call :trim val
echo - after  "%val%"
goto :eof


REM -------------- RIGHT TRIM STRING VAR (SPACE,TAB) ---------------
:rtrim
SetLocal EnableDelayedExpansion
call set "val=%%%~1%%"
set "ret=%~1"
if "%val%" == "" (
	set "val=%~1"
	call set "ret=%%%~2%%"
	if not "%ret%" == "" (
		set "ret=%~2"
	)
)
if "%ret%" == "" exit /b 1
set "_tab=	"
set "_space= "
for /l %%a in (1,1,32) do (
	set "_last_char=!val:~-1!"
	if "!_last_char!" == "!_space!" (
		set val=!val:~0,-1!
	) else if "!_last_char!" == "!_tab!" (
		set val=!val:~0,-1!
	)
)
set "_last_char=!val:~-1!"
if "!_last_char!" == "!_space!" (
	call :rtrim val
) else if "!_last_char!" == "!_tab!" (
	call :rtrim val
)
EndLocal & (
	if "%ret%" neq "" set "%ret%=%val%"
)
exit /b

REM -------------- LEFT TRIM STRING VAR (SPACE,TAB) ----------------
:ltrim
SetLocal
call set "val=%%%~1%%"
set "ret=%~1"
if "%val%" == "" (
	set "val=%~1"
	call set "ret=%%%~2%%"
	if not "%ret%" == "" (
		set "ret=%~2"
	)
)
if "%ret%" == "" exit /b 1
for /f "tokens=*" %%a in ("%val%") do set "val=%%a"
EndLocal & (
	if "%ret%" neq "" set "%ret%=%val%"
)
exit /b

REM -------------- TRIM STRING VAR (SPACE,TAB) ---------------------
:trim
SetLocal
call set "val=%%%~1%%"
set "ret=%~1"
if "%val%" == "" (
	set "val=%~1"
	call set "ret=%%%~2%%"
	if not "%ret%" == "" (
		set "ret=%~2"
	)
)
if "%ret%" == "" exit /b 1
call :rtrim val
call :ltrim val
EndLocal & (
	if "%ret%" neq "" set "%ret%=%val%"
)
exit /b

:trim_old
setlocal
call set "val=%%%~1%%"
call :rtrim val
call :ltrim val
endlocal & (
	if "%~1" neq "" set "%~1=%val%"
)
exit /b


REM ---------------- misc ref ---------------------
rem https://stackoverflow.com/questions/58313472/how-to-extract-a-word-after-specific-character-in-batch-program
rem // Store line-break in variable:
(set ^"LF=^
%= blank line =%
^")