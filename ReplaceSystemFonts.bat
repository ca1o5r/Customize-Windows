@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM 脚本名称：ReplaceSystemFonts.bat
REM 功能说明：
REM   1. 默认模式：删除目标目录（Windows 系统字体目录）中指定的
REM      原始字体文件，然后从源目录强制覆盖复制所有字体文件。
REM   2. 同步模式（--sync-only）：仅将源目录中存在的、但目标目录
REM      中不存在的字体文件复制过去，不删除、不覆盖任何文件。
REM ============================================================

REM --- 源目录与目标目录配置 ---
REM SourceDir: 存放新字体文件的目录
set "SourceDir=C:\Workspaces\Fonts\Windows"
REM TargetDir: Windows 系统字体目录
set "TargetDir=C:\Windows\Fonts"

REM --- 日志文件路径配置 ---
REM 日志用于记录脚本执行过程，便于后续排查问题
set "LogFile=C:\Workspaces\Fonts\font_replace_log.txt"

REM --- 命令行参数解析 ---
REM SyncOnly: 是否启用仅同步缺失字体模式（0=否，1=是）
set "SyncOnly=0"

:ParseArgs
if "%~1"=="" goto :DoneArgs
if /I "%~1"=="--sync-only" (
    set "SyncOnly=1"
) else if /I "%~1"=="--help" (
    goto :ShowUsage
)
shift
goto :ParseArgs
:DoneArgs

REM --- 记录任务开始信息 ---
echo ================================================= > "%LogFile%"
echo  任务启动于: %date% %time% >> "%LogFile%"
echo  源目录: %SourceDir% >> "%LogFile%"
echo  目标目录: %TargetDir% >> "%LogFile%"
echo  同步模式标志: %SyncOnly% >> "%LogFile%"
echo ================================================= >> "%LogFile%"
echo. >> "%LogFile%"

REM --- 检查源目录是否存在 ---
if not exist "%SourceDir%" (
    echo [FATAL ERROR] 源目录 "%SourceDir%" 不存在! 脚本终止。 >> "%LogFile%"
    exit /b 1
)

REM --- 检查目标目录是否存在 ---
if not exist "%TargetDir%" (
    echo [FATAL ERROR] 目标目录 "%TargetDir%" 不存在! 脚本终止。 >> "%LogFile%"
    exit /b 1
)

REM ============================================================
REM 根据命令行参数选择执行模式
REM ============================================================
if "%SyncOnly%"=="1" (
    goto :SyncOnlyMode
) else (
    goto :ReplaceMode
)

REM ============================================================
REM 默认替换模式：删除指定系统字体，再强制覆盖复制
REM ============================================================
:ReplaceMode

echo 正在进入【默认替换模式】... >> "%LogFile%"

REM --- 删除目标目录中预定义的 Windows 系统字体 ---
REM 以下列表为需要清理的原始字体，避免与新字体产生冲突。
REM 使用 2>nul 抑制文件不存在时的错误提示，确保脚本继续执行。
set "SysFontsDir=%TargetDir%\"

