@echo off
set titl=�Ǹ���MCһ�������ű�-��Ԩ����
title %titl% ��ʼ����
cd /d "%~dp0"
set INFO=[Client thread��INFO]��
set WARN=[Client thread��WARN]��
set INPUT=[Client thread��INPUT]��
set FATAL=[Client thread��FATAL]��
echo %INFO%��ʼ����
set GUIControl=nogui
set ServerCore=Paper-1.17.1.jar
set ServerCoreName=%ServerCore:.jar=%
set ServerCoreName=%ServerCoreName:-=%
set Times=0
set DividingLine=-----------------------------------------------------
set Port= �˿�:
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
if %AutoRestart% == true title %titl% %ServerCoreName%%Port%%ServerPort% ��������:0
echo %INFO%�ǽ������������ֱ�ӹرտ���̨
echo %INFO%�ڿ���̨����stopȻ��س����ɹط�
echo %INFO%%DividingLine%
echo %INFO%���ű�Ϊ �Ǹ��� һ�������ű�ħ�İ�
echo %INFO%�汾:1.3-Beta[��ԭ��1.3ħ��]
echo %INFO%ԭ����: ����Сվ
echo %INFO%ԭ��GitHub: https://github.com/dreamstation625/AutoMCServerBat
if %AutoMemSet% == false goto EarlyMemCheck
set CheckStatus=EarlyMemCheck && goto MemCheck
:EarlyMemCheck
if %ServerGUI% == true set GUIControl= 
if %EarlyLunchWait% equ 0 goto GetJavaVersion
echo %INFO%����˽���%EarlyLunchWait%�������
for /l %%a in (1,1,%EarlyLunchWait%) do (ping -n 2 -w 500 0.0.0.1>nul)

if not exist eula.txt goto EulaTask
for /f "tokens=1,* delims==" %%a in ('findstr "eula=" "eula.txt"') do set eula=%%b
if %eula% == true goto GetJavaVersion
:EulaTask
echo %INFO%%DividingLine%
call :ColorText 0E "%WARN%�ȵȣ�" && echo.
call :ColorText 0E "%WARN%�ڷ��������ǰ,�㻹Ҫͬ��Minecraft EULA " && echo.
echo %INFO%�鿴EULA��ǰ�� https://account.mojang.com/documents/minecraft_eula
echo %INFO%�ڴ˴����������ʾͬ��Minecraft EULA�����������
pause>nul
echo eula=true>eula.txt
echo %INFO%��ͬ����Minecraft EULA,����˼�������


:GetJavaVersion
cd lib
if %EarlyLunchWait% LSS 7 (set Tasktime-=%EarlyLunchWait%) else (set Tasktime=1)
for /l %%a in (1,1,%Tasktime%) do (ping -n 2 -w 500 0.0.0.1>nul
if exist JavaVersion.txt goto JavaTask)
goto ERROREXIT
:JavaTask
for /f "tokens=1,* delims==" %%a in ('findstr "Version=" "JavaVersion.txt"') do (set JavaVersion=%%b)
echo %INFO%Java�汾:%JavaVersion%
cd..

:Loop
echo %DividingLine%
echo loading %ServerCoreName%, please wait...
.\Java\bin\java.exe -Xms%MinMem%M -Xmx%UserRam%M -jar %ServerCore% %GUIControl%
echo #
echo %DividingLine%
echo %INFO%������Ѿ��ر�
if %AutoRestart% == false goto CmdExit
if %RestartWait% equ 0 goto Restart
for /l %%b in (%RestartWait%,-1,1) do (echo %INFO%����˽���%%b�������
ping -n 2 -w 500 0.0.0.1>nul)
:Restart
echo %INFO%�����������
set /a Times+=1
title %titl% %ServerCoreName%%Port%%ServerPort% ��������:%Times% 
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
echo %INFO%ϵͳ����ڴ�Ϊ��%ram% MB��ʣ������ڴ�Ϊ��%freeram% MB
set /a UserRam=%freeram%-%SysMem%
if %UserRam% LSS 1024 (call :ColorText 0E "%WARN%ʣ������ڴ���ܲ����Կ�������˻��߿����󿨶�" && echo.
set /a UserRam=1024)
echo %INFO%���ο������������ %UserRam% MB
goto %CheckStatus%

:CmdExit
echo %INFO%��������˳� && pause>nul 
exit




:FirstLunch
title %titl% ������
if %LunchMode% == First echo %INFO%��⵽��һ������
if %LunchMode% == Incomplete echo %INFO%��⵽δ�������
echo %INFO%�����������ļ�

