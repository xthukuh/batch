REM ------------------------------------------
REM RIGHT TRIM STRING VAR (SPACE,TAB)
REM ------------------------------------------

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
	call str-rtrim val
) else if "!_last_char!" == "!_tab!" (
	call str-rtrim val
)
EndLocal & (
	if "%ret%" neq "" set "%ret%=%val%"
)
exit /b