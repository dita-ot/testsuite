@echo off
setlocal

echo *************Starting to set up test environment......

set DOST_HOME=C:\DITA-OT1.4

set IBM_JAVA_HOME=D:\DITA_TOOLS\IBMJava2-142
set SUN_JAVA_HOME=C:\j2sdk1.4.2_14

set ANT_HOME=C:\DITA-OT1.4\tools\ant

set XALAN_HOME=C:\xalan-j_2_6_0
set XALAN_ANT_OPTS=-Xmx512m 
set SAXON_HOME=C:\saxon6-5-4
set SAXON_ANT_OPTS=-Xmx512m -Djavax.xml.transform.TransformerFactory=com.icl.saxon.TransformerFactoryImpl

set FOP_HOME=C:\fop-0.20.5

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

call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1619074\build_1619074.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\1700561\build_1700561.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\bookmap(2)\build_bookmap(2).xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\Chunkattribute\build_Chunkattribute.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\DITAVAL\build_DITAVAL.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\IndexBase\build_indexbase.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\Index-see\build_index-see.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\Index-see-also\build_indexbase.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\keepfiltering\build_keepfiltering.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\maptitle\build_maptitle.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\MetadataInheritance\build_MetadataInheritance.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\shortdesc-abstract(1)\build_shortdesc-abstract.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\shortdesc-abstract(2)\build_shortdesc-abstract.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\translation\build_translation.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\unknownforeign\build_unknownforeign.xml all
call ant -logger org.dita.dost.log.DITAOTBuildLogger -f testcase\xtrfxtrc\build_xtrfxtrc.xml all


REM *******************************************************************

echo *************End of one cycle******************
  goto :EOF
goto :EOF

echo *************End of test******************

endlocal