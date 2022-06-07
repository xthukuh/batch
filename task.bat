@echo off
setlocal enabledelayedexpansion
set _exe=%*
tasklist /FO CSV /NH | findstr /I "%_exe%"
exit

set _buffer=
set _tasklist='tasklist /FO CSV /NH'
for /F "delims=" %%R in (%_tasklist%) do (
	set "F1="
	set "F2="
	set "F3="
	set "F4="
	set "name="
	set "pid="
	for %%C in (%%R) do (
		if not defined F1 (
			REM Image Name
			REM echo "1: %%~C"
			set "name=%%~C"
			echo.%_exe%|findstr /I /C:"%%~C" >nul 2>&1
			if errorlevel 1 (
				set "name="
			)
		)
		if defined F1 (
			if not defined F2 (
				REM PID
				REM echo "2: %%~C"
				set "pid=%%~C"
				if not defined name (
					if not "%_exe%" == "%%~C" (
						set "pid="
					)
				)
			)
			if defined F2 (
				if not defined F3 (
					REM Session Name
				)
				if defined F3 (
					if not defined F4 (
						REM Session#
					)
					if defined F4 (
						REM Mem Usage
					)
					set "F4=#"
				)
				set "F3=#"
			)
			set "F2=#"
		)
		set "F1=#"
	)
	if defined pid (
		if not defined _buffer (
			set "_buffer=!name!: !pid!"
		) else (
			set "_buffer=!_buffer!, !pid!"
		)
		REM echo "!pid! - !name!"
	)
)
echo _buffer=%_buffer%
exit

for /F "delims=" %%R in (%_tasklist%) do (
	set FLAG1=
	set FLAG2=
	set COUNTER=0
	for %%C in (%%R) do (
		if %COUNTER%==0 set COUNTER=1
		if %COUNTER%==1 set COUNTER=2
		if %COUNTER%==2 set COUNTER=3
		if %COUNTER%==3 set COUNTER=4
		if %COUNTER%==4 set COUNTER=5
		set /A COUNTER+=1
		echo %COUNTER%
		
		if defined FLAG1 (
			if not defined FLAG2 (
				echo "1: %%~C"
				rem echo %%~C
			)
			if defined FLAG2 (
				echo "2: %%~C"
			)
			set FLAG2=1
		)
		set FLAG1=1
	)
)