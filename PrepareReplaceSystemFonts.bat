@echo off
:: ============================================================
:: PrepareReplaceSystemFonts.bat
::
:: Prepare the system for font replacement:
::   - Stop and disable the Windows Font Cache service
::   - Back up current system fonts (unless --not-backup)
::   - Take ownership and grant full permissions on font files
::   - Export font-related registry keys
::   - Clear FontLink SystemLink and import prepared registry
::
:: Usage:
::   PrepareReplaceSystemFonts.bat [--not-backup] [--help]
:: ============================================================

:: -- Parse arguments --
set SKIP_BACKUP=0
for %%A in (%*) do (
    if "%%~A"=="--help" goto :ShowUsage
    if "%%~A"=="--not-backup" set SKIP_BACKUP=1
)

:: -- Stop and disable Font Cache service --
net stop FontCache
sc config FontCache start=disabled

:: -- Directory configuration --
set BackupFontsDir=C:\Workspaces\Fonts\Windows\Backups\
set NewFontsDir=C:\Workspaces\Fonts\Windows\
set BinDir=C:\Scripts\
set SysFontsDir=C:\Windows\Fonts\

:: -- Back up existing system fonts (skipped if --not-backup) --
if "%SKIP_BACKUP%"=="0" (
    del /q %BackupFontsDir%*.*
    copy /y %SysFontsDir%*.* %BackupFontsDir%
)

:: -- Take ownership of font files --
takeown /f %SysFontsDir%*.ttf
takeown /f %SysFontsDir%*.ttc

:: -- Grant full control permissions to Everyone --
icacls %SysFontsDir%*.ttf /grant Everyone:F
icacls %SysFontsDir%*.ttc /grant Everyone:F

:: -- Export font registry keys --
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontMapper\FamilyDefaults" %BackupFontsDir%FamilyDefaults.reg /y
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontMapperFamilyFallback" %BackupFontsDir%FontMapperFamilyFallback.reg /y
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" %BackupFontsDir%Fonts.reg /y
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontSubstitutes" %BackupFontsDir%FontSubstitutes.reg /y
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" %BackupFontsDir%SystemLink.reg /y

:: -- Clear SystemLink and import prepared registry --
:: reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" /va /f
:: reg import %BinDir%PrepareReplaceSystemFonts.reg

goto :eof

:: ============================================================
:: Show usage information
:: ============================================================
:ShowUsage
echo.
echo PrepareReplaceSystemFonts.bat
echo.
echo Prepares the system for font replacement by stopping the Font Cache
echo service, optionally backing up fonts, setting file permissions,
echo and updating registry entries.
echo.
echo Usage:
echo   PrepareReplaceSystemFonts.bat [options]
echo.
echo Options:
echo   --not-backup    Skip clearing old backups and copying current fonts
echo   --help          Display this help message and exit
echo.
echo Examples:
echo   PrepareReplaceSystemFonts.bat                Run with full backup
echo   PrepareReplaceSystemFonts.bat --not-backup   Run without backup
echo   PrepareReplaceSystemFonts.bat --help         Show this help message
echo.
goto :eof
