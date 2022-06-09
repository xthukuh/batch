@echo off
echo Testing exec-cmd...

echo.
call exec-cmd whoami

echo.
call exec-cmd --ignore curl example.com

echo.
call exec-cmd --silent --ignore --output out netsh interface show interface
echo out "%out%"

echo.
goto :eof

:on_output_line
SetLocal
set "line=%~1"
echo ~ on_output_line "%line%"
EndLocal
exit /b