del "%SysFontsDir%arial.ttf" 2>nul
del "%SysFontsDir%ariblk.ttf" 2>nul
del "%SysFontsDir%ariali.ttf" 2>nul
del "%SysFontsDir%arialn.TTF" 2>nul
del "%SysFontsDir%arialnb.TTF" 2>nul
del "%SysFontsDir%arialnbi.TTF" 2>nul
del "%SysFontsDir%arialni.TTF" 2>nul
del "%SysFontsDir%bahnschrift.ttf" 2>nul
del "%SysFontsDir%BIZ-UDGothicR.ttc" 2>nul
del "%SysFontsDir%BIZ-UDGothicB.ttc" 2>nul
del "%SysFontsDir%BIZ-UDMinchoM.ttc" 2>nul
del "%SysFontsDir%calibri.ttf" 2>nul
del "%SysFontsDir%calibrib.ttf" 2>nul
del "%SysFontsDir%calibriz.ttf" 2>nul
del "%SysFontsDir%calibrii.ttf" 2>nul
del "%SysFontsDir%calibril.ttf" 2>nul
del "%SysFontsDir%calibrili.ttf" 2>nul
del "%SysFontsDir%cambria.ttc" 2>nul
del "%SysFontsDir%cambriab.ttf" 2>nul
del "%SysFontsDir%cambriaz.ttf" 2>nul
del "%SysFontsDir%cambriai.ttf" 2>nul
del "%SysFontsDir%candara.ttf" 2>nul
del "%SysFontsDir%candarab.ttf" 2>nul
del "%SysFontsDir%candaraz.ttf" 2>nul
del "%SysFontsDir%candarai.ttf" 2>nul
del "%SysFontsDir%candaral.ttf" 2>nul
del "%SysFontsDir%candarali.ttf" 2>nul
del "%SysFontsDir%comic.ttf" 2>nul
del "%SysFontsDir%comicbd.ttf" 2>nul
del "%SysFontsDir%comicz.ttf" 2>nul
del "%SysFontsDir%comici.ttf" 2>nul
del "%SysFontsDir%consola.ttf" 2>nul
del "%SysFontsDir%consolai.ttf" 2>nul
del "%SysFontsDir%constan.ttf" 2>nul
del "%SysFontsDir%constanb.ttf" 2>nul
del "%SysFontsDir%constanz.ttf" 2>nul
del "%SysFontsDir%constani.ttf" 2>nul
del "%SysFontsDir%corbel.ttf" 2>nul
del "%SysFontsDir%corbelb.ttf" 2>nul
del "%SysFontsDir%corbelz.ttf" 2>nul
del "%SysFontsDir%corbeli.ttf" 2>nul
del "%SysFontsDir%corbell.ttf" 2>nul
del "%SysFontsDir%corbelli.ttf" 2>nul
del "%SysFontsDir%cour.ttf" 2>nul
del "%SysFontsDir%couri.ttf" 2>nul
del "%SysFontsDir%Deng.ttf" 2>nul
del "%SysFontsDir%Dengb.ttf" 2>nul
del "%SysFontsDir%Dengl.ttf" 2>nul
del "%SysFontsDir%DejaVuSans.ttf" 2>nul
del "%SysFontsDir%DejaVuSansMono-BoldOblique.ttf" 2>nul
del "%SysFontsDir%ebrima.ttf" 2>nul
del "%SysFontsDir%ebrimabd.ttf" 2>nul
del "%SysFontsDir%simfang.ttf" 2>nul
del "%SysFontsDir%framd.ttf" 2>nul
del "%SysFontsDir%framdit.ttf" 2>nul
del "%SysFontsDir%gadugi.ttf" 2>nul
del "%SysFontsDir%gadugib.ttf" 2>nul
del "%SysFontsDir%Gabriola.ttf" 2>nul
del "%SysFontsDir%georgia.ttf" 2>nul
del "%SysFontsDir%georgiai.ttf" 2>nul
del "%SysFontsDir%impact.ttf" 2>nul
del "%SysFontsDir%Inkfree.ttf" 2>nul
del "%SysFontsDir%javatext.ttf" 2>nul
del "%SysFontsDir%simkai.ttf" 2>nul
del "%SysFontsDir%leelawui.ttf" 2>nul
del "%SysFontsDir%leelauib.ttf" 2>nul
del "%SysFontsDir%leeluisl.ttf" 2>nul
del "%SysFontsDir%LatoWeb*" 2>nul
del "%SysFontsDir%LiberationSansNarrow-Regular.ttf" 2>nul
del "%SysFontsDir%LiberationSerif-Italic.ttf" 2>nul
del "%SysFontsDir%lucon.TTF" 2>nul
del "%SysFontsDir%l_10646.ttf" 2>nul
del "%SysFontsDir%malgun.ttf" 2>nul
del "%SysFontsDir%malgunsl.ttf" 2>nul
del "%SysFontsDir%meiryo.ttc" 2>nul
del "%SysFontsDir%himalaya.ttf" 2>nul
del "%SysFontsDir%MiriamMonoCLM-Bold.ttf" 2>nul
del "%SysFontsDir%msjh.ttc" 2>nul
del "%SysFontsDir%msjhl.ttc" 2>nul
del "%SysFontsDir%ntailu.ttf" 2>nul
del "%SysFontsDir%ntailub.ttf" 2>nul
del "%SysFontsDir%phagspa.ttf" 2>nul
del "%SysFontsDir%phagspab.ttf" 2>nul
del "%SysFontsDir%micross.ttf" 2>nul
del "%SysFontsDir%taile.ttf" 2>nul
del "%SysFontsDir%taileb.ttf" 2>nul
del "%SysFontsDir%msyh.ttc" 2>nul
del "%SysFontsDir%msyhl.ttc" 2>nul
del "%SysFontsDir%msyi.ttf" 2>nul
del "%SysFontsDir%mingliub.ttc" 2>nul
del "%SysFontsDir%monbaiti.ttf" 2>nul
del "%SysFontsDir%msgothic.ttc" 2>nul
del "%SysFontsDir%msmincho.ttc" 2>nul
del "%SysFontsDir%mvboli.ttf" 2>nul
del "%SysFontsDir%mmrtext.ttf" 2>nul
del "%SysFontsDir%mmrtextb.ttf" 2>nul
del "%SysFontsDir%Nirmala.ttf" 2>nul
del "%SysFontsDir%NirmalaB.ttf" 2>nul
del "%SysFontsDir%NirmalaS.ttf" 2>nul
del "%SysFontsDir%NotoSansJP-VF.ttf" 2>nul
del "%SysFontsDir%NotoSerifJP-VF.ttf" 2>nul
del "%SysFontsDir%NotoSerifHebrew-Bold.ttf" 2>nul
del "%SysFontsDir%NotoSansSC-VF.ttf" 2>nul
del "%SysFontsDir%NotoSerifSC-VF.ttf" 2>nul
del "%SysFontsDir%NotoSerifLao-Bold.ttf" 2>nul
del "%SysFontsDir%OUTLOOK.TTF" 2>nul
del "%SysFontsDir%pala.ttf" 2>nul
del "%SysFontsDir%palab.ttf" 2>nul
del "%SysFontsDir%palabi.ttf" 2>nul
del "%SysFontsDir%palai.ttf" 2>nul
del "%SysFontsDir%refsan.ttf" 2>nul
del "%SysFontsDir%REFSPCL.TTF" 2>nul
del "%SysFontsDir%SansSerifCollection.ttf" 2>nul
del "%SysFontsDir%segoepr.ttf" 2>nul
del "%SysFontsDir%segoeprb.ttf" 2>nul
del "%SysFontsDir%segoesc.ttf" 2>nul
del "%SysFontsDir%segoescb.ttf" 2>nul
del "%SysFontsDir%seguihis.ttf" 2>nul
del "%SysFontsDir%SegUIVar.ttf" 2>nul
del "%SysFontsDir%simhei.ttf" 2>nul
del "%SysFontsDir%simsunb.ttf" 2>nul
del "%SysFontsDir%SimsunExtG.ttf" 2>nul
del "%SysFontsDir%SitkaVF.ttf" 2>nul
del "%SysFontsDir%SitkaVF-Italic.ttf" 2>nul
del "%SysFontsDir%sylfaen.ttf" 2>nul
del "%SysFontsDir%tahoma.ttf" 2>nul
del "%SysFontsDir%times.ttf" 2>nul
del "%SysFontsDir%timesi.ttf" 2>nul
del "%SysFontsDir%trebuc.ttf" 2>nul
del "%SysFontsDir%trebucbd.ttf" 2>nul
del "%SysFontsDir%trebucbi.ttf" 2>nul
del "%SysFontsDir%trebucit.ttf" 2>nul
del "%SysFontsDir%UDDigiKyokashoN-B.ttc" 2>nul
del "%SysFontsDir%UDDigiKyokashoN-R.ttc" 2>nul
del "%SysFontsDir%YuGothB.ttc" 2>nul
del "%SysFontsDir%YuGothL.ttc" 2>nul
del "%SysFontsDir%YuGothM.ttc" 2>nul
del "%SysFontsDir%YuGothR.ttc" 2>nul
del "%SysFontsDir%yumin.ttf" 2>nul
del "%SysFontsDir%yumindb.ttf" 2>nul
del "%SysFontsDir%yuminl.ttf" 2>nul
del "%SysFontsDir%verdana.ttf" 2>nul
del "%SysFontsDir%verdanab.ttf" 2>nul
del "%SysFontsDir%verdanaz.ttf" 2>nul
del "%SysFontsDir%verdanai.ttf" 2>nul
del "%SysFontsDir%Nirmala.ttc" 2>nul

