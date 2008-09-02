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


REM Regression Test of Major Fixes at DITA-OT1.2.1
REM Customer Bug1
java -jar lib\dost.jar /i:Testdata/Table/table-nocolnum.dita /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/Table_Wordrtf/table-nocolnum  /ditaext:.dita  /transtype:wordrtf
java -jar lib\dost.jar /i:Testdata/Table/simpletable.xml /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/Table_Wordrtf/simpletable  /transtype:wordrtf
java -jar lib\dost.jar /i:Testdata/Table/property.dita /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/Table_Wordrtf/property  /ditaext:.dita  /transtype:wordrtf
java -jar lib\dost.jar /i:Testdata/Table/choicetable.dita /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/Table_Wordrtf/choicetable  /ditaext:.dita  /transtype:wordrtf

REM Customer Bug2
java -jar lib\dost.jar /i:Testdata/Table/table-nocolnum.dita /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/Tablecorrupt_Wordrtf  /ditaext:.dita  /transtype:wordrtf

REM Customer Bug3
java -jar lib\dost.jar /i:Testdata/Picture/washingthecar.xml /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/Merged_Pic   /transtype:wordrtf

REM CQ dita00000121
java -jar lib\dost.jar /i:Testdata/List/test_list.dita /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/dita00000121  /ditaext:.dita  /transtype:wordrtf

REM CQ dita00000088
java -jar lib\dost.jar   /i:Testdata/OldcasesTest/ao0s1ph1.dita        /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/dita00000088   /ditaext:.dita   /transtype:wordrtf /filter:c:/dita-ot1.4.1/Testdata/OldcasesTest/new.ditaval  

REM CQ dita00000042(run independently)
REM cd demo\h2d
REM call ant -Dargs.input=HTML2DITA/washingthecar.html -Dargs.output=HTML2DITA/out/%out% -Dargs.infotype=topic
REM call ant -Dargs.input=HTML2DITA/table-nocolnum.html -Dargs.output=HTML2DITA/out/%out% -Dargs.infotype=topic

REM SF Bug1398867
java -jar lib\dost.jar /i:Testdata/ampersands_href.dita   /ditaext:.dita  /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/SF1398867/xhtml   /transtype:xhtml
java -jar lib\dost.jar /i:Testdata/ampersands_href.dita   /ditaext:.dita  /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/SF1398867/pdf  /transtype:pdf  /fooutputrellinks:yes
java -jar lib\dost.jar /i:Testdata/ampersands_href.dita   /ditaext:.dita  /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/SF1398867/wordrtf   /transtype:wordrtf

REM SF Bug1326439
java -jar lib\dost.jar /i:Testdata/Indexterms_filter_issue/testcondition.ditamap   /ditaext:.dita  /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/SF1326439/htmlhelp /transtype:htmlhelp  /filter:c:/DITA-OT1.4.1/Testdata/Indexterms_filter_issue/a.ditaval
java -jar lib\dost.jar /i:Testdata/Indexterms_filter_issue/testcondition.ditamap   /ditaext:.dita  /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/SF1326439/javahelp /transtype:javahelp  /filter:c:/DITA-OT1.4.1/Testdata/Indexterms_filter_issue/a.ditaval

REM SF Bug1431229
java -jar lib\dost.jar /i:samples/hierarchy.ditamap /outdir:Output/%out%/MajorFixes_DITA-OT1.2.1/SF1431229/java1  /transtype:eclipsehelp 
call ant -f conductor.xml  -Dargs.input=samples/hierarchy.ditamap -Doutput.dir=Output/%out%/SF1431229/ant -Dtranstype=eclipsehelp  -logger org.dita.dost.log.DITAOTBuildLogger
REM *******************************************************************

echo *************End of one cycle******************
  goto :EOF
goto :EOF

echo *************End of test******************

endlocal