@echo off
chcp 936>nul
cd /d "%~dp0"
call :clsLogo
set titl=黎明MC一键启动脚本
set INFO=[Server Client thread／INFO]：
set WARN=[Server Client thread／WARN]：
set ERROR=[Server Client thread／ERROR]：
set INPUT=[Server Client thread／INPUT]：
set DEBUG=[Server Client thread／DEBUG]：
set LOG=[Server Client thread／LOG]：
set Line=-----------------------------------------------------
call :LogSystemLoader
title %titl% 初始化中
call :echo "%INFO%初始化中"
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "DEL=%%a"

call :DefaultConfigSet
call :ConfigLoader
call :ConfigReader

if not exist "%~dp0\client\java.path" call :echo "%INFO%找不到Java列表,尝试获取中" && call :JavaCheck
set /a JavaListid=0
for /f "delims=[" %%a in (%~dp0\client\java.path) do (
    if !JavaListid! == %JavaId% set Java=%%a
    set /a JavaListid+=1
)

for /l %%a in (1,1,3) do (ping -n 2 -w 500 0.0.0.1>nul)

:ControlPanel
call :clsLogo
set ConfigMode=0
call :echo "%INFO%%Line%"
call :echo "%INFO%1：启动服务器"
call :echo "%INFO%2：Java选择"
call :echo "%INFO%%Line%"
set /p ConfigMode=%INPUT%
call :Log "用户输入：%ConfigMode%"
if %ConfigMode% equ 1 call :StartServer
if %ConfigMode% equ 2 call :JavaControlPanel
echo %INFO%请输入正确的选项
for /l %%a in (1,1,1) do (ping -n 2 -w 500 0.0.0.1>nul)
goto ControlPanel


:: 模块
goto exit



:: Java控制面板
:JavaControlPanel
call :clsLogo
set /a JavaListid=0
call :echo "%INFO%%Line%"
call :echo "%INFO%正在读取Java列表,请稍后"
for /f "delims=[" %%a in (%~dp0\client\java.path) do (
    call :echo "%INFO%!JavaListid!：%%a"
    set /a JavaListid+=1
)
call :echo "%INFO%%Line%"
pause>nul
goto exit


:: 启动服务器
:StartServer
call :clsLogo
call :MemoryCheck
call :Log "启动服务端,参数: %Java% -Xms%MinMem%M -Xmx%UserRam%M -jar %ServerJar%"
call :Log "当前时间 %date% %time%"
%Java% -Xms%MinMem%M -Xmx%UserRam%M -jar %ServerJar%
if %ERRORLEVEL% neq 0 call :Log "服务端异常崩溃,错误码:%ERRORLEVEL%,当前时间 %date% %time%"
pause>nul
goto exit



