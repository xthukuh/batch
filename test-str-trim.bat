@echo off

set "text=  	 	  	 	x	  Hello Thuku!	  x  	 	  	 	"

echo.
call :test_str_rtrim

echo.
call :test_str_ltrim

echo.
call :test_str_trim

echo.
goto :eof

REM Test str-rtrim
:test_str_rtrim
echo Testing str-rtrim...
set "val=%text%"
echo - before "%val%"
call str-rtrim val
echo - after  "%val%"
goto :eof

REM Test str-ltrim
:test_str_ltrim
echo Testing str-ltrim...
set "val=%text%"
echo - before "%val%"
call str-ltrim val
echo - after  "%val%"
goto :eof

REM Test str-trim
:test_str_trim
echo Testing str-trim...
set "val=%text%"
echo - before "%val%"
call str-trim val
echo - after  "%val%"
goto :eof