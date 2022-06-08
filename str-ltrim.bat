REM ------------------------------------------
REM LEFT TRIM STRING VAR (SPACE,TAB)
REM ------------------------------------------

@echo off
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