:: 获取Java列表并储存
:JavaCheck
:: 固定工作路径
cd "%~dp0\client"
:: 重置Java路径列表
echo. >java.path
:: 初始化首个Java路径检测
set Java=".\Java\bin\java.exe"
:: 初始化检测次数
set checkTimes = 0
:JavaTask
:: 检测次数+1并循环
set /a checkTimes += 1
:: 调用Java -version命令并获取其errorlevel
%Java% -version >nul 2>&1
:: 如果errorlevel为0则写入Java列表,并且将java状态设置为已检测
if %ERRORLEVEL% equ 0 set getJava=true && echo %Java%>>java.path
:: 可能的Java路径
if %checkTimes% equ 1 set Java="java" && goto JavaTask
if %checkTimes% equ 2 set Java="%JAVA_HOME%\java.exe" && goto JavaTask
if %checkTimes% equ 3 set Java="C:\Java\bin\java.exe" && goto JavaTask
if %checkTimes% equ 4 set Java="C:\Java\Java7\bin\java.exe" && goto JavaTask
if %checkTimes% equ 5 set Java="C:\Java\Java8\bin\java.exe" && goto JavaTask
if %checkTimes% equ 6 set Java="C:\Java\Java9\bin\java.exe" && goto JavaTask
if %checkTimes% equ 7 set Java="C:\Java\Java11\bin\java.exe" && goto JavaTask
if %checkTimes% equ 8 set Java="C:\Java\Java15\bin\java.exe" && goto JavaTask
if %checkTimes% equ 9 set Java="C:\Java\Java16\bin\java.exe" && goto JavaTask
if %checkTimes% equ 10 set Java="C:\Java\Java17\bin\java.exe" && goto JavaTask
if %checkTimes% equ 11 set Java="C:\Java\Java18\bin\java.exe" && goto JavaTask
if %checkTimes% equ 12 set Java="C:\Java7\bin\java.exe" && goto JavaTask
if %checkTimes% equ 13 set Java="C:\Java8\bin\java.exe" && goto JavaTask
if %checkTimes% equ 14 set Java="C:\Java9\bin\java.exe" && goto JavaTask
if %checkTimes% equ 15 set Java="C:\Java11\bin\java.exe" && goto JavaTask
if %checkTimes% equ 16 set Java="C:\Java15\bin\java.exe" && goto JavaTask
if %checkTimes% equ 17 set Java="C:\Java16\bin\java.exe" && goto JavaTask
if %checkTimes% equ 18 set Java="C:\Java17\bin\java.exe" && goto JavaTask
if %checkTimes% equ 19 set Java="C:\Java18\bin\java.exe" && goto JavaTask
if %checkTimes% equ 20 set Java="D:\Java\bin\java.exe" && goto JavaTask
if %checkTimes% equ 21 set Java="D:\Java\Java7\bin\java.exe" && goto JavaTask
if %checkTimes% equ 22 set Java="D:\Java\Java8\bin\java.exe" && goto JavaTask
if %checkTimes% equ 23 set Java="D:\Java\Java9\bin\java.exe" && goto JavaTask
if %checkTimes% equ 24 set Java="D:\Java\Java11\bin\java.exe" && goto JavaTask
if %checkTimes% equ 25 set Java="D:\Java\Java15\bin\java.exe" && goto JavaTask
if %checkTimes% equ 26 set Java="D:\Java\Java16\bin\java.exe" && goto JavaTask
if %checkTimes% equ 27 set Java="D:\Java\Java17\bin\java.exe" && goto JavaTask
if %checkTimes% equ 28 set Java="D:\Java\Java18\bin\java.exe" && goto JavaTask
if %checkTimes% equ 29 set Java="D:\Java7\bin\java.exe" && goto JavaTask
if %checkTimes% equ 30 set Java="D:\Java8\bin\java.exe" && goto JavaTask
if %checkTimes% equ 31 set Java="D:\Java9\bin\java.exe" && goto JavaTask
if %checkTimes% equ 32 set Java="D:\Java11\bin\java.exe" && goto JavaTask
if %checkTimes% equ 33 set Java="D:\Java15\bin\java.exe" && goto JavaTask
if %checkTimes% equ 34 set Java="D:\Java16\bin\java.exe" && goto JavaTask
if %checkTimes% equ 35 set Java="D:\Java17\bin\java.exe" && goto JavaTask
if %checkTimes% equ 36 set Java="D:\Java18\bin\java.exe" && goto JavaTask
cd ..
goto exit




:: 获取可用内存
:MemoryCheck
call :echo "%INFO%%Line%"
:: 代码来自 https://github.com/dreamstation625/AutoMCServerBat
for /f "delims=" %%a in ('wmic os get TotalVisibleMemorySize /value^|find "="') do set %%a
set /a t1=%TotalVisibleMemorySize%,t2=1024
set /a ram=%t1%/%t2%
for /f "delims=" %%b in ('wmic os get FreePhysicalMemory /value^|find "="') do set %%b
set /a t3=%FreePhysicalMemory%
set /a freeram=%t3%/%t2%
:: 输出内存信息
call :echo "%INFO%系统最大内存为：%ram% MB，剩余可用内存为：%freeram% MB"
set /a UserRam=%freeram%-%SysMem%
:: 检测内存空余并警告
if %UserRam% lss 1024 (
    call :ColorText 0E "%WARN%剩余可用内存可能不足以开启服务端或者开启后卡顿" && echo.
    set /a UserRam=1024
)
:: 防止分配过多内存
if %UserRam% gtr 16384 set /a UserRam=16384
:: 输出最终分配的内存
call :echo "%INFO%本次开服将分配最大 %UserRam% MB"
call :echo "%INFO%%Line%"
goto exit