REM --- 使用 XCOPY 强制覆盖复制字体文件 ---
REM /Y - 覆盖时不提示确认
REM /R - 覆盖只读文件
REM /H - 复制隐藏和系统文件
REM /C - 即使出错也继续复制
REM /E - 复制所有子目录（即使是空的）
REM 2>&1 - 将标准错误输出重定向到标准输出，再一并写入日志
echo 正在尝试覆盖 .ttf/.otf 和 .ttc/.otc 文件... >> "%LogFile%"
xcopy "%SourceDir%\*.*tf" "%TargetDir%\" /Y /R /H /C /E >> "%LogFile%" 2>&1
xcopy "%SourceDir%\*.*tc" "%TargetDir%\" /Y /R /H /C /E >> "%LogFile%" 2>&1

goto :Finish

REM ============================================================
REM 同步模式：仅复制目标目录中不存在的字体文件
REM ============================================================
:SyncOnlyMode

echo 正在进入【仅同步缺失字体模式】... >> "%LogFile%"

REM 遍历源目录中的字体文件，仅当目标目录中不存在同名文件时才复制。
REM *.*tf 匹配扩展名为 .ttf 和 .otf 的字体文件。
REM *.*tc 匹配扩展名为 .ttc 和 .otc 的字体文件。
for %%F in ("%SourceDir%\*.*tf" "%SourceDir%\*.*tc") do (
    if not exist "%TargetDir%\%%~nxF" (
        echo 复制缺失字体: %%~nxF >> "%LogFile%"
        copy "%%F" "%TargetDir%\" >> "%LogFile%" 2>&1
    ) else (
        echo 已存在，跳过: %%~nxF >> "%LogFile%"
    )
)

