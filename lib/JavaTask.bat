del JavaVersion.txt /f/s/q 
java -version
if %errorlevel% == 0 (java -jar VersionGet.jar) else (echo JavaVersion=None>JavaVersion.txt)