:: 检测配置文件是否存在
:ConfigLoader
:: 检测启动器文件夹
if not exist "%~dp0\client" set lunchMode=First && goto FirstLunch
:: 检测启动器配置状态文件
if not exist "%~dp0\client\progress.properties" set lunchMode=Incomplete && goto FirstLunch
:: 获取启动器配置文件状态
for /f "tokens=1,* delims==" %%a in ('findstr "ConfigSet=" "%~dp0\client\progress.properties"') do set ConfigSet=%%b
:: 检测启动器配置文件状态
if %ConfigSet% == false set lunchMode=Incomplete && goto FirstLunch
goto exit




:: 首次启动的配置
:FirstLunch
:: 如果不存在启动器文件夹则创建
if not exist "%~dp0\client" mkdir "%~dp0\client"
cd client
:: 检测LunchMode并且输出
if %LunchMode% == First call :echo "%INFO%检测到第一次启动,正在准备配置文件"
if %LunchMode% == Incomplete call :echo "%INFO%检测到未配置完成,正在准备配置文件"
:: 检测Java列表
call :echo "%INFO%检测Java中"
:: 检测Java列表
call :JavaCheck
echo #配置文件,请勿随意删除>progress.properties
echo #如需重新配置启动器设置清删除本文件>>progress.properties
echo ConfigSet=true>>progress.properties
cd..
goto exit




:: 清屏并输出Logo
:clsLogo
cls
echo  _____                          _____                             _____ _ _            _   
echo ^|  __ \                        / ____^|                           / ____^| (_)          ^| ^|  
echo ^| ^|  ^| ^| __ ___      ___ __   ^| (___   ___ _ ____   _____ _ __  ^| ^|    ^| ^|_  ___ _ __ ^| ^|_ 
echo ^| ^|  ^| ^|/ _` \ \ /\ / / '_ \   \___ \ / _ \ '__\ \ / / _ \ '__^| ^| ^|    ^| ^| ^|/ _ \ '_ \^| __^|
echo ^| ^|__^| ^| (_^| ^|\ V  V /^| ^| ^| ^|  ____) ^|  __/ ^|   \ V /  __/ ^|    ^| ^|____^| ^| ^|  __/ ^| ^| ^| ^|_ 
echo ^|_____/ \__,_^| \_/\_/ ^|_^| ^|_^| ^|_____/ \___^|_^|    \_/ \___^|_^|     \_____^|_^|_^|\___^|_^| ^|_^|\__^|  
echo. 
goto exit



:: 输出彩色字体
:ColorText
:: 记录日志
echo %~2 >>client\log\latest.log
:: 输出彩色字体
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto exit



:: 日志记录
:Log
echo %LOG%%~1 >>client\log\latest.log
goto exit



:: 带日志记录的输出
:Echo
:: 记录日志
echo %~1 >>client\log\latest.log
:: 输出
echo %~1
goto exit



:: 设置默认的配置
:DefaultConfigSet
set AutoMemset=true
set SysMem=768
set MinMem=128
set ServerJar=server.jar
set JavaId=0
set ServerJarName=%ServerJar:.jar=%
goto exit




:: 配置文件读取(WIP)
:ConfigReader
goto exit



:: 初始化日志系统
:LogSystemLoader
:: 创建日志文件夹
if not exist "%~dp0\client\log" mkdir "%~dp0\client\log"
:: 获取日期和时间
set dateNow=%date:~0,10%
set dateNow=%dateNow:/=-%
set dateNow=%dateNow: =%
set timeNow=%time%
set timeNow=%timeNow::=%
set timeNow=%timeNow:.=%
set timeNow=%timeNow: =%
:: 检测是否存在上一次的日志
if exist "%~dp0\client\log\latest.log" (
    ::将日志改名
    ren "%~dp0\client\log\latest.log" %dateNow%_%timeNow%.log
    :: 打包压缩日志
    makecab "%~dp0\client\log\%dateNow%_%timeNow%.log" "%~dp0\client\log\%dateNow%_%timeNow%.cab" >nul 2>&1
    :: 删除原日志
    del "%~dp0\client\log\%dateNow%_%timeNow%.log"
)
:: 初始化新日志输出
call :Log "当前时间 %date% %time%"
call :echo "%INFO%日志系统加载完成"
goto exit


:exit