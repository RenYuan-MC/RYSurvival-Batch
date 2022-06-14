@echo off
chcp 936>nul
cd /d "%~dp0"
call :clsLogo
set titl=����MCһ�������ű�
set INFO=[Server Client thread��INFO]��
set WARN=[Server Client thread��WARN]��
set ERROR=[Server Client thread��ERROR]��
set INPUT=[Server Client thread��INPUT]��
set DEBUG=[Server Client thread��DEBUG]��
set LOG=[Server Client thread��LOG]��
set Line=-----------------------------------------------------
call :LogSystemLoader
title %titl% ��ʼ����
call :echo "%INFO%��ʼ����"
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "DEL=%%a"

call :DefaultConfigSet
call :ConfigLoader
call :ConfigReader

if not exist "%~dp0\client\java.path" call :echo "%INFO%�Ҳ���Java�б�,���Ի�ȡ��" && call :JavaCheck
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
call :echo "%INFO%1������������"
call :echo "%INFO%2��Javaѡ��"
call :echo "%INFO%%Line%"
set /p ConfigMode=%INPUT%
call :Log "�û����룺%ConfigMode%"
if %ConfigMode% equ 1 call :StartServer
if %ConfigMode% equ 2 call :JavaControlPanel
echo %INFO%��������ȷ��ѡ��
for /l %%a in (1,1,1) do (ping -n 2 -w 500 0.0.0.1>nul)
goto ControlPanel


:: ģ��
goto exit



:: Java�������
:JavaControlPanel
call :clsLogo
set /a JavaListid=0
call :echo "%INFO%%Line%"
call :echo "%INFO%���ڶ�ȡJava�б�,���Ժ�"
for /f "delims=[" %%a in (%~dp0\client\java.path) do (
    call :echo "%INFO%!JavaListid!��%%a"
    set /a JavaListid+=1
)
call :echo "%INFO%%Line%"
pause>nul
goto exit


:: ����������
:StartServer
call :clsLogo
call :MemoryCheck
call :Log "���������,����: %Java% -Xms%MinMem%M -Xmx%UserRam%M -jar %ServerJar%"
call :Log "��ǰʱ�� %date% %time%"
%Java% -Xms%MinMem%M -Xmx%UserRam%M -jar %ServerJar%
if %ERRORLEVEL% neq 0 call :Log "������쳣����,������:%ERRORLEVEL%,��ǰʱ�� %date% %time%"
pause>nul
goto exit



:: ��ȡJava�б�����
:JavaCheck
:: �̶�����·��
cd "%~dp0\client"
:: ����Java·���б�
echo. >java.path
:: ��ʼ���׸�Java·�����
set Java=".\Java\bin\java.exe"
:: ��ʼ��������
set checkTimes = 0
:JavaTask
:: ������+1��ѭ��
set /a checkTimes += 1
:: ����Java -version�����ȡ��errorlevel
%Java% -version >nul 2>&1
:: ���errorlevelΪ0��д��Java�б�,���ҽ�java״̬����Ϊ�Ѽ��
if %ERRORLEVEL% equ 0 set getJava=true && echo %Java%>>java.path
:: ���ܵ�Java·��
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




:: ��ȡ�����ڴ�
:MemoryCheck
call :echo "%INFO%%Line%"
:: �������� https://github.com/dreamstation625/AutoMCServerBat
for /f "delims=" %%a in ('wmic os get TotalVisibleMemorySize /value^|find "="') do set %%a
set /a t1=%TotalVisibleMemorySize%,t2=1024
set /a ram=%t1%/%t2%
for /f "delims=" %%b in ('wmic os get FreePhysicalMemory /value^|find "="') do set %%b
set /a t3=%FreePhysicalMemory%
set /a freeram=%t3%/%t2%
:: ����ڴ���Ϣ
call :echo "%INFO%ϵͳ����ڴ�Ϊ��%ram% MB��ʣ������ڴ�Ϊ��%freeram% MB"
set /a UserRam=%freeram%-%SysMem%
:: ����ڴ���ಢ����
if %UserRam% lss 1024 (
    call :ColorText 0E "%WARN%ʣ������ڴ���ܲ����Կ�������˻��߿����󿨶�" && echo.
    set /a UserRam=1024
)
:: ��ֹ��������ڴ�
if %UserRam% gtr 16384 set /a UserRam=16384
:: ������շ�����ڴ�
call :echo "%INFO%���ο������������ %UserRam% MB"
call :echo "%INFO%%Line%"
goto exit




