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

REM *******************************************************************
java -jar lib\dost.jar /i:testdata\release141\abc.ditamap /transtype:xhtml /tempdir:tempSVT7 /outdir:Output/%out%/release141
java -jar lib\dost.jar /i:testdata\release141\booktest.ditamap /transtype:xhtml /tempdir:tempSVT7 /outdir:Output/%out%/release141
java -jar lib\dost.jar /i:testdata\release141\plugintest.ditamap /transtype:eclipsehelp /tempdir:tempSVT7 /outdir:Output/%out%/release141
java -jar lib\dost.jar /i:testdata\release141\plugintest.ditamap /transtype:xhtml /tempdir:tempSVT7 /outdir:Output/%out%/release141
java -jar lib\dost.jar /i:testdata\release141\test.ditamap /transtype:xhtml /tempdir:tempSVT7 /outdir:Output/%out%/release141
java -jar lib\dost.jar /i:testdata\release141\chunk\chunking.ditamap /transtype:xhtml /tempdir:tempSVT7 /outdir:Output/%out%/release141/chunk
java -jar lib\dost.jar /i:testdata\release141\emptytopicref\a.ditamap /transtype:pdf2 /tempdir:tempSVT7 /outdir:Output/%out%/release141/emptytopicref
java -jar lib\dost.jar /i:testdata\release141\emptytopicref\a.ditamap /transtype:xhtml /tempdir:tempSVT7 /outdir:Output/%out%/release141/emptytopicref
java -jar lib\dost.jar /i:testdata\release141\flag\flag.dita /transtype:xhtml /filter:c:\dita-ot1.4.1\testdata\release141\flag\flag.ditaval /tempdir:tempSVT7 /outdir:Output/%out%/release141/flag
java -jar lib\dost.jar /i:testdata\release141\flag\test2.xml /transtype:xhtml /filter:c:\dita-ot1.4.1\testdata\release141\flag\revision.ditaval /tempdir:tempSVT7 /outdir:Output/%out%/release141/flag
java -jar lib\dost.jar /i:testdata\release141\hangs-in-move-meta\hangs-in-move-meta-1.ditamap /transtype:xhtml /tempdir:tempSVT7 /outdir:Output/%out%/release141/hangs-in-move-meta/1
java -jar lib\dost.jar /i:testdata\release141\hangs-in-move-meta\hangs-in-move-meta-2.ditamap /transtype:xhtml /tempdir:tempSVT7 /outdir:Output/%out%/release141/hangs-in-move-meta/2
java -jar lib\dost.jar /i:testdata\release141\hangs-in-move-meta\does-not-hang-in-move-meta-3.ditamap /transtype:xhtml /tempdir:tempSVT7 /outdir:Output/%out%/release141/hangs-in-move-meta/3
java -jar lib\dost.jar /i:testdata\release141\hangs-in-move-meta\hangs-in-move-meta-4.ditamap /transtype:xhtml /tempdir:tempSVT7 /outdir:Output/%out%/release141/hangs-in-move-meta/4
java -jar lib\dost.jar /i:testdata\release141\index\R009572index.ditamap /transtype:htmlhelp /tempdir:tempSVT7 /outdir:Output/%out%/release141/index
java -jar lib\dost.jar /i:testdata\release141\index\DITA-OT1.4.1\indexdir.ditamap /transtype:htmlhelp /tempdir:tempSVT7 /outdir:Output/%out%/release141/index/DITA-OT1.4.1 /generateouter:3
java -jar lib\dost.jar /i:testdata\release141\index\DITA-OT1.4.1-a\indexdir.ditamap /transtype:htmlhelp /tempdir:tempSVT7 /outdir:Output/%out%/release141/index/DITA-OT1.4.1-a
java -jar lib\dost.jar /i:testdata\release141\htmlhelp\infotypes.ditamap /transtype:htmlhelp /tempdir:tempSVT7 /outdir:Output/%out%/release141/htmlhelp
java -jar lib\dost.jar /i:testdata\release141\move-meta-invalid-output\move-meta-invalid-out.ditamap /transtype:xhtml /tempdir:tempSVT7 /outdir:Output/%out%/release141/move-meta-invalid-output


REM *******************************************************************

echo *************End of one cycle******************
  goto :EOF
goto :EOF

echo *************End of test******************

endlocal