@REM Arquivo criado por Alex Almeida
@REM alex.aldr@gmail.com

@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

title: Extracao Forense Automatica (por PID) - by Alex Almeida

echo.
call :colorEcho 0C "       d8888 888      8888888888 Y88b   d88P " & echo.
call :colorEcho 0C "      d88888 888      888         Y88b d88P  " & echo.
call :colorEcho 0C "     d88P888 888      888          Y88o88P   " & echo.
call :colorEcho 0C "    d88P 888 888      8888888       Y888P    " & echo.
call :colorEcho 0C "   d88P  888 888      888           d888b    " & echo.
call :colorEcho 0C "  d88P   888 888      888          d88888b   " & echo.
call :colorEcho 0C " d8888888888 888      888         d88P Y88b  " & echo.
call :colorEcho 0C "d88P     888 88888888 8888888888 d88P   Y88b " & echo.
echo.
call :colorEcho 0F "alex.aldr@gmail.com" & echo.
echo.
echo.

set INPUT=
set /P INPUT=Nome do arquivo de dump: %=%
echo.

set INPUTOS=
set /P INPUTOS=Perfil do sistema operacional: %=%
echo.

set PID=
set /P PID=Numero do processo (PID): %=%
echo.

mkdir PID_%PID%

call :colorEcho 0E "Gerando MALFIND (trechos de codigo suspeitos)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% malfind -p %PID% > PID_%PID%/%INPUT%.malfind
echo.

call :colorEcho 0E "Gerando DLLDUMP (extracao de DLL)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% dlldump --pid=%PID% -D PID_%PID%
echo.

call :colorEcho 0E "Gerando PROCDUMP (extracao de processo)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% procdump -p %PID% -D PID_%PID%
echo.

call :colorEcho 0E "Gerando MEMDUMP (extracao de paginas de memoria associadas)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% memdump -p %PID% -D PID_%PID%
echo.

call :colorEcho 0E "Gerando DUMPFILES (extracao de arquivos associados)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% dumpfiles -n -p %PID% -D PID_%PID%
echo.
echo.
echo.
echo.
echo.
echo.
echo.
call :colorEcho 0A " .d88888b.  888    d8P  " & echo.
call :colorEcho 0A "d88P   Y88b 888   d8P   " & echo.
call :colorEcho 0A "888     888 888  d8P    " & echo.
call :colorEcho 0A "888     888 888d88K     " & echo.
call :colorEcho 0A "888     888 8888888b    " & echo.
call :colorEcho 0A "888     888 888  Y88b   " & echo.
call :colorEcho 0A "Y88b. .d88P 888   Y88b  " & echo.
call :colorEcho 0A "  Y88888P   888    Y88b " & echo.
echo.
echo.
echo.
echo.
pause
exit

:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i

























