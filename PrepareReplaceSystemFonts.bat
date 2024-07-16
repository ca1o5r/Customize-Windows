
set BackupFontsDir=C:\Workspace\Fonts\Backups\Windows\

set NewFontsDir=C:\Workspace\Fonts\Windows\

set BinDir=C:\Bin\

set SysFontsDir=C:\Windows\Fonts\

del /q %BackupFontsDir%*.*

copy /y %SysFontsDir%*.* %BackupFontsDir%

takeown /f %SysFontsDir%*.ttf

takeown /f %SysFontsDir%*.ttc

icacls %SysFontsDir%*.ttf /grant Everyone:F

icacls %SysFontsDir%*.ttc /grant Everyone:F

reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontMapper\FamilyDefaults" %BackupFontsDir%FamilyDefaults.reg /y

reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontMapperFamilyFallback" %BackupFontsDir%FontMapperFamilyFallback.reg /y

reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" %BackupFontsDir%Fonts.reg /y

reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontSubstitutes" %BackupFontsDir%FontSubstitutes.reg /y

reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" %BackupFontsDir%SystemLink.reg /y

reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" /va /f

reg import %BinDir%PrepareReplaceSystemFonts.reg

