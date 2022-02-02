@echo off
set titl=糖糕云MC一键启动脚本-任渊生存
title %titl% 初始化中
cd /d "%~dp0"
set INFO=[Client thread／INFO]：
set WARN=[Client thread／WARN]：
set INPUT=[Client thread／INPUT]：
set FATAL=[Client thread／FATAL]：
echo %INFO%初始化中
set GUIControl=nogui
set ServerCore=Paper-1.17.1.jar
set ServerCoreName=%ServerCore:.jar=%
set ServerCoreName=%ServerCoreName:-=%
set Times=0
set DividingLine=-----------------------------------------------------
set Port= 端口:
set Tasktime=7
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "DEL=%%a"
if not exist ConfigProgress.txt set LunchMode=First && goto FirstLunch
for /f "tokens=1,* delims==" %%a in ('findstr "ConfigSet=" "ConfigProgress.txt"') do set ConfigSet=%%b
if %ConfigSet% == false set LunchMode=Incomplete && goto FirstLunch
goto ConfigReader


:Main
echo %INFO%%DividingLine%
title %titl% %ServerCoreName%
if %AutoRestart% == true title %titl% %ServerCoreName%%Port%%ServerPort% 重启次数:0
echo %INFO%非紧急情况不建议直接关闭控制台
echo %INFO%在控制台输入stop然后回车即可关服
echo %INFO%%DividingLine%
echo %INFO%本脚本为 糖糕云 一键启动脚本魔改版
echo %INFO%版本:1.3-Beta[由原版1.3魔改]
echo %INFO%原作者: 梦想小站
echo %INFO%原版GitHub: https://github.com/dreamstation625/AutoMCServerBat
if %AutoMemSet% == false goto EarlyMemCheck
set CheckStatus=EarlyMemCheck && goto MemCheck
:EarlyMemCheck
if %ServerGUI% == true set GUIControl= 
if %EarlyLunchWait% equ 0 goto GetJavaVersion
echo %INFO%服务端将在%EarlyLunchWait%秒后启动
for /l %%a in (1,1,%EarlyLunchWait%) do (ping -n 2 -w 500 0.0.0.1>nul)

if not exist eula.txt goto EulaTask
for /f "tokens=1,* delims==" %%a in ('findstr "eula=" "eula.txt"') do set eula=%%b
if %eula% == true goto GetJavaVersion
:EulaTask
echo %INFO%%DividingLine%
call :ColorText 0E "%WARN%等等！" && echo.
call :ColorText 0E "%WARN%在服务端运行前,你还要同意Minecraft EULA " && echo.
echo %INFO%查看EULA请前往 https://account.mojang.com/documents/minecraft_eula
echo %INFO%在此处按任意键表示同意Minecraft EULA并启动服务端
pause>nul
echo eula=true>eula.txt
echo %INFO%你同意了Minecraft EULA,服务端即将启动


:GetJavaVersion
cd lib
if %EarlyLunchWait% LSS 7 (set Tasktime-=%EarlyLunchWait%) else (set Tasktime=1)
for /l %%a in (1,1,%Tasktime%) do (ping -n 2 -w 500 0.0.0.1>nul
if exist JavaVersion.txt goto JavaTask)
goto ERROREXIT
:JavaTask
for /f "tokens=1,* delims==" %%a in ('findstr "Version=" "JavaVersion.txt"') do (set JavaVersion=%%b)
echo %INFO%Java版本:%JavaVersion%
cd..

:Loop
echo %DividingLine%
echo loading %ServerCoreName%, please wait...
.\Java\bin\java.exe -Xms%MinMem%M -Xmx%UserRam%M -jar %ServerCore% %GUIControl%
echo #
echo %DividingLine%
echo %INFO%服务端已经关闭
if %AutoRestart% == false goto CmdExit
if %RestartWait% equ 0 goto Restart
for /l %%b in (%RestartWait%,-1,1) do (echo %INFO%服务端将在%%b秒后重启
ping -n 2 -w 500 0.0.0.1>nul)
:Restart
echo %INFO%服务端重启中
set /a Times+=1
title %titl% %ServerCoreName%%Port%%ServerPort% 重启次数:%Times% 
if %AutoMemSet% == false goto MainMemCheck
set CheckStatus=MainMemCheck && goto MemCheck
:MainMemCheck
goto Loop



:MemCheck
echo %INFO%%DividingLine%
for /f "delims=" %%a in ('wmic os get TotalVisibleMemorySize /value^|find "="') do set %%a
set /a t1=%TotalVisibleMemorySize%,t2=1024
set /a ram=%t1%/%t2%
for /f "delims=" %%b in ('wmic os get FreePhysicalMemory /value^|find "="') do set %%b
set /a t3=%FreePhysicalMemory%
set /a freeram=%t3%/%t2%
echo %INFO%系统最大内存为：%ram% MB，剩余可用内存为：%freeram% MB
set /a UserRam=%freeram%-%SysMem%
if %UserRam% LSS 1024 (call :ColorText 0E "%WARN%剩余可用内存可能不足以开启服务端或者开启后卡顿" && echo.
set /a UserRam=1024)
echo %INFO%本次开服将分配最大 %UserRam% MB
goto %CheckStatus%

