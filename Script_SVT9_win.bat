@echo off
setlocal

echo *************Starting to set up test environment......

set DOST_HOME=C:\DITA-OT1.4.1

set IBM_JAVA_HOME=E:\apps\JDK\IBM\Java50
set SUN_JAVA_HOME=E:\apps\JDK\SUN\jdk1.5.0_14

set ANT_HOME=C:\DITA-OT1.4.1\tools\ant

set XALAN_HOME=C:\xalan-j_2_6_0
set XALAN_ANT_OPTS=-Xmx512m 
set SAXON_HOME=E:\saxon655
set SAXON_ANT_OPTS=-Xmx512m -Djavax.xml.transform.TransformerFactory=com.icl.saxon.TransformerFactoryImpl

set FOP_HOME=C:\DITA-OT1.4.1\lib

set TEMP_PATH=%PATH%
set TEMP_CLASSPATH=%CLASSPATH%

set JHHOME=C:\javahelp-2_0_02-1

set TEMP_PATH=%PATH%
set TEMP_CLASSPATH=%CLASSPATH%

set JHHOME=C:\javahelp-2_0_02-1

echo *************Starting test operations......

echo ******Starting a New cycle:

for  %%j in (IBMJDK SUNJDK) do call :java %%j

:java
if "%1" == "IBMJDK" (
set JAVA_HOME=%IBM_JAVA_HOME%
) else (
if "%1" == "SUNJDK" (
set JAVA_HOME=%SUN_JAVA_HOME%
) else (
goto :EOF
)
)

set Path=%ANT_HOME%\bin\;%JAVA_HOME%\bin;%TEMP_PATH%
set jdk=%1

for %%p in (XALAN SAXON) do call :parser %%p

:parser
if "%1" == "XALAN" (
set CLASSPATH=%DOST_HOME%\lib\dost.jar;%DOST_HOME%\lib\resolver.jar;%DOST_HOME%\lib;%FOP_HOME%\build;%FOP_HOME%\lib;%XALAN_HOME%\bin;%TEMP_CLASSPATH%
set ANT_OPTS=%XALAN_ANT_OPTS%
) else (
if "%1" == "SAXON" ( 
set CLASSPATH=%DOST_HOME%\lib\dost.jar;%DOST_HOME%\lib\resolver.jar;%DOST_HOME%\lib;%FOP_HOME%\build;%FOP_HOME%\lib;%SAXON_HOME%\saxon.jar;%TEMP_CLASSPATH%
set ANT_OPTS=%SAXON_ANT_OPTS%
) else (
goto :EOF
)
)

echo 
set out=%jdk%_%1
echo ****Main parameters in this cycle:*****
echo *Input parameters:%out%

echo *Other environment parameters:
echo java_home: %java_home%
echo path: %path%
echo classpath: %classpath%
echo ant_opts: %ant_opts%

REM *******************************************************************

call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1563093\1563093.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1584187\1584187.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1630214\1630214.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1639344\1639344.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1639672\1639672.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1675195\1675195.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1732678\1732678_1.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1732678\1732678_2.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1741302\1741302.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1764905\1764905_true.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1764905\1764905_false.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1764910\1764910_1_fail.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1764910\1764910_1_quiet.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1764910\1764910_1_warn.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1764910\1764910_2_fail.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1764910\1764910_2_quiet.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1764910\1764910_2_warn.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1764910\1764910_3.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1770571\1770571.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1782109\1782109.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1803190\1803190.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1806081\1806081.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1806130\1806130.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1806728\1806728.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1819660\1819660.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1819663\1819663.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1821028\1821028.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\forflag\forflag.xml
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\unknownforeign\build_unknownforeign.xml


REM *******************************************************************

echo *************End of one cycle******************
  goto :EOF
goto :EOF

echo *************End of test******************

endlocal