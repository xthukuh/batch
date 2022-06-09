REM ------------------------------------------
REM Check if string contains string
REM ------------------------------------------

@echo off
SetLocal EnableDelayedExpansion
set "str=%~1"
set "search=%~2"
set "_before=%~3"
set "_after=%~4"
if "%_before%" == "-" set "_before="
set "before="
set "after="
set "exit_code=0"
if "%search%" neq "" (
	if /i not "%str%"=="!str:%search%=!" (
		set "exit_code=1"
		if "%_before%" neq "" (
			set "tmp="
			for %%a in ("!str:%search%=" "!") do (
				if "!tmp!" == "" (
					set "before=%%~a"
					set "tmp=1"
				)
			)
		)
		if "%_after%" neq "" set "after=!str:*%search%=!"
	)
) else (
	if "%_after%" neq "" set "after=%str%"
)
EndLocal & (
	if "%_before%" neq "" set "%~3=%before%"
	if "%_after%" neq "" set "%~4=%after%"
) & exit /b %exit_code%