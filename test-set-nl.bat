@echo off
setlocal EnableDelayedExpansion
(set \n=^
%=This is Mandatory Space=%
)
set NL=^%\n%%\n%
echo Hello!\n!World
echo Hello!NL!World

if "!NL!" NEQ "!NL:~0,1!" echo Error "Linefeed definition is defect, probably multiple invisble whitespaces at the line end in the definition of NL"

FOR /F "delims=" %%n in ("!NL!") do (
	echo Error "Linefeed definition is defect, probably invisble whitespaces at the line end in the definition of NL"
)
echo "Line`nNewline"
echo "Hello world.%NL%Hello world."
EndLocal & (
	if "%~1" neq "" set "%~1=!NL!"
) & exit /b