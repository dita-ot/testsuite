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
set CLASSPATH=%DOST_HOME%\lib\dost.jar;%FOP_HOME%\build;%FOP_HOME%\lib;%XALAN_HOME%\bin;%TEMP_CLASSPATH%
set ANT_OPTS=%XALAN_ANT_OPTS%
) else (
if "%1" == "SAXON" ( 
set CLASSPATH=%DOST_HOME%\lib\dost.jar;%FOP_HOME%\build;%FOP_HOME%\lib;%SAXON_HOME%\saxon.jar;%TEMP_CLASSPATH%
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



REM ANT
REM call ant -logger org.dita.dost.log.DITAOTBuildLogger
call ant -f build_demo.xml all -logger org.dita.dost.log.DITAOTBuildLogger
call ant -f build_demo.xml clean.demo.faq
call ant -f build_demo.xml demo.faq -logger org.dita.dost.log.DITAOTBuildLogger
REM *******************************************************************
REM to start  find the error reason 
echo begin to call section 1


REM DITA to javahelp, xhtml, htmlhelp, docbook, pdf, eclipsehelp, eclipsecontent, troff
REM SAMPLES
java -jar lib\dost.jar   /transtype:docbook   /i:samples/sequence.ditamap   /outdir:Output/%out%/Samples/docbook/samples/sequence
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:samples/sequence.ditamap   /outdir:Output/%out%/Samples/eclipsehelp/samples/sequence
java -jar lib\dost.jar   /transtype:htmlhelp   /i:samples/sequence.ditamap   /outdir:Output/%out%/Samples/htmlhelp/samples/sequence 
java -jar lib\dost.jar   /transtype:javahelp   /i:samples/sequence.ditamap   /outdir:Output/%out%/Samples/javahelp/samples/sequence 
java -jar lib\dost.jar   /transtype:pdf   /i:samples/sequence.ditamap   /outdir:Output/%out%/Samples/pdf/samples/sequence 
java -jar lib\dost.jar   /transtype:xhtml   /i:samples/sequence.ditamap   /outdir:Output/%out%/Samples/xhtml/samples/sequence 
java -jar lib\dost.jar   /transtype:eclipsecontent  /i:samples/sequence.ditamap   /outdir:Output/%out%/Samples/eclipsecontent/samples/sequence 
java -jar lib\dost.jar   /transtype:troff       /i:samples/sequence.ditamap       /outdir:Output/%out%/Samples/troff/samples/sequence  

java -jar lib\dost.jar   /transtype:docbook   /i:samples/hierarchy.ditamap   /outdir:Output/%out%/Samples/docbook/samples/hierarchy
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:samples/hierarchy.ditamap   /outdir:Output/%out%/Samples/eclipsehelp/samples/hierarchy
java -jar lib\dost.jar   /transtype:htmlhelp   /i:samples/hierarchy.ditamap   /outdir:Output/%out%/Samples/htmlhelp/samples/hierarchy 
java -jar lib\dost.jar   /transtype:javahelp   /i:samples/hierarchy.ditamap   /outdir:Output/%out%/Samples/javahelp/samples/hierarchy 
java -jar lib\dost.jar   /transtype:pdf   /i:samples/hierarchy.ditamap   /outdir:Output/%out%/Samples/pdf/samples/hierarchy 
java -jar lib\dost.jar   /transtype:xhtml   /i:samples/hierarchy.ditamap   /outdir:Output/%out%/Samples/xhtml/samples/hierarchy 
java -jar lib\dost.jar   /transtype:eclipsecontent  /i:samples/hierarchy.ditamap   /outdir:Output/%out%/Samples/eclipsecontent/samples/hierarchy 
java -jar lib\dost.jar   /transtype:troff       /i:samples/hierarchy.ditamap       /outdir:Output/%out%/Samples/troff/samples/hierarchy 

REM DOC
REM DOC/DITA-readme
REM to start  find the error reason 
echo begin to call section  DOC/DITA-readme
java -jar lib\dost.jar   /transtype:docbook   /i:doc/DITA-readme.ditamap   /outdir:Output/%out%/Doc/docbook/DITA-readme
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:doc/DITA-readme.ditamap   /outdir:Output/%out%/Doc/eclipsehelp/DITA-readme
java -jar lib\dost.jar   /transtype:htmlhelp   /i:doc/DITA-readme.ditamap   /outdir:Output/%out%/Doc/htmlhelp/DITA-readme 
java -jar lib\dost.jar   /transtype:javahelp   /i:doc/DITA-readme.ditamap   /outdir:Output/%out%/Doc/javahelp/DITA-readme 
java -jar lib\dost.jar   /transtype:pdf   /i:doc/DITA-readme.ditamap   /outdir:Output/%out%/Doc/pdf/DITA-readme 
java -jar lib\dost.jar   /transtype:xhtml   /i:doc/DITA-readme.ditamap   /outdir:Output/%out%/Doc/xhtml/DITA-readme 
java -jar lib\dost.jar   /transtype:eclipsecontent  /i:doc/DITA-readme.ditamap    /outdir:Output/%out%/Doc/eclipsecontent/DITA-readme
java -jar lib\dost.jar   /transtype:troff       /i:doc/DITA-readme.ditamap        /outdir:Output/%out%/Doc/troff/samples/DITA-readme 

REM to start  find the error reason 
echo begin to call section  DOC/DITA-userguide
REM DOC/DITA-userguide
java -jar lib\dost.jar   /transtype:docbook   /i:doc/userguide/DITA-userguide.ditamap   /outdir:Output/%out%/Doc/docbook/DITA-userguide
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:doc/userguide/DITA-userguide.ditamap   /outdir:Output/%out%/Doc/eclipsehelp/DITA-userguide
java -jar lib\dost.jar   /transtype:htmlhelp   /i:doc/userguide/DITA-userguide.ditamap   /outdir:Output/%out%/Doc/htmlhelp/DITA-userguide 
java -jar lib\dost.jar   /transtype:javahelp   /i:doc/userguide/DITA-userguide.ditamap   /outdir:Output/%out%/Doc/javahelp/DITA-userguide 
java -jar lib\dost.jar   /transtype:pdf   /i:doc/userguide/DITA-userguide.ditamap   /outdir:Output/%out%/Doc/pdf/DITA-userguide 
java -jar lib\dost.jar   /transtype:xhtml   /i:doc/userguide/DITA-userguide.ditamap   /outdir:Output/%out%/Doc/xhtml/DITA-userguide 
java -jar lib\dost.jar   /transtype:eclipsecontent  /i:doc/userguide/DITA-userguide.ditamap    /outdir:Output/%out%/Doc/eclipsecontent/DITA-userguide
java -jar lib\dost.jar   /transtype:troff       /i:doc/userguide/DITA-userguide.ditamap        /outdir:Output/%out%/Doc/troff/samples/DITA-userguide 

REM DOC/DITA-langref
java -jar lib\dost.jar   /transtype:docbook   /i:doc/langref/ditaref-book.ditamap   /outdir:Output/%out%/Doc/docbook/DITA-langref/ditaref-book /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:doc/langref/ditaref-book.ditamap   /outdir:Output/%out%/Doc/eclipsehelp/DITA-langref/ditaref-book /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:htmlhelp   /i:doc/langref/ditaref-book.ditamap   /outdir:Output/%out%/Doc/htmlhelp/DITA-langref/ditaref-book  /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:javahelp   /i:doc/langref/ditaref-book.ditamap   /outdir:Output/%out%/Doc/javahelp/DITA-langref/ditaref-book /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:pdf   /i:doc/langref/ditaref-book.ditamap   /outdir:Output/%out%/Doc/pdf/DITA-langref/ditaref-book  /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:xhtml   /i:doc/langref/ditaref-book.ditamap   /outdir:Output/%out%/Doc/xhtml/DITA-langref/ditaref-book  /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:eclipsecontent  /i:doc/langref/ditaref-book.ditamap    /outdir:Output/%out%/Doc/eclipsecontent/DITA-langref/ditaref-book /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:troff       /i:doc/langref/ditaref-book.ditamap        /outdir:Output/%out%/Doc/troff/samples/DITA-langref/ditaref-book  /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml

java -jar lib\dost.jar   /transtype:docbook   /i:doc/langref/ditaref-alpha.ditamap   /outdir:Output/%out%/Doc/docbook/DITA-langref/ditaref-alpha /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:doc/langref/ditaref-alpha.ditamap   /outdir:Output/%out%/Doc/eclipsehelp/DITA-langref/ditaref-alpha /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:htmlhelp   /i:doc/langref/ditaref-alpha.ditamap   /outdir:Output/%out%/Doc/htmlhelp/DITA-langref/ditaref-alpha  /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:javahelp   /i:doc/langref/ditaref-alpha.ditamap   /outdir:Output/%out%/Doc/javahelp/DITA-langref/ditaref-alpha /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:pdf   /i:doc/langref/ditaref-alpha.ditamap  /outdir:Output/%out%/Doc/pdf/DITA-langref/ditaref-alpha  /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:xhtml   /i:doc/langref/ditaref-alpha.ditamap  /outdir:Output/%out%/Doc/xhtml/DITA-langref/ditaref-alpha  /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:eclipsecontent  /i:doc/langref/ditaref-alpha.ditamap   /outdir:Output/%out%/Doc/eclipsecontent/DITA-langref/ditaref-alpha /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:troff       /i:doc/langref/ditaref-alpha.ditamap        /outdir:Output/%out%/Doc/troff/samples/DITA-langref/ditaref-alpha  /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml

java -jar lib\dost.jar   /transtype:docbook   /i:doc/langref/ditaref-type.ditamap   /outdir:Output/%out%/Doc/docbook/DITA-langref/ditaref-type /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:doc/langref/ditaref-type.ditamap   /outdir:Output/%out%/Doc/eclipsehelp/DITA-langref/ditaref-type /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:htmlhelp   /i:doc/langref/ditaref-type.ditamapp   /outdir:Output/%out%/Doc/htmlhelp/DITA-langref/ditaref-type  /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:javahelp   /i:doc/langref/ditaref-type.ditamap   /outdir:Output/%out%/Doc/javahelp/DITA-langref/ditaref-type /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:pdf   /i:doc/langref/ditaref-type.ditamap   /outdir:Output/%out%/Doc/pdf/DITA-langref/ditaref-type  /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:xhtml   /i:doc/langref/ditaref-type.ditamap   /outdir:Output/%out%/Doc/xhtml/DITA-langref/ditaref-type  /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:eclipsecontent  /i:doc/langref/ditaref-type.ditamap    /outdir:Output/%out%/Doc/eclipsecontent/DITA-langref/ditaref-type /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml
java -jar lib\dost.jar   /transtype:troff       /i:doc/langref/ditaref-type.ditamap        /outdir:Output/%out%/Doc/troff/samples/DITA-langref/ditaref-type  /ditaext:.dita /ftr:C:\DITA-OT1.4.1\doc\langref\langref-footer.xml


REM to start  find the error reason 
echo begin to call section  DOC/DITA-installguide
REM DOC/DITA-installguide
java -jar lib\dost.jar   /transtype:docbook   /i:doc/installguide/installing-ditaot.ditamap   /outdir:Output/%out%/Doc/docbook/DITA-installguide
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:doc/installguide/installing-ditaot.ditamap   /outdir:Output/%out%/Doc/eclipsehelp/DITA-installguide
java -jar lib\dost.jar   /transtype:htmlhelp   /i:doc/installguide/installing-ditaot.ditamap   /outdir:Output/%out%/Doc/htmlhelp/DITA-installguide 
java -jar lib\dost.jar   /transtype:javahelp   /i:doc/installguide/installing-ditaot.ditamap   /outdir:Output/%out%/Doc/javahelp/DITA-installguide 
java -jar lib\dost.jar   /transtype:pdf   /i:doc/installguide/installing-ditaot.ditamap   /outdir:Output/%out%/Doc/pdf/DITA-installguide 
java -jar lib\dost.jar   /transtype:xhtml   /i:doc/installguide/installing-ditaot.ditamap   /outdir:Output/%out%/Doc/xhtml/DITA-installguide 
java -jar lib\dost.jar   /transtype:eclipsecontent  /i:doc/installguide/installing-ditaot.ditamap    /outdir:Output/%out%/Doc/eclipsecontent/DITA-installguide
java -jar lib\dost.jar   /transtype:troff       /i:doc/installguide/installing-ditaot.ditamap        /outdir:Output/%out%/Doc/troff/samples/DITA-installguide 

REM DOC/DITA-articles
java -jar lib\dost.jar   /transtype:docbook   /i:doc/articles/DITA-articles.ditamap   /outdir:Output/%out%/Doc/docbook/DITA-articles
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:doc/articles/DITA-articles.ditamap   /outdir:Output/%out%/Doc/eclipsehelp/DITA-articles
java -jar lib\dost.jar   /transtype:htmlhelp   /i:doc/articles/DITA-articles.ditamap   /outdir:Output/%out%/Doc/htmlhelp/DITA-articles 
java -jar lib\dost.jar   /transtype:javahelp   /i:doc/articles/DITA-articles.ditamap   /outdir:Output/%out%/Doc/javahelp/DITA-articles 
java -jar lib\dost.jar   /transtype:pdf   /i:doc/articles/DITA-articles.ditamap   /outdir:Output/%out%/Doc/pdf/DITA-articles 
java -jar lib\dost.jar   /transtype:xhtml   /i:doc/articles/DITA-articles.ditamap   /outdir:Output/%out%/Doc/xhtml/DITA-articles 
java -jar lib\dost.jar   /transtype:eclipsecontent  /i:doc/articles/DITA-articles.ditamap    /outdir:Output/%out%/Doc/eclipsecontent/DITA-articles
java -jar lib\dost.jar   /transtype:troff       /i:doc/articles/DITA-articles.ditamap        /outdir:Output/%out%/Doc/troff/samples/DITA-articles 


REM DITA to javahelp, xhtml, htmlhelp, docbook, pdf, eclipsehelp
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:Testdata/OldcasesTest/E003776.ditamap   /outdir:Output/%out%/OldcasesTest/eclipsehelp/E003776 /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:Testdata/OldcasesTest/P016893.ditamap   /outdir:Output/%out%/OldcasesTest/eclipsehelp/P016893 /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:Testdata/OldcasesTest/rowsep/rowsep.ditamap   /outdir:Output/%out%/OldcasesTest/eclipsehelp/rowsep /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:Testdata/OldcasesTest/com.ibm.nobel.museum/nobelmuseum.ditamap   /outdir:Output/%out%/OldcasesTest/eclipsehelp/nobelmuseum /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:Testdata/OldcasesTest/com.ibm.nobel.museum/nobellinks.ditamap   /outdir:Output/%out%/OldcasesTest/eclipsehelp/nobellinks /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:Testdata/OldcasesTest/com.ibm.nobel.prize/nobelprize.ditamap   /outdir:Output/%out%/OldcasesTest/eclipsehelp/nobelprize /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:Testdata/OldcasesTest/simplemap.ditamap   /outdir:Output/%out%/OldcasesTest/eclipsehelp/simplemap /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:Testdata/OldcasesTest/thisthat.ditamap   /outdir:Output/%out%/OldcasesTest/eclipsehelp/thisthat /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsehelp   /i:Testdata/OldcasesTest/infotypes.ditamap   /outdir:Output/%out%/OldcasesTest/eclipsehelp/infotypes /ditaext:.dita
java -jar lib\dost.jar   /transtype:htmlhelp   /i:Testdata/OldcasesTest/estonia.ditamap   /outdir:Output/%out%/OldcasesTest/htmlhelp/estonia /ditaext:.dita
java -jar lib\dost.jar   /transtype:htmlhelp   /i:Testdata/OldcasesTest/simplemap.ditamap   /outdir:Output/%out%/OldcasesTest/htmlhelp/simplemap /ditaext:.dita
java -jar lib\dost.jar   /transtype:htmlhelp   /i:Testdata/OldcasesTest/thisthat.ditamap   /outdir:Output/%out%/OldcasesTest/htmlhelp/thisthat /ditaext:.dita
java -jar lib\dost.jar   /transtype:htmlhelp   /i:Testdata/OldcasesTest/infotypes.ditamap   /outdir:Output/%out%/OldcasesTest/htmlhelp/infotypes /ditaext:.dita
java -jar lib\dost.jar   /transtype:htmlhelp   /i:Testdata/OldcasesTest/P016893.ditamap   /outdir:Output/%out%/OldcasesTest/htmlhelp /ditaext:.dita
java -jar lib\dost.jar   /transtype:javahelp   /i:Testdata/OldcasesTest/simplemap.ditamap   /outdir:Output/%out%/OldcasesTest/javahelp/simplemap /ditaext:.dita
java -jar lib\dost.jar   /transtype:javahelp   /i:Testdata/OldcasesTest/thisthat.ditamap   /outdir:Output/%out%/OldcasesTest/javahelp/thisthat /ditaext:.dita
java -jar lib\dost.jar   /transtype:javahelp   /i:Testdata/OldcasesTest/infotypes.ditamap   /outdir:Output/%out%/OldcasesTest/javahelp/infotypes /ditaext:.dita
java -jar lib\dost.jar   /transtype:pdf   /i:Testdata/OldcasesTest/estonia.ditamap   /outdir:Output/%out%/OldcasesTest/pdf/estonia /ditaext:.dita
java -jar lib\dost.jar   /transtype:pdf   /i:Testdata/OldcasesTest/E003523.ditamap   /outdir:Output/%out%/OldcasesTest/pdf/E003523 /ditaext:.dita
java -jar lib\dost.jar   /transtype:pdf   /i:Testdata/OldcasesTest/E003776.ditamap   /outdir:Output/%out%/OldcasesTest/pdf/E003776 /ditaext:.dita
java -jar lib\dost.jar   /transtype:pdf   /i:Testdata/OldcasesTest/R008361specific.ditamap   /outdir:Output/%out%/OldcasesTest/pdf/R008361specific /ditaext:.dita
java -jar lib\dost.jar   /transtype:pdf   /i:Testdata/OldcasesTest/com.ibm.nobel.museum/nobellinks.ditamap   /outdir:Output/%out%/OldcasesTest/pdf/nobellinks /ditaext:.dita
java -jar lib\dost.jar   /transtype:pdf   /i:Testdata/OldcasesTest/com.ibm.nobel.prize/nobelprize.ditamap   /outdir:Output/%out%/OldcasesTest/pdf/nobelprize /ditaext:.dita
java -jar lib\dost.jar   /transtype:pdf   /i:Testdata/OldcasesTest/com.ibm.nobel.museum/nobelmuseum.ditamap   /outdir:Output/%out%/OldcasesTest/pdf/nobelmuseum /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/ao0s1ph1.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/new.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/hi-d.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/pr-d.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/sw-d.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/ui-d.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/image.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/generalphrase.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/notetypes.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/everythinginsection.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/metaconcept.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/table.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/table-nocolnum.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/unordered-steps.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/metakeywords.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/dldlentry.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/relativecolumnwidth.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/proptable.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/xreftest.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/topicnest.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/simplemap.ditamap   /outdir:Output/%out%/OldcasesTest/xhtml/simplemap /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/thisthat.ditamap   /outdir:Output/%out%/OldcasesTest/xhtml/thisthat /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/infotypes.ditamap   /outdir:Output/%out%/OldcasesTest/xhtml/infotypes /ditaext:.dita
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/ao0s1ph1.dita /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita      /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/new.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-areg.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-beby.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-bgbg.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-caes.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-cscz.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-dadk.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-dech.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-dede.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-elgr.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-enca.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-engb.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-enus.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-eses.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-etee.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-fifi.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-frbe.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-frca.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-frch.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-frfr.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-heil.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-hrhr.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-huhu.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-isis.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-itch.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-itit.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-jajp.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-kokr.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-ltlt.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-lvlv.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-mkmk.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-next.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-nlbe.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-nlnl.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-nono.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-plpl.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-ptbr.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-ptpt.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-roro.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-ruru.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-sksk.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-slsi.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-srsp.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-svse.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-task.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-thth.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-trtr.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-ukua.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-zhcn.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/lang-zhtw.dita   /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval
java -jar lib\dost.jar   /transtype:xhtml   /i:Testdata/OldcasesTest/P018070.dita     /outdir:Output/%out%/OldcasesTest/xhtml /ditaext:.dita

java -jar lib\dost.jar   /transtype:docbook     /i:Testdata/OldcasesTest/DITA-OT1.0.2_NewTC/sequence.ditamap   /outdir:Output/%out%/OldcasesTest/DITA-OT1.0.2_NewTC/docbook/sequence 
java -jar lib\dost.jar   /transtype:eclipsehelp     /i:Testdata/OldcasesTest/DITA-OT1.0.2_NewTC/sequence.ditamap   /outdir:Output/%out%/OldcasesTest/DITA-OT1.0.2_NewTC/eclipsehelp/sequence 
java -jar lib\dost.jar   /transtype:htmlhelp     /i:Testdata/OldcasesTest/DITA-OT1.0.2_NewTC/sequence.ditamap   /outdir:Output/%out%/OldcasesTest/DITA-OT1.0.2_NewTC/htmlhelp/sequence 
java -jar lib\dost.jar   /transtype:javahelp     /i:Testdata/OldcasesTest/DITA-OT1.0.2_NewTC/sequence.ditamap   /outdir:Output/%out%/OldcasesTest/DITA-OT1.0.2_NewTC/javahelp/sequence 
java -jar lib\dost.jar   /transtype:pdf     /i:Testdata/OldcasesTest/DITA-OT1.0.2_NewTC/sequence.ditamap   /outdir:Output/%out%/OldcasesTest/DITA-OT1.0.2_NewTC/pdf/sequence 
java -jar lib\dost.jar   /transtype:xhtml     /i:Testdata/OldcasesTest/DITA-OT1.0.2_NewTC/sequence.ditamap   /outdir:Output/%out%/OldcasesTest/DITA-OT1.0.2_NewTC/xhtml/sequence 
java -jar lib\dost.jar   /transtype:docbook     /i:Testdata/OldcasesTest/DITA-OT1.0.2_NewTC/hierarchy.ditamap   /outdir:Output/%out%/OldcasesTest/DITA-OT1.0.2_NewTC/docbook/hierarchy 
java -jar lib\dost.jar   /transtype:eclipsehelp     /i:Testdata/OldcasesTest/DITA-OT1.0.2_NewTC/hierarchy.ditamap   /outdir:Output/%out%/OldcasesTest/DITA-OT1.0.2_NewTC/eclipsehelp/hierarchy 
java -jar lib\dost.jar   /transtype:htmlhelp     /i:Testdata/OldcasesTest/DITA-OT1.0.2_NewTC/hierarchy.ditamap   /outdir:Output/%out%/OldcasesTest/DITA-OT1.0.2_NewTC/htmlhelp/hierarchy 
java -jar lib\dost.jar   /transtype:javahelp     /i:Testdata/OldcasesTest/DITA-OT1.0.2_NewTC/hierarchy.ditamap   /outdir:Output/%out%/OldcasesTest/DITA-OT1.0.2_NewTC/javahelp/hierarchy 
java -jar lib\dost.jar   /transtype:pdf     /i:Testdata/OldcasesTest/DITA-OT1.0.2_NewTC/hierarchy.ditamap   /outdir:Output/%out%/OldcasesTest/DITA-OT1.0.2_NewTC/pdf/hierarchy 
java -jar lib\dost.jar   /transtype:xhtml     /i:Testdata/OldcasesTest/DITA-OT1.0.2_NewTC/hierarchy.ditamap   /outdir:Output/%out%/OldcasesTest/DITA-OT1.0.2_NewTC/xhtml/hierarchy 


REM DITA to eclipsecontent
java -jar lib\dost.jar   /transtype:eclipsecontent   /i:Testdata/OldcasesTest/E003776.ditamap   /outdir:Output/%out%/DITA2eclipsecontent/E003776 /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsecontent   /i:Testdata/OldcasesTest/P016893.ditamap   /outdir:Output/%out%/DITA2eclipsecontent/P016893 /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsecontent   /i:Testdata/OldcasesTest/rowsep/rowsep.ditamap   /outdir:Output/%out%/DITA2eclipsecontent/rowsep /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsecontent   /i:Testdata/OldcasesTest/com.ibm.nobel.museum/nobelmuseum.ditamap   /outdir:Output/%out%/DITA2eclipsecontent/nobelmuseum /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsecontent   /i:Testdata/OldcasesTest/com.ibm.nobel.museum/nobellinks.ditamap   /outdir:Output/%out%/DITA2eclipsecontent/nobellinks /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsecontent   /i:Testdata/OldcasesTest/com.ibm.nobel.prize/nobelprize.ditamap   /outdir:Output/%out%/DITA2eclipsecontent/nobelprize /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsecontent   /i:Testdata/OldcasesTest/simplemap.ditamap   /outdir:Output/%out%/DITA2eclipsecontent/simplemap /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsecontent   /i:Testdata/OldcasesTest/thisthat.ditamap   /outdir:Output/%out%/DITA2eclipsecontent/thisthat /ditaext:.dita
java -jar lib\dost.jar   /transtype:eclipsecontent   /i:Testdata/OldcasesTest/infotypes.ditamap   /outdir:Output/%out%/DITA2eclipsecontent/infotypes /ditaext:.dita

REM DITA to troff
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/ao0s1ph1.dita                  /outdir:Output/%out%/DITA2troff/ao0s1ph1   /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/new.ditaval   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/hi-d.dita                      /outdir:Output/%out%/DITA2troff/hi-d   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/pr-d.dita                      /outdir:Output/%out%/DITA2troff/pr-d   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/sw-d.dita                      /outdir:Output/%out%/DITA2troff/sw-d   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/ui-d.dita                      /outdir:Output/%out%/DITA2troff/ui-d   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/image.dita                     /outdir:Output/%out%/DITA2troff/image   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/generalphrase.dita             /outdir:Output/%out%/DITA2troff/generalphrase   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/notetypes.dita                 /outdir:Output/%out%/DITA2troff/notetypes   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/everythinginsection.dita       /outdir:Output/%out%/DITA2troff/everythinginsection   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/metaconcept.dita               /outdir:Output/%out%/DITA2troff/metaconcept   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/table.dita                     /outdir:Output/%out%/DITA2troff/table   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/table-nocolnum.dita            /outdir:Output/%out%/DITA2troff/table-nocolnum   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/unordered-steps.dita           /outdir:Output/%out%/DITA2troff/unordered-steps   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/metakeywords.dita              /outdir:Output/%out%/DITA2troff/metakeywords   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/dldlentry.dita                 /outdir:Output/%out%/DITA2troff/dldlentry   /ditaext:.dita   
REM java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/relativecolumnwidth.dita       /outdir:Output/%out%/DITA2troff/relativecolumnwidth   /ditaext:.dita   
REM java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/proptable.dita                 /outdir:Output/%out%/DITA2troff/proptable   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/xreftest.dita                  /outdir:Output/%out%/DITA2troff/xreftest   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/topicnest.dita                 /outdir:Output/%out%/DITA2troff/topicnest   /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/simplemap.ditamap              /outdir:Output/%out%/DITA2troff/simplemap /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/thisthat.ditamap               /outdir:Output/%out%/DITA2troff/thisthat  /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/infotypes.ditamap              /outdir:Output/%out%/DITA2troff/infotypes /ditaext:.dita   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/ao0s1ph1.dita                  /outdir:Output/%out%/DITA2troff/ /ditaext:.dita  /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/new.ditaval   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/lang-zhtw.dita                 /outdir:Output/%out%/DITA2troff/ /ditaext:.dita   /filter:c:/DITA-OT1.4.1/Testdata/OldcasesTest/lang-ref.ditaval   
java -jar lib\dost.jar  /transtype:troff   /i:Testdata/OldcasesTest/P018070.dita                   /outdir:Output/%out%/DITA2troff/ /ditaext:.dita 
REM *******************************************************************

echo *************End of one cycle******************
  goto :EOF
goto :EOF

echo *************End of test******************

endlocal