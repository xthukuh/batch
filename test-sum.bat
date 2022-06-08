@echo off
SetLocal
set "a=%~1"
set "b=%~2"
if "%a%" == "" set "a=%random%"
if "%b%" == "" set "b=%random%"
set /a "c=%a%+%b%"
echo %a% + %b% = %c%
EndLocal & (
	if "%~3" neq "" set "%~3=%c%"
)
exit /b