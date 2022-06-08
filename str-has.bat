REM ------------------------------------------
REM Check if string contains string
REM ------------------------------------------

@echo off
SetLocal EnableDelayedExpansion
set "str=%~1"
set "search=%~2"
set "before="
set "after="
set "exit_code=0"
if "%search%" neq "" (
	if /I NOT "%str%"=="!str:%search%=!" (
		set "exit_code=1"
		if "%~3" neq "" (
			set "tmp="
			for %%a in ("!str:%search%=" "!") do (
				if "!tmp!" == "" (
					set "prepend=%%~a"
					set "tmp=1"
				)
			)
		)
		if "%~4" neq "" set "after=!str:*%search%=!"
	)
) else (
	if "%~4" neq "" set "after=%str%"
)
EndLocal & (
	if "%~3" neq "" set "%~3=%prepend%"
	if "%~4" neq "" set "%~4=%after%"
) & exit /b %exit_code%