@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
color 0a
echo ==============================================
echo             �Ǹ��� һ�������ű�
echo ==============================================
echo ���ߣ�����Сվ
echo Github��ҳ��https://github.com/dreamstation625/AutoMCServerBat
echo Bվ��ҳ��https://space.bilibili.com/178030275
echo ����֧�֣��Ǹ���www.xlhost.cn
echo.
::======���и�̧���֣���Ҫ������ҳȥ�ˡ�����ȥ����======
::======���и�̧���֣���Ҫ������ҳȥ�ˡ�����ȥ����======
title �Ǹ���MCһ�������ű�
::�������˿����޸ĵı���
::�������ģ��Ⱥź���Ķ��㣬����ע�ⲻҪ��Ӷ���ķ��š��ո��
set serverjar=server.jar
::-Xmsֵ����λMB������������������С�����ڴ棬���Ƽ���
set minram=128
::�������������������-XX:UseG1GC����ӵĻ���ע����ǰ�����Ҫ�ӿո�
set extra=
::Ϊϵͳ���Ᵽ���ڴ棨��������ϵͳռ��100mb���˴���100�Ļ�������mcȫ��������ϵͳ������ռ��100��
::���ѡ��û�²�Ҫ��
set sysram=768

::�Ȼ�ȡjava�汾����ӡ�����java���������򿪷�
echo ���Java����
ping 127.1 -n 4 >nul 2>nul
echo ======Java����������======
java -version
echo ======Java����������======
if not %errorlevel% == 0 (
	echo Java���������ڣ��밴��ʾ���ذ�װ��
	echo.
	goto selectjava
)
::�˽ű�Ϊ�Զ�����win�������������ڴ�-%sysram%MB�������ű�
::��Ҫָ���ڴ�ģ���ʹ�������ű�
::��ȡϵͳ�ڴ�
for /f "delims=" %%a in ('wmic os get TotalVisibleMemorySize /value^|find "="') do set %%a
set /a t1=%TotalVisibleMemorySize%,t2=1024
set /a ram=%t1%/%t2%
for /f "delims=" %%b in ('wmic os get FreePhysicalMemory /value^|find "="') do set %%b
set /a t3=%FreePhysicalMemory%
set /a freeram=%t3%/%t2%
echo ϵͳ����ڴ�Ϊ��%ram% MB��ʣ������ڴ�Ϊ��%freeram% MB
::useramΪ-Xmx��ֵ����λMB�����������������������ڴ�
set /a useram=%freeram%-%sysram%
echo ���ο������������ %useram% MB 
echo.
echo ���������ļ�Ϊ %serverjar% �������Ҫ�Զ��壬��༭���ű��ĵ�12�б���
echo.
echo �����Ķ������ %extra% �������Ҫ�Զ��壬��༭���ű��ĵ�16�б���
echo.
echo ����������java -Xms%minram%M -Xmx%useram%M %extra% -jar %serverjar%
echo.
echo. -----------------------------------------------------------------
echo.
echo.                    ��������������,��ȴ�����  
echo.
echo.           ע��:�رշ�����ǰ���ں�̨����stop�����������
echo.                      ������ܻ���ֻص����
echo.                
echo. -----------------------------------------------------------------
echo.
echo �����������������������
pause>nul
::����
cls
color 07
echo. ----------------------------------------------------------------- 
echo. 
echo. 
echo.                   ����������������,���Եȡ���
echo. 
echo.
echo. -----------------------------------------------------------------
java -Xms%minram%M -Xmx%useram%M %extra% -jar %serverjar%
echo. ----------------------------------------------------------------- 
echo.                   �������ѹر�,��������˳�                                
echo. -----------------------------------------------------------------
pause>nul
:batexit
exit

:selectjava
	echo =========Java�汾ѡ��=========
	echo 1��Java8  2��Java11  3��Java16
	echo ==============================
	set /p selectjava="������ѡ�"
	if %selectjava%==1 (
		echo ======����Java8����5���ʼ����======
		ping 127.1 -n 6 >nul 2>nul
		if exist "c:\java8.zip" (
			echo Java8��װ�ű������ء�
		) else (
			bitsadmin /transfer Java8���� /download http://45.156.27.173/java8.zip c:\java8.zip
			echo =============
			if exist "c:\java8.zip" (echo �������) else (echo ����ʧ��)
		)
		echo ======����unzip.exe����5���ʼ����======
		ping 127.1 -n 6 >nul 2>nul
		if exist "c:\unzip.exe" (
			echo unzip.exe�����ء�
		) else (
			bitsadmin /transfer unzip /download http://45.156.27.173/unzip.exe c:\unzip.exe
			echo =============
			if exist "c:\unzip.exe" (echo �������) else (echo ����ʧ��)
		)	
		echo �������������װJava8
		pause>nul
		c:\unzip.exe -o c:\java8.zip
		echo.
		echo �ڵ����Ľ��氲װjava��������װ��Ϻ��������б��ű�
		echo �������������װ������jdk
		pause>nul
		java8������װ�ű�.bat
		goto batexit
	) else if %selectjava%==2 (
		echo ======����Java11����5���ʼ����======
		ping 127.1 -n 6 >nul 2>nul
		if exist "c:\java11.zip" (
			echo Java11��װ�ű������ء�
		) else (
			bitsadmin /transfer Java11���� /download http://45.156.27.173/java11.zip c:\java11.zip
			echo =============
			if exist "c:\java11.zip" (echo �������) else (echo ����ʧ��)
		)
		echo ======����unzip.exe����5���ʼ����======
		ping 127.1 -n 6 >nul 2>nul
		if exist "c:\unzip.exe" (
			echo unzip.exe�����ء�
		) else (
			bitsadmin /transfer unzip /download http://45.156.27.173/unzip.exe c:\unzip.exe
			echo =============
			if exist "c:\unzip.exe" (echo �������) else (echo ����ʧ��)
		)	
		echo �������������װJava11
		pause>nul
		c:\unzip.exe -o c:\java11.zip
		echo.
		echo �ڵ����Ľ��氲װjava��������װ��Ϻ��������б��ű�
		echo �������������װ������jdk
		pause>nul
		java11������װ�ű�.bat
		goto batexit
	) else if %selectjava%==3 (
		echo ======����Java16����5���ʼ����======
		ping 127.1 -n 6 >nul 2>nul
		if exist "c:\java16.zip" (
			echo Java16��װ�ű������ء�
		) else (
			bitsadmin /transfer Java16���� /download http://45.156.27.173/java16.zip c:\java16.zip
			echo =============
			if exist "c:\java16.zip" (echo �������) else (echo ����ʧ��)
		)
		echo ======����unzip.exe����5���ʼ����======
		ping 127.1 -n 6 >nul 2>nul
		if exist "c:\unzip.exe" (
			echo unzip.exe�����ء�
		) else (
			bitsadmin /transfer unzip /download http://45.156.27.173/unzip.exe c:\unzip.exe
			echo =============
			if exist "c:\unzip.exe" (echo �������) else (echo ����ʧ��)
		)	
		echo �������������װJava16
		pause>nul
		c:\unzip.exe -o c:\java16.zip
		echo.
		echo �ڵ����Ľ��氲װjava��������װ��Ϻ��������б��ű�
		echo �������������װ������jdk
		pause>nul
		java16������װ�ű�.bat
		goto batexit
	) else (
		echo �������������ѡ��
		echo.
		goto selectjava
	)	
::���ߣ�����Сվ
::Github��ҳ��https://github.com/dreamstation625/AutoMCServerBat
::Bվ��ҳ��https://space.bilibili.com/178030275