:ModeSelect
echo %INFO%%DividingLine%
echo #�����ļ�,��������ɾ��>config.txt
echo #������������������������ɾ��ConfigProgress.txt>>config.txt
echo #�����ļ�,��������ɾ��>ConfigProgress.txt
echo #������������������������ɾ�����ļ�>>ConfigProgress.txt
echo ConfigSet=false>>ConfigProgress.txt
echo %INFO%��������ɺ�����ɾ��ConfigProgress.txt,����ᵼ�����ö�ʧ
echo %INFO%������������������������ɾ��ConfigProgress.txt
echo %INFO%%DividingLine%
echo %INFO%��ѡ������ģʽ(���·��������)
echo %INFO%1.Ĭ��ģʽ(ȫ��ʹ��Ĭ������,�ʺϵ�һ�ο����ĸ���)
echo %INFO%2.�߼�ģʽ(ȫ�������Զ���,�ʺ����������ĸ���)
set /p ConfigMode=%INPUT%
if %ConfigMode% equ 1 goto Default
if %ConfigMode% equ 2 goto AutoMemset
echo %INFO%��������ȷ��ģʽ
goto ModeSelect


:Default
title %titl% ������-Ĭ��ģʽ
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
title %titl% ������-�߼�ģʽ
echo %INFO%%DividingLine%
echo %INFO%�Ƿ��Զ������ڴ�(������:AutoMemSet)(Ĭ��:1)
echo %INFO%1.��			2.��
set /p InputSub=%INPUT%
if %InputSub% equ 1 echo AutoMemSet=true >>config.txt && goto SysMem
if %InputSub% equ 2 echo AutoMemSet=false >>config.txt && goto UserRam
echo %INFO%��������ȷ��ѡ��
goto AutoMemSet

:SysMem
echo %INFO%%DividingLine%
echo %INFO%Ԥ���ڴ��С(������:SysMem)(Ĭ��:768)
echo %INFO%�������ִ�С(��λ:MB),����0����Ԥ��
set /p InputSub=%INPUT%
if %InputSub% geq 0 echo SysMem=%InputSub% >>config.txt && goto MinMem
echo %INFO%��������ȷ������
goto SysMem

:UserRam
echo %INFO%%DividingLine%
echo %INFO%��������ڴ��С(������:UserRam)(Ĭ��:2048)
echo %INFO%�������ִ�С(��λ:MB),�������1024
set /p InputSub=%INPUT%
if %InputSub% geq 1 echo UserRam=%InputSub% >>config.txt && goto MinMem
echo %INFO%��������ȷ������
goto UserRam

:MinMem
echo %INFO%%DividingLine%
echo %INFO%������С�ڴ��С(������:MinMem)(Ĭ��:128)
echo %INFO%�������ִ�С(��λ:MB),����0������������ڴ���ͬ
set /p InputSub=%INPUT%
if %InputSub% geq 0 echo MinMem=%InputSub% >>config.txt && goto AutoRestart
echo %INFO%��������ȷ������
goto MinMem

:AutoRestart
echo %INFO%%DividingLine%
echo %INFO%�Ƿ����Զ�����(������:AutoRestart)(Ĭ��:1)
echo %INFO%1.��			2.��
set /p InputSub=%INPUT%
if %InputSub% equ 1 echo AutoRestart=true >>config.txt && goto RestartWait
if %InputSub% equ 2 echo AutoRestart=false >>config.txt && goto EarlyLunchWait
echo %INFO%��������ȷ��ѡ��
goto AutoRestart

:RestartWait
echo %INFO%%DividingLine%
echo %INFO%�Զ������ȴ�ʱ��(������:RestartWait)(Ĭ��:10)
echo %INFO%�������ִ�С(��λ:��)����0�������ȴ�,���300
set /p InputSub=%INPUT%
if %InputSub% geq 0 if %InputSub% leq 300 echo RestartWait=%InputSub% >>config.txt && goto EarlyLunchWait
echo %INFO%��������ȷ������
goto RestartWait

:EarlyLunchWait
echo %INFO%%DividingLine%
echo %INFO%�����ȴ�ʱ��(������:EarlyLunchWait)(Ĭ��:5)
echo %INFO%�������ִ�С(��λ:��)����0�������ȴ�,���300
set /p InputSub=%INPUT%
if %InputSub% geq 0 if %InputSub% leq 300 echo EarlyLunchWait=%InputSub% >>config.txt && goto LogAutoRemove
echo %INFO%��������ȷ������
goto EarlyLunchWait

:LogAutoRemove
echo %INFO%%DividingLine%
echo %INFO%�Զ������־(������:LogAutoRemove)(Ĭ��:2)
echo %INFO%1.��			2.��
set /p InputSub=%INPUT%
if %InputSub% equ 1 echo LogAutoRemove=true >>config.txt && goto ServerGUI
if %InputSub% equ 2 echo LogAutoRemove=false >>config.txt && goto ServerGUI
echo %INFO%��������ȷ��ѡ��
goto LogAutoRemove

