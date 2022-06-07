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
call :rtrim val "	"
echo - after  "%val%"
goto :eof

REM Test ltrim
:test_ltrim
echo Testing ltrim...
set "val=%text%"
echo - before "%val%"
call :ltrim val "	"
echo - after  "%val%"
goto :eof

REM Test trim
:test_trim
echo Testing trim...
set "val=%text%"
echo - before "%val%"
call :trim val "	"
echo - after  "%val%"
goto :eof


REM -------------- RIGHT TRIM STRING VAR (SPACE,TAB) ---------------
:rtrim
setlocal EnableDelayedExpansion
call set "str=%%%~1%%"
set "_tab=	"
set "_space= "
for /l %%a in (1,1,32) do (
	set "_last_char=!str:~-1!"
	if "!_last_char!" == "!_space!" (
		set str=!str:~0,-1!
	) else if "!_last_char!" == "!_tab!" (
		set str=!str:~0,-1!
	)
)
set "_last_char=!str:~-1!"
if "!_last_char!" == "!_space!" (
	call :rtrim str
) else if "!_last_char!" == "!_tab!" (
	call :rtrim str
)
endlocal & (
	if "%~1" neq "" set "%~1=%str%"
)
exit /b

REM -------------- LEFT TRIM STRING VAR (SPACE,TAB) ----------------
:ltrim
setlocal
call set "str=%%%~1%%"
for /f "tokens=*" %%a in ("%str%") do set "str=%%a"
endlocal & (
	if "%~1" neq "" set "%~1=%str%"
)
exit /b

REM -------------- TRIM STRING VAR (SPACE,TAB) ---------------------
:trim
setlocal
call set "str=%%%~1%%"
call :rtrim str
call :ltrim str
endlocal & (
	if "%~1" neq "" set "%~1=%str%"
)
exit /b