:CmdExit
echo %INFO%按任意键退出 && pause>nul 
exit




:FirstLunch
title %titl% 配置中
if %LunchMode% == First echo %INFO%检测到第一次启动
if %LunchMode% == Incomplete echo %INFO%检测到未配置完成
echo %INFO%请设置配置文件

:ModeSelect
echo %INFO%%DividingLine%
echo #配置文件,请勿随意删除>config.txt
echo #如需重新配置启动器设置清删除ConfigProgress.txt>>config.txt
echo #配置文件,请勿随意删除>ConfigProgress.txt
echo #如需重新配置启动器设置清删除本文件>>ConfigProgress.txt
echo ConfigSet=false>>ConfigProgress.txt
echo %INFO%在配置完成后请勿删除ConfigProgress.txt,否则会导致配置丢失
echo %INFO%如需重新配置启动器设置清删除ConfigProgress.txt
echo %INFO%%DividingLine%
echo %INFO%请选择配置模式(在下方输入序号)
echo %INFO%1.默认模式(全部使用默认配置,适合第一次开服的腐竹)
echo %INFO%2.高级模式(全部配置自定义,适合熟练开服的腐竹)
set /p ConfigMode=%INPUT%
if %ConfigMode% equ 1 goto Default
if %ConfigMode% equ 2 goto AutoMemset
echo %INFO%请输入正确的模式
goto ModeSelect


:Default
title %titl% 配置中-默认模式
echo AutoMemSet=true >>config.txt
echo SysMem=768 >>config.txt
echo MinMem=128 >>config.txt
echo AutoRestart=true >>config.txt
echo RestartWait=10 >>config.txt
echo EarlyLunchWait=5 >>config.txt
echo LogAutoRemove=false >>config.txt
echo ServerGUI=false >>config.txt
goto ConfigProgress

:AutoMemSet
title %titl% 配置中-高级模式
echo %INFO%%DividingLine%
echo %INFO%是否自动分配内存(配置名:AutoMemSet)(默认:1)
echo %INFO%1.是			2.否
set /p InputSub=%INPUT%
if %InputSub% equ 1 echo AutoMemSet=true >>config.txt && goto SysMem
if %InputSub% equ 2 echo AutoMemSet=false >>config.txt && goto UserRam
echo %INFO%请输入正确的选项
goto AutoMemSet

:SysMem
echo %INFO%%DividingLine%
echo %INFO%预留内存大小(配置名:SysMem)(默认:768)
echo %INFO%输入数字大小(单位:MB),输入0即不预留
set /p InputSub=%INPUT%
if %InputSub% geq 0 echo SysMem=%InputSub% >>config.txt && goto MinMem
echo %INFO%请输入正确的数字
goto SysMem

:UserRam
echo %INFO%%DividingLine%
echo %INFO%分配最大内存大小(配置名:UserRam)(默认:2048)
echo %INFO%输入数字大小(单位:MB),建议大于1024
set /p InputSub=%INPUT%
if %InputSub% geq 1 echo UserRam=%InputSub% >>config.txt && goto MinMem
echo %INFO%请输入正确的数字
goto UserRam

:MinMem
echo %INFO%%DividingLine%
echo %INFO%分配最小内存大小(配置名:MinMem)(默认:128)
echo %INFO%输入数字大小(单位:MB),输入0以设置与最大内存相同
set /p InputSub=%INPUT%
if %InputSub% geq 0 echo MinMem=%InputSub% >>config.txt && goto AutoRestart
echo %INFO%请输入正确的数字
goto MinMem

:AutoRestart
echo %INFO%%DividingLine%
echo %INFO%是否开启自动重启(配置名:AutoRestart)(默认:1)
echo %INFO%1.是			2.否
set /p InputSub=%INPUT%
if %InputSub% equ 1 echo AutoRestart=true >>config.txt && goto RestartWait
if %InputSub% equ 2 echo AutoRestart=false >>config.txt && goto EarlyLunchWait
echo %INFO%请输入正确的选项
goto AutoRestart

:RestartWait
echo %INFO%%DividingLine%
echo %INFO%自动重启等待时间(配置名:RestartWait)(默认:10)
echo %INFO%输入数字大小(单位:秒)输入0以跳过等待,最大300
set /p InputSub=%INPUT%
if %InputSub% geq 0 if %InputSub% leq 300 echo RestartWait=%InputSub% >>config.txt && goto EarlyLunchWait
echo %INFO%请输入正确的数字
goto RestartWait

:EarlyLunchWait
echo %INFO%%DividingLine%
echo %INFO%开服等待时间(配置名:EarlyLunchWait)(默认:5)
echo %INFO%输入数字大小(单位:秒)输入0以跳过等待,最大300
set /p InputSub=%INPUT%
if %InputSub% geq 0 if %InputSub% leq 300 echo EarlyLunchWait=%InputSub% >>config.txt && goto LogAutoRemove
echo %INFO%请输入正确的数字
goto EarlyLunchWait