:ServerGUI
echo %INFO%%DividingLine%
echo %INFO%�Ƿ�������������GUI(������:ServerGUI)(Ĭ��:2)
echo %INFO%1.��			2.��
set /p InputSub=%INPUT%
if %InputSub% equ 1 echo ServerGUI=true >>config.txt && goto ConfigProgress
if %InputSub% equ 2 echo ServerGUI=false >>config.txt && goto ConfigProgress
echo %INFO%��������ȷ��ѡ��
goto ServerGUI

:ConfigProgress
echo #�����ļ�,����ɾ��>ConfigProgress.txt
echo #��������������ɾ�����ļ�>>ConfigProgress.txt
echo ConfigSet=true>>ConfigProgress.txt
echo %INFO%%DividingLine%
echo %INFO%�������



:ConfigReader
echo %INFO%��ʼ��ȡ�����ļ�
echo %INFO%%DividingLine%

for /f "tokens=1,* delims==" %%a in ('findstr "AutoMemSet=" "config.txt"') do (set AutoMemSet=%%b)
set AutoMemSet=%AutoMemSet: =%
set AutoMemSetOut=%AutoMemSet:true=����%
set AutoMemSetOut=%AutoMemSetOut:false=�ر�%
echo %INFO%�Զ������ڴ�:%AutoMemSetOut%
if %AutoMemSet% == false goto ConfigReaderMem

for /f "tokens=1,* delims==" %%a in ('findstr "SysMem=" "config.txt"') do (set SysMem=%%b)
set SysMem=%SysMem: =%
echo %INFO%�����ڴ�Ԥ��:%SysMem%MB
goto ConfigReader2

:ConfigReaderMem
for /f "tokens=1,* delims==" %%a in ('findstr "UserRam=" "config.txt"') do (set UserRam=%%b)
set UserRam=%UserRam: =%
echo %INFO%�ڴ�����:%UserRam%MB

:ConfigReader2
for /f "tokens=1,* delims==" %%a in ('findstr "MinMem=" "config.txt"') do (set MinMem=%%b)
set MinMem=%MinMem: =%
echo %INFO%��С�ڴ�:%MinMem%MB

for /f "tokens=1,* delims==" %%a in ('findstr "AutoRestart=" "config.txt"') do (set AutoRestart=%%b)
set AutoRestart=%AutoRestart: =%
set AutoMemSetOut=%AutoMemSet:true=����%
set AutoMemSetOut=%AutoMemSetOut:false=�ر�%
echo %INFO%�Զ�����:%AutoMemSetOut%

if %AutoRestart% == false goto ConfigReader3
for /f "tokens=1,* delims==" %%a in ('findstr "RestartWait=" "config.txt"') do (set RestartWait=%%b)
set RestartWait=%RestartWait: =%
echo %INFO%�����ȴ�ʱ��:%RestartWait%s

:ConfigReader3
for /f "tokens=1,* delims==" %%a in ('findstr "LogAutoRemove=" "config.txt"') do (set LogAutoRemove=%%b)
set LogAutoRemove=%LogAutoRemove: =%
set LogAutoRemoveOut=%LogAutoRemove:true=����%
set LogAutoRemoveOut=%LogAutoRemoveOut:false=�ر�%
echo %INFO%�Զ������־:%LogAutoRemoveOut%

for /f "tokens=1,* delims==" %%a in ('findstr "EarlyLunchWait=" "config.txt"') do (set EarlyLunchWait=%%b)
set EarlyLunchWait=%EarlyLunchWait: =%
echo %INFO%����ǰ�ȴ�:%EarlyLunchWait%s

for /f "tokens=1,* delims==" %%a in ('findstr "ServerGUI=" "config.txt"') do (set ServerGUI=%%b)
set ServerGUI=%ServerGUI: =%
set ServerGUIOut=%ServerGUI:true=����%
set ServerGUIOut=%ServerGUIOut:false=�ر�%
echo %INFO%����������GUI:%ServerGUIOut%

if not exist server.properties set Port= && goto main
echo %INFO%%DividingLine%
echo %INFO%��ʼ��ȡ��������Ϣ
for /f "tokens=1,* delims==" %%a in ('findstr "server-port=" "server.properties"') do (set ServerPort=%%b)
set ServerPort=%ServerPort: =%
echo %INFO%�˿�:%ServerPort%

cd lib
start wscript -e:vbs JavaTask.vbs
cd..

goto Main

:ERROREXIT
call :ColorText 0C "%FATAL%������������������,�޷���������,�������һ��BUG" && echo.
call :ColorText 0C "%FATAL%BUG������ǰ���������ű���githubҳ������QQ1593713272" && echo.
call :ColorText 0C "%FATAL%��������˳�"
pause>nul
exit

:ColorText
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1













