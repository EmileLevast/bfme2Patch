
::script pour aller charger les logs et les mettre sur le github
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

::on recupere la list des logs et on la met dans un fichier que l'on pushera plus tard
git log --pretty=format:"%%s" --grep="v8.2.0" > commit_logs_8.2.0.txt
git log --grep="nodlor" --grep="first commit" --invert-grep --until="Thu Apr 23 20:35:29" --pretty=format:"%%s" >> commit_logs_8.2.0.txt
git log --pretty=format:"%%s" --grep="v8.0.0"> commit_logs_8.0.0.txt
git log --grep="nodlor crushable" --pretty=format:"%%s" >> commit_logs_8.0.0.txt

