@echo off

set arg1=%~1
set arg2=%~2
echo arg1 = "%arg1%"
echo arg2 = "%arg2%"
goto :eof

set "DNS1=8.8.8.8"
set "DNS2=1.1.1.1"
echo.
echo Set net connection...
echo Preferred DNS server: %DNS1%
echo Alternate DNS server: %DNS2%

call :set_dns_values %*
goto :eof

:check_connected_interface
setlocal enabledelayedexpansion
FOR /F "tokens=*" %%G IN (
	'netsh interface show interface'
) do (
	set "col=0"
	set "status="
	set "admin_status="
	set "output_line=%%~G"
	REM: echo ~ "!output_line!"
	for %%R in ("!output_line:  =" "!") do (
		if not "%%~R" == "" (
			for /f "tokens=*" %%a in ("%%~R") do set "val=%%a"
			set /a "col=!col!+1"
			REM echo !col! - "!val!"
			if "!col!" == "1" (
				set "admin_status=!val!"
			)
			if "!col!" == "2" (
				set "status=!val!"
			)
			if "!col!" == "4" (
				if "!admin_status!" == "Enabled" (
					if "!status!" == "Connected" (
						call :interface_set_dns "!val!"
					)
				)
			)
		)
	)
)
endlocal
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