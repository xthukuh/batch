@echo off

echo.
set "string=Admin State    State          Type             Interface Name"
echo Parse "%string%"

REM: Parse string delimited by more than one space
for %%R in ("%string:  =" "%") do (

	REM: Filter empty
	if not "%%~R" == "" (
		
		REM: Trim leading space
		for /f "tokens=*" %%a in ("%%~R") do set "part=%%a"
		call echo - "%%part%%"
	)
)

echo.
goto :eof
