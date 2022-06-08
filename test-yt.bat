@echo off
echo Test yt-dlp...

echo.
call :set-name "https://www.youtube.com/playlist?list=PLRhYDuCL3itz7PTimEsDg8PEJIMMy09cu" name
call str-trim name
echo ~ name "%name%"

echo.
call :set-name "https://www.youtube.com/watch?v=to8nQNGarRw" name
call str-trim name
echo ~ name "%name%"

echo.
goto :eof


REM ---------------- set name  -------------------------------
:set-name
SetLocal
set "url=%~1"
set "name="
call str-has "%url%" "/playlist?list"
if "%errorlevel%" == "1" (
	echo Get playlist name...
	call :set-playlist-name "%url%" name
) else (
	echo Get video name...
	call :set-video-name "%url%" name
)
EndLocal & (
	if "%~2" neq "" set "%~2=%name%"
) & exit /b %errorlevel%



REM ---------------- set video name --------------------------
:set-video-name
SetLocal EnableDelayedExpansion
set "url=%~1"
set "name="
set "exit_code=0"
for /F "tokens=*" %%G in (
	'yt-dlp --get-title "%url%"'
) do (
	if "%errorlevel%" == "1" (
		set "exit_code=1"
		goto set-video-name-end
	)
	set "name=%%~G"
)
:set-video-name-end
EndLocal & (
	if "%~2" neq "" set "%~2=%name%"
) & exit /b %exit_code%



REM ---------------- set playlist name -----------------------
:set-playlist-name
SetLocal EnableDelayedExpansion
set "url=%~1"
if "%url%" == "" exit /b 1
if "%~2" == "" exit /b 2
set "name="
set "exit_code=0"
for /F "tokens=*" %%G in (
	'yt-dlp --flat-playlist --playlist-items 1 "%url%"'
) do (
	if "%errorlevel%" == "1" (
		set "exit_code=1"
		goto set-playlist-name-end
	)
	set "output_line=%%~G"
	call str-has "%%~G" "Downloading playlist:" "" after
	if "!errorlevel!" == "1" (
		set "name=!after!"
		goto set-playlist-name-end
	)
)
:set-playlist-name-end
EndLocal & (
	if "%~2" neq "" set "%~2=%name%"
) & exit /b %exit_code%
