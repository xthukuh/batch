@echo off
REM https://stackoverflow.com/questions/1721258/is-it-possible-to-put-a-new-line-character-in-an-echo-line-in-a-batch-file
SetLocal EnableDelayedExpansion

(set NL=^
%=DONT REMOVE THIS=%
)

echo NL1 Hello!NL!World
echo NL2 Hello!nl!World
set "str=Hello!nl!World"
set "str=!str! Hello!nl!World"
echo str "!str!"

if "!NL!" NEQ "!NL:~0,1!" echo Error "Linefeed definition is defect, probably multiple invisble whitespaces at the line end in the definition of NL"

FOR /F "delims=" %%n in ("!NL!") do (
	echo Error "Linefeed definition is defect, probably invisble whitespaces at the line end in the definition of NL"
)
echo "Hello world.!NL!Hello world."
EndLocal & (
	if "%~1" neq "" set "%~1=!NL!"
) & exit /b