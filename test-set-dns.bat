@echo off

set "DNS1=8.8.8.8"
set "DNS2=1.1.1.1"

set arg1=%~1
set arg2=%~2
if "%arg1%" == "-" set "arg1="
if "%arg1%" neq "" set "DNS1=%arg1%"
if "%arg2%" neq "" set "DNS2=%arg2%"

echo.
echo Set net DNS...
echo Preferred server: %DNS1%
echo Alternate server: %DNS2%

:set_connected_interface
SetLocal EnableDelayedExpansion
echo Checking connected interface...
for /f "tokens=*" %%G in ('netsh interface show interface') do (
	set "index=0"
	set "status="
	set "admin_status="
	set "output_line=%%~G"
	REM echo ~ "!output_line!"
	for %%R in ("!output_line:  =" "!") do (
		set "val=%%~R"
		if "!val!" neq "" (
			call str-trim val
			REM echo !index! - "!val!"
			if "!index!" == "0" (
				set "admin_status=!val!"
			)
			if "!index!" == "1" (
				set "status=!val!"
			)
			if "!index!" == "3" (
				if "!admin_status!" == "Enabled" (
					if "!status!" == "Connected" (
						call :interface_set_dns "!val!"
					)
				)
			)
			set /a "index=!index!+1"
		)
	)
)
EndLocal
goto :eof

:interface_set_dns
setlocal
set "name=%~1"
echo.
echo Connected interface "%name%" set dns...
call :exec_cmd netsh interface ip set dns "%name%" static %DNS1%
call :exec_cmd netsh interface ip add dns "%name%" %DNS2% INDEX=2
endlocal
goto :eof

:exec_cmd
setlocal
echo.
set "command=%*"
echo ^> %command%
FOR /F "tokens=*" %%D IN ('%command%') do (
	echo ~ %%~D
)
goto :eof