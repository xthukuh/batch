REM -----------------------------------------------------------------
REM Execute cmd
REM Usage:
REM 	exec-cmd [options] <command>
REM 	
REM 	[options]
REM 	--ignore  		- prevents abort on errorlevel
REM 	--silent  		- prevents printing command output
REM 	--output <var>	- variable name to set the output buffer
REM
REM Examples:
REM 	exec-cmd whoami
REM 	exec-cmd --ignore curl example.com
REM 	exec-cmd --silent --ignore --output out netsh interface show interface
REM -----------------------------------------------------------------

REM TODO: incomplete

@echo off
SetLocal EnableDelayedExpansion
set "exit_code=0"
set "ignore="
set "silent="
set "output="
set "buffer="
set "command="
set "args=%*"
for %%a in ("%args: =" "%") do (
	set "val=%%~a"
	set "opts="
	if "!command!" == "" (
		if "!val!" neq "" (
			if "!output!" == "1" (
				set "output=!val!"
				set "opts=1"
			) else (
				if "!val!" == "--ignore" (
					set "ignore=1"
					set "opts=1"
				) else if "!val!" == "--silent" (
					set "silent=1"
					set "opts=1"
				) else if "!val!" == "--output" (
					set "output=1"
					set "opts=1"
				)
			)
		)
	)
	if "!opts!" == "" set "command=!command! !val!"
)
set "command=!command:* =!"
echo - args "%args%"
echo - ignore "%ignore%"
echo - silent "%silent%"
echo - output "%output%"
echo - command "%command%"
REM DEBUG:
set "buffer=Hello world!"
goto exec-cmd-end

echo ^> exec-cmd "%command%"
for /f "tokens=*" %%a in ('%command%') do (
	if "%exec_cmd_ignore%" == "" (
		if "%errorlevel%" == "1" (
			set "exit_code=1"
			goto exec-cmd-end
		)
	)
	set "line=%%~a"
	if "%exec_cmd_silent%" == "" echo - "!line!"
	if "%exec_cmd_call%" neq "" call %exec_cmd_call% "!line!"
)
:exec-cmd-end
EndLocal & (
	if "%output%" neq "" set "%output%=%buffer%"
) & exit /b %exit_code%