goto :Finish

REM ============================================================
REM 任务结束：记录结束时间并退出
REM ============================================================
:Finish

echo. >> "%LogFile%"
echo ================================================= >> "%LogFile%"
echo  任务执行完毕于: %date% %time% >> "%LogFile%"
echo ================================================= >> "%LogFile%"

exit /b 0

REM ============================================================
REM 使用说明：当用户输入 --help 时显示
REM ============================================================
:ShowUsage

echo.
echo ============================================================
echo  ReplaceSystemFonts.bat 使用说明
echo ============================================================
echo.
echo 用途：
echo   将源目录中的字体文件同步或替换到目标字体目录。
echo.
echo 当前配置：
echo   源目录:  %SourceDir%
echo   目标目录: %TargetDir%
echo   日志文件: %LogFile%
echo.
echo 用法：
echo   ReplaceSystemFonts.bat [参数]
echo.
echo 参数：
echo   --sync-only    仅复制目标目录中不存在的字体文件，
echo                  不删除任何现有字体，也不会覆盖已有文件。
echo   --help         显示本帮助信息并退出，不执行任何文件操作。
echo.
echo 示例：
echo   ReplaceSystemFonts.bat
echo       默认模式：删除预定义的 Windows 系统字体，然后强制
echo       覆盖复制源目录中的所有字体文件。
echo.
echo   ReplaceSystemFonts.bat --sync-only
echo       同步模式：仅复制目标目录中缺失的字体文件。
echo.
echo   ReplaceSystemFonts.bat --help
echo       仅显示本帮助信息。
echo.
echo ============================================================

goto :eof
