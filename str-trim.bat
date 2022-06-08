REM ------------------------------------------
REM TRIM STRING VAR (SPACE,TAB)
REM ------------------------------------------

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
call str-rtrim val
call str-ltrim val
EndLocal & (
	if "%ret%" neq "" set "%ret%=%val%"
)
exit /b