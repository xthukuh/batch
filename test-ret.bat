@echo off

echo.
call :test_set_param
echo.
echo.
call :test_return
echo.
call :test_trim_str
echo.
goto :eof

:test_set_param
echo Test set param
set val=
echo before - val = "%val%"
call :set_param val
echo after  - val = "%val%"
goto :eof

:set_param
set %1=filled
goto :eof

:test_return
echo Test return value
call :do_sum 2 4 res
echo res = "%res%"
echo ERRORLEVEL = "%ERRORLEVEL%"
goto :eof

:do_sum
setlocal
set "a=%~1"
set "b=%~2"
set "_returnVar=%~3"
set /a "_return=%a%+%b%"
set "_exit=0"
echo %a% + %b% = %_return%
endlocal & ( if not "%_returnVar%"=="" set "%_returnVar%=%_return%" ) & exit /b %_exit%

:test_trim_str
echo Test trim.
set "val=  a		Hello	b	  "
echo before - val = "%val%"
call :str_trim "%val%" val
echo after  - val = "%val%"
goto :eof

:str_trim
setlocal EnableDelayedExpansion
set "str=%~1"
set "_returnVar=%~2"
set "tmp="
set "tab=    "
for %%a in ("%str:	=" "%") do (
	if not "!tmp!" == "" (
		set "tmp=!tmp!!tab!%%~a"
	) else (
		set "tmp=!tmp!%%~a"
	)
)
for /f "tokens=*" %%i in ("%tmp%") do set str=%%~nxi
endlocal & ( if not "%_returnVar%"=="" set "%_returnVar%=%str%" ) & exit /b