:: ��������ļ��Ƿ����
:ConfigLoader
:: ����������ļ���
if not exist "%~dp0\client" set lunchMode=First && goto FirstLunch
:: �������������״̬�ļ�
if not exist "%~dp0\client\progress.properties" set lunchMode=Incomplete && goto FirstLunch
:: ��ȡ�����������ļ�״̬
for /f "tokens=1,* delims==" %%a in ('findstr "ConfigSet=" "%~dp0\client\progress.properties"') do set ConfigSet=%%b
:: ��������������ļ�״̬
if %ConfigSet% == false set lunchMode=Incomplete && goto FirstLunch
goto exit




:: �״�����������
:FirstLunch
:: ����������������ļ����򴴽�
if not exist "%~dp0\client" mkdir "%~dp0\client"
cd client
:: ���LunchMode�������
if %LunchMode% == First call :echo "%INFO%��⵽��һ������,����׼�������ļ�"
if %LunchMode% == Incomplete call :echo "%INFO%��⵽δ�������,����׼�������ļ�"
:: ���Java�б�
call :echo "%INFO%���Java��"
:: ���Java�б�
call :JavaCheck
echo #�����ļ�,��������ɾ��>progress.properties
echo #������������������������ɾ�����ļ�>>progress.properties
echo ConfigSet=true>>progress.properties
cd..
goto exit




:: ���������Logo
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



:: �����ɫ����
:ColorText
:: ��¼��־
echo %~2 >>client\log\latest.log
:: �����ɫ����
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto exit



:: ��־��¼
:Log
echo %LOG%%~1 >>client\log\latest.log
goto exit



:: ����־��¼�����
:Echo
:: ��¼��־
echo %~1 >>client\log\latest.log
:: ���
echo %~1
goto exit



:: ����Ĭ�ϵ�����
:DefaultConfigSet
set AutoMemset=true
set SysMem=768
set MinMem=128
set ServerJar=server.jar
set JavaId=0
set ServerJarName=%ServerJar:.jar=%
goto exit




:: �����ļ���ȡ(WIP)
:ConfigReader
goto exit



:: ��ʼ����־ϵͳ
:LogSystemLoader
:: ������־�ļ���
if not exist "%~dp0\client\log" mkdir "%~dp0\client\log"
:: ��ȡ���ں�ʱ��
set dateNow=%date:~0,10%
set dateNow=%dateNow:/=-%
set dateNow=%dateNow: =%
set timeNow=%time%
set timeNow=%timeNow::=%
set timeNow=%timeNow:.=%
set timeNow=%timeNow: =%
:: ����Ƿ������һ�ε���־
if exist "%~dp0\client\log\latest.log" (
    ::����־����
    ren "%~dp0\client\log\latest.log" %dateNow%_%timeNow%.log
    :: ���ѹ����־
    makecab "%~dp0\client\log\%dateNow%_%timeNow%.log" "%~dp0\client\log\%dateNow%_%timeNow%.cab" >nul 2>&1
    :: ɾ��ԭ��־
    del "%~dp0\client\log\%dateNow%_%timeNow%.log"
)
:: ��ʼ������־���
call :Log "��ǰʱ�� %date% %time%"
call :echo "%INFO%��־ϵͳ�������"
goto exit


:exit