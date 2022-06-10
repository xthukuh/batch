REM https://stackoverflow.com/questions/284776/how-to-convert-the-value-of-username-to-lowercase-within-a-windows-batch-scrip
@echo off

set LowerCaseMacro=for /L %%n in (1 1 2) do if %%n==2 (for %%# in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set "result=!result:%%#=%%#!") else setlocal enableDelayedExpansion ^& set result=

set "string=SOme STrinG WiTH lowerCAse letterS and UPCase leTTErs"
%LowerCaseMacro%%string%

echo %result%