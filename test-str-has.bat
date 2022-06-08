@echo off

set "str=Lorem ipsum dolor sit amet, consectetur adipiscing elit."

echo Test str-has...

echo.
call :test_str_has "sit amet,"

echo.
call :test_str_has "missing"

echo.
goto :eof


:test_str_has
setlocal
set "foo=%~1"
echo [%foo%] "%str%"
call str-has "%str%" "%foo%" before after
if "%errorlevel%" == "1" (
	echo - before "%before%"
	echo - match  "%foo%"
	echo - after  "%after%"
) else (
	echo - no match.
)
endlocal
goto :eof