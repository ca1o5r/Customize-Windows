@echo off
REM --- 设置源目录和日志文件路径 ---
set "SourceDir=C:\Workspaces\Fonts\Windows"
set "TargetDir=C:\Windows\Fonts"

REM !!! 日志文件是排错的关键，请务必设置一个可访问的路径 !!!
set "LogFile=C:\Workspaces\Fonts\font_replace_log.txt"


REM --- 记录任务开始信息 ---
echo ================================================= > "%LogFile%"
echo  任务启动于: %date% %time% >> "%LogFile%"
echo  源目录: %SourceDir% >> "%LogFile%"
echo ================================================= >> "%LogFile%"
echo. >> "%LogFile%"


REM --- 检查源目录是否存在 ---
if not exist "%SourceDir%" (
    echo [FATAL ERROR] 源目录 "%SourceDir%" 不存在! 脚本终止。 >> "%LogFile%"
    exit /b 1
)


REM --- 核心操作：使用 XCOPY 强制覆盖所有字体文件 ---
REM /Y - 覆盖时不提示
REM /R - 覆盖只读文件
REM /H - 复制隐藏和系统文件
REM /C - 即使出错也继续复制
REM /E - 复制所有子目录（即使是空的）
REM 2>&1 - 将所有标准输出和错误输出都重定向到日志文件

del /q C:\Windows\Fonts\timesi.ttf >> "%LogFile%" 2>&1
del /q C:\Windows\Fonts\times.ttf >> "%LogFile%" 2>&1
del /q C:\Windows\Fonts\SimsunExtG.ttf >> "%LogFile%" 2>&1
del /q C:\Windows\Fonts\simsunb.ttf >> "%LogFile%" 2>&1
del /q C:\Windows\Fonts\simkai.ttf >> "%LogFile%" 2>&1
del /q C:\Windows\Fonts\simhei.ttf >> "%LogFile%" 2>&1
del /q C:\Windows\Fonts\simfang.ttf >> "%LogFile%" 2>&1
del /q C:\Windows\Fonts\mmrtextb.ttf >> "%LogFile%" 2>&1
del /q C:\Windows\Fonts\mmrtext.ttf >> "%LogFile%" 2>&1
del /q C:\Windows\Fonts\calibri*.ttf >> "%LogFile%" 2>&1
del /q C:\Windows\Fonts\ariali.ttf >> "%LogFile%" 2>&1
del /q C:\Windows\Fonts\arial.ttf >> "%LogFile%" 2>&1
del /q C:\Windows\Fonts\YuGoth*.ttc >> "%LogFile%" 2>&1


echo 正在尝试覆盖 .ttf 和 .ttc 文件... >> "%LogFile%"
xcopy "%SourceDir%\*.*tf" "%TargetDir%\" /Y /R /H /C /E >> "%LogFile%" 2>&1
xcopy "%SourceDir%\*.*tc" "%TargetDir%\" /Y /R /H /C /E >> "%LogFile%" 2>&1


REM --- 记录任务结束信息 ---
echo. >> "%LogFile%"
echo ================================================= >> "%LogFile%"
echo  任务执行完毕于: %date% %time% >> "%LogFile%"
echo ================================================= >> "%LogFile%"

exit /b 0