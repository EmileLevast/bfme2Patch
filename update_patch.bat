::script pour aller chercher les patch sur un repository github
@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------  
ECHO .
ECHO .
ECHO Voici les changements du patch 8.2.0 :
curl https://raw.githubusercontent.com/EmileLevast/bfme2Patch/master/commit_logs_8.2.0.txt
ECHO .
ECHO Telechargement ...
curl https://raw.githubusercontent.com/EmileLevast/bfme2Patch/master/%%23%%23%%23%%23%%23%%23%%23%%23%%23%%23%%23%%23202_v8.2.0.big > ############202_v8.2.0.big
ECHO Telechargement termine

ECHO .
ECHO .
ECHO Voici les changements du patch 8.0.0 :
curl https://raw.githubusercontent.com/EmileLevast/bfme2Patch/master/commit_logs_8.0.0.txt
ECHO .
set /p saisie=Veux-tu les telecharger (c'est plus long) ? (yes/no)
if %saisie% == yes (
ECHO et bah c'est parti pour le patch 2.02 v8.0.0
curl https://raw.githubusercontent.com/EmileLevast/bfme2Patch/master/%%23%%23%%23%%23%%23%%23%%23%%23%%23%%23202_v8.0.0.big > ##########202_v8.0.0.big
ECHO .
ECHO .
ECHO C est bon tu as tout pour t amuser
ECHO A bas les NOLDORS !
) else (
ECHO Ok je comprends, flemme. En esperant que ca marche !
)

PAUSE

