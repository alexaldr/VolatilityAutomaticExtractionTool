@REM Arquivo criado por Alex Almeida
@REM alex.aldr@gmail.com

@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

title: Extracao Forense Automatica - by Alex Almeida

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

call :colorEcho 0E "Gerando Hash -sha1 e -md5" & echo.
fciv.exe -add %INPUT% -both > %INPUT%.hash
echo fciv.exe -add %INPUT% -both > %INPUT%.hash > comandos.txt
echo.

call :colorEcho 0E "Gerando IMAGEINFO (perfil do Sistema Operacional)" & echo.
volatility.exe -f %INPUT% imageinfo > %INPUT%.imageinfo
echo volatility.exe -f %INPUT% imageinfo >> comandos.txt
echo.

set INPUTOS=
set /P INPUTOS=Perfil do sistema operacional: %=%
echo.

mkdir OUTPUT
call :colorEcho 0E "Gerando PSLIST (processos em execucao)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% pslist > OUTPUT/%INPUT%.pslist
echo volatility.exe -f %INPUT% --profile=%INPUTOS% pslist >> comandos.txt
echo.

call :colorEcho 0E "Gerando PSTREE (arvore de processos)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% pstree > OUTPUT/%INPUT%.pstree
echo volatility.exe -f %INPUT% --profile=%INPUTOS% pstree >> comandos.txt
echo.

call :colorEcho 0E "Gerando PSSCAN (processos encerrados anteriormente)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% psscan > OUTPUT/%INPUT%.psscan
echo volatility.exe -f %INPUT% --profile=%INPUTOS% psscan >> comandos.txt
echo.

call :colorEcho 0E "Gerando PSXVIEW (processos ocultos)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% psxview > OUTPUT/%INPUT%.psxview
echo volatility.exe -f %INPUT% --profile=%INPUTOS% psxview >> comandos.txt
echo.

call :colorEcho 0E "Gerando CONNECTIONS (conexoes abertas)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% connections > OUTPUT/%INPUT%.connections
echo volatility.exe -f %INPUT% --profile=%INPUTOS% connections >> comandos.txt
echo.

call :colorEcho 0E "Gerando CONNSCAN (conexoes encerradas)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% connscan > OUTPUT/%INPUT%.connscan
echo volatility.exe -f %INPUT% --profile=%INPUTOS% connscan >> comandos.txt
echo.

call :colorEcho 0E "Gerando DLLLIST (DLLs em execucao)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% dlllist > OUTPUT/%INPUT%.dlllist
echo volatility.exe -f %INPUT% --profile=%INPUTOS% dlllist >> comandos.txt

echo.

call :colorEcho 0E "Gerando FILESCAN (arquivos abertos anteriormente)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% filescan > OUTPUT/%INPUT%.filescan
echo volatility.exe -f %INPUT% --profile=%INPUTOS% filescan >> comandos.txt
echo.

call :colorEcho 0E "Gerando HANDLES (manipulacoes nos processos)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% handles > OUTPUT/%INPUT%.handles
echo volatility.exe -f %INPUT% --profile=%INPUTOS% handles >> comandos.txt
echo.

call :colorEcho 0E "Gerando CMDSCAN (historico do CMD)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% cmdscan > OUTPUT/%INPUT%.cmdscan
echo volatility.exe -f %INPUT% --profile=%INPUTOS% cmdscan >> comandos.txt
echo.

call :colorEcho 0E "Gerando CONSOLES (historico CMD e buffer de exibicao)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% consoles > OUTPUT/%INPUT%.consoles
echo volatility.exe -f %INPUT% --profile=%INPUTOS% consoles >> comandos.txt
echo.

call :colorEcho 0E "Gerando MBRPARSER (informacoes do setor MBR)" & echo.
volatility.exe -f %INPUT% mbrparser > OUTPUT/%INPUT%.mbrparser
echo volatility.exe -f %INPUT% mbrparser >> comandos.txt
echo.

call :colorEcho 0E "Gerando MFTPARSER (informacoes da MFT)" & echo.
volatility.exe -f %INPUT% mftparser > OUTPUT/%INPUT%.mftparser
echo volatility.exe -f %INPUT% mftparser >> comandos.txt
echo.

mkdir LOGS
call :colorEcho 0E "Gerando LOGs (WinVista+ - evtx logs do sistema)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% evtxlogs -D LOGS

call :colorEcho 0E "Gerando LOGs (WinXP/2003 - evt logs do sistema)" & echo.
volatility.exe -f %INPUT% --profile=%INPUTOS% evtlogs -D LOGS

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

























