@echo off

:start
rem get cmd argument 1
set args=%*

::rem trim args
::for /f "tokens=*" %%i in ('echo %args%') do set trimmed=%%~nxi
::set args=%trimmed%

rem check no args
if "%args%" == "" (
	goto :default
)

rem set args port number
set /A port=%args%
set info=echo starting simple http server on port %port%...

rem non numeric port number
if "%port%" == "" (
	goto :default
)

rem run server start
:run
echo.
echo %info%
echo python -m http.server %port%
echo.
python -m http.server %port%
exit

rem use default port
:default
set port=8085
set info=starting simple http server using default port %port%...
goto :run
