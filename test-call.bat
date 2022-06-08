@echo off

echo Test call (test-sum)...
echo.
call test-sum 10 5 res
echo - res "%res%"
echo.
goto :eof