:LogAutoRemove
echo %INFO%%DividingLine%
echo %INFO%自动清除日志(配置名:LogAutoRemove)(默认:2)
echo %INFO%1.是			2.否
set /p InputSub=%INPUT%
if %InputSub% equ 1 echo LogAutoRemove=true >>config.txt && goto ServerGUI
if %InputSub% equ 2 echo LogAutoRemove=false >>config.txt && goto ServerGUI
echo %INFO%请输入正确的选项
goto LogAutoRemove

:ServerGUI
echo %INFO%%DividingLine%
echo %INFO%是否开启服务器核心GUI(配置名:ServerGUI)(默认:2)
echo %INFO%1.是			2.否
set /p InputSub=%INPUT%
if %InputSub% equ 1 echo ServerGUI=true >>config.txt && goto ConfigProgress
if %InputSub% equ 2 echo ServerGUI=false >>config.txt && goto ConfigProgress
echo %INFO%请输入正确的选项
goto ServerGUI

:ConfigProgress
echo #配置文件,请勿删除>ConfigProgress.txt
echo #如需重新配置清删除本文件>>ConfigProgress.txt
echo ConfigSet=true>>ConfigProgress.txt
echo %INFO%%DividingLine%
echo %INFO%配置完成



:ConfigReader
echo %INFO%开始读取配置文件
echo %INFO%%DividingLine%

for /f "tokens=1,* delims==" %%a in ('findstr "AutoMemSet=" "config.txt"') do (set AutoMemSet=%%b)
set AutoMemSet=%AutoMemSet: =%
set AutoMemSetOut=%AutoMemSet:true=开启%
set AutoMemSetOut=%AutoMemSetOut:false=关闭%
echo %INFO%自动设置内存:%AutoMemSetOut%
if %AutoMemSet% == false goto ConfigReaderMem

for /f "tokens=1,* delims==" %%a in ('findstr "SysMem=" "config.txt"') do (set SysMem=%%b)
set SysMem=%SysMem: =%
echo %INFO%开服内存预留:%SysMem%MB
goto ConfigReader2

:ConfigReaderMem
for /f "tokens=1,* delims==" %%a in ('findstr "UserRam=" "config.txt"') do (set UserRam=%%b)
set UserRam=%UserRam: =%
echo %INFO%内存设置:%UserRam%MB

:ConfigReader2
for /f "tokens=1,* delims==" %%a in ('findstr "MinMem=" "config.txt"') do (set MinMem=%%b)
set MinMem=%MinMem: =%
echo %INFO%最小内存:%MinMem%MB

for /f "tokens=1,* delims==" %%a in ('findstr "AutoRestart=" "config.txt"') do (set AutoRestart=%%b)
set AutoRestart=%AutoRestart: =%
set AutoMemSetOut=%AutoMemSet:true=开启%
set AutoMemSetOut=%AutoMemSetOut:false=关闭%
echo %INFO%自动重启:%AutoMemSetOut%

if %AutoRestart% == false goto ConfigReader3
for /f "tokens=1,* delims==" %%a in ('findstr "RestartWait=" "config.txt"') do (set RestartWait=%%b)
set RestartWait=%RestartWait: =%
echo %INFO%重启等待时间:%RestartWait%s

:ConfigReader3
for /f "tokens=1,* delims==" %%a in ('findstr "LogAutoRemove=" "config.txt"') do (set LogAutoRemove=%%b)
set LogAutoRemove=%LogAutoRemove: =%
set LogAutoRemoveOut=%LogAutoRemove:true=开启%
set LogAutoRemoveOut=%LogAutoRemoveOut:false=关闭%
echo %INFO%自动清除日志:%LogAutoRemoveOut%

for /f "tokens=1,* delims==" %%a in ('findstr "EarlyLunchWait=" "config.txt"') do (set EarlyLunchWait=%%b)
set EarlyLunchWait=%EarlyLunchWait: =%
echo %INFO%启动前等待:%EarlyLunchWait%s

for /f "tokens=1,* delims==" %%a in ('findstr "ServerGUI=" "config.txt"') do (set ServerGUI=%%b)
set ServerGUI=%ServerGUI: =%
set ServerGUIOut=%ServerGUI:true=开启%
set ServerGUIOut=%ServerGUIOut:false=关闭%
echo %INFO%服务器核心GUI:%ServerGUIOut%

if not exist server.properties set Port= && goto main
echo %INFO%%DividingLine%
echo %INFO%开始读取服务器信息
for /f "tokens=1,* delims==" %%a in ('findstr "server-port=" "server.properties"') do (set ServerPort=%%b)
set ServerPort=%ServerPort: =%
echo %INFO%端口:%ServerPort%

cd lib
start wscript -e:vbs JavaTask.vbs
cd..

goto Main

:ERROREXIT
call :ColorText 0C "%FATAL%启动器遇到致命错误,无法继续运行,这可能是一个BUG" && echo.
call :ColorText 0C "%FATAL%BUG报告请前往启动器脚本的github页面或添加QQ1593713272" && echo.
call :ColorText 0C "%FATAL%按任意键退出"
pause>nul
exit

:ColorText
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1













