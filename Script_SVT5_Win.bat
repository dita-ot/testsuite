@echo off
setlocal

echo *************Starting to set up test environment......

set DOST_HOME=C:\DITA-OT1.4.1

set IBM_JAVA_HOME=C:\Program Files\IBM\Java50

set ANT_HOME=C:\DITA-OT1.4.1\tools\ant

set XALAN_HOME=C:\xalan-j_2_6_0
set XALAN_ANT_OPTS=-Xmx512m 
set SAXON_HOME=C:\saxon6-5-5
set SAXON_ANT_OPTS=-Xmx512m -Djavax.xml.transform.TransformerFactory=com.icl.saxon.TransformerFactoryImpl

set FOP_HOME=C:\fop-0.20.5

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


REM Regression Test of Major Fixes at DITA-OT1.2
REM SF Bug1357139 & CQ dita00000138
java -jar lib\dost.jar /i:Testdata/SF1357139/testcondition.dita  /tempdir:tempSVT5 /outdir:Output/%out%/MajorFixes_DITA-OT1.2/SF1357139/xhtml  /transtype:xhtml   /ditaext:.dita  /filter:c:/dita-ot1.4.1/Testdata/SF1357139/a.ditaval

REM SF Bug1333481
java -jar lib\dost.jar /i:Testdata/SF1333481/subdir/R008323mapref1.ditamap /tempdir:tempSVT5 /outdir:Output/%out%/MajorFixes_DITA-OT1.2/SF1333481/xhtml  /transtype:xhtml   /ditaext:.dita 

REM SF Bug1304545 & SF Bug1347669
java -jar lib\dost.jar /i:Testdata/SF1304545/com.ibm.nobel.museum/nobellinks.ditamap  /tempdir:tempSVT5 /outdir:Output/%out%/MajorFixes_DITA-OT1.2/SF1304545/nobellinks   /ditaext:.dita   /transtype:xhtml 

REM SF Bug1328689
java -jar lib\dost.jar /i:Testdata/CSS_issue/table-nocolnum.dita  /tempdir:tempSVT5 /outdir:Output/%out%/MajorFixes_DITA-OT1.2/CSS/TC1 /transtype:xhtml   /ditaext:.dita  /css:Testdata/CSS_issue/user.css
java -jar lib\dost.jar /i:Testdata/CSS_issue/table-nocolnum.dita /tempdir:tempSVT5 /outdir:Output/%out%/MajorFixes_DITA-OT1.2/CSS/TC2  /transtype:xhtml   /ditaext:.dita  /css:Testdata/CSS_issue/user.css   /copycss:yes
java -jar lib\dost.jar /i:Testdata/CSS_issue/table-nocolnum.dita /tempdir:tempSVT5 /outdir:Output/%out%/MajorFixes_DITA-OT1.2/CSS_issue/TC3 /transtype:xhtml   /ditaext:.dita /csspath:/css
REM *******************************************************************

echo *************End of one cycle******************
  goto :EOF
goto :EOF

echo *************End of test******************

endlocal