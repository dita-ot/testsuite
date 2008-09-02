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

echo ********Extensible Metadata********
java -jar lib/dost.jar /i:testdata/02/02.ditamap /outdir:testoutput/%out%/02/docbook /transtype:docbook /filter:c:/dita-ot1.4.1/testdata/02/02.ditaval
java -jar lib/dost.jar /i:testdata/02/02.ditamap /outdir:testoutput/%out%/02/eclipsecontent /transtype:eclipsecontent /filter:c:/dita-ot1.4.1/testdata/02/02.ditaval
java -jar lib/dost.jar /i:testdata/02/02.ditamap /outdir:testoutput/%out%/02/eclipsehelp /transtype:eclipsehelp /filter:c:/dita-ot1.4.1/testdata/02/02.ditaval
java -jar lib/dost.jar /i:testdata/02/02.ditamap /outdir:testoutput/%out%/02/javahelp /transtype:javahelp /filter:c:/dita-ot1.4.1/testdata/02/02.ditaval
java -jar lib/dost.jar /i:testdata/02/02.ditamap /outdir:testoutput/%out%/02/htmlhelp /transtype:htmlhelp /filter:c:/dita-ot1.4.1/testdata/02/02.ditaval
java -jar lib/dost.jar /i:testdata/02/02.ditamap /outdir:testoutput/%out%/02/wordrtf /transtype:wordrtf /filter:c:/dita-ot1.4.1/testdata/02/02.ditaval
java -jar lib/dost.jar /i:testdata/02/02.ditamap /outdir:testoutput/%out%/02/pdf /transtype:pdf /filter:c:/dita-ot1.4.1/testdata/02/02.ditaval
java -jar lib/dost.jar /i:testdata/02/02.ditamap /outdir:testoutput/%out%/02/troff /transtype:troff /filter:c:/dita-ot1.4.1/testdata/02/02.ditaval
java -jar lib/dost.jar /i:testdata/02/02.ditamap /outdir:testoutput/%out%/02/xhtml /transtype:xhtml /filter:c:/dita-ot1.4.1/testdata/02/02.ditaval

echo ********ANT Refactor********
call ant -f build_demo.xml all
call ant -f demo\thesaurus\install-plugin.xml
call ant -f demo\thesaurus\run-ant.xml all

call ant -f build.xml -Dargs.input=testdata/03/03.ditamap -Doutput.dir=testoutput/%out%/03/build/docbook -Dtranstype=docbook -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build.xml -Dargs.input=testdata/03/03.ditamap -Doutput.dir=testoutput/%out%/03/build/eclipsecontent -Dtranstype=eclipsecontent -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build.xml -Dargs.input=testdata/03/03.ditamap -Doutput.dir=testoutput/%out%/03/build/eclipsehelp -Dtranstype=eclipsehelp -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build.xml -Dargs.input=testdata/03/03.ditamap -Doutput.dir=testoutput/%out%/03/build/htmlhelp -Dtranstype=htmlhelp -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build.xml -Dargs.input=testdata/03/03.ditamap -Doutput.dir=testoutput/%out%/03/build/javahelp -Dtranstype=javahelp -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build.xml -Dargs.input=testdata/03/03.ditamap -Doutput.dir=testoutput/%out%/03/build/pdf -Dtranstype=pdf -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build.xml -Dargs.input=testdata/03/03.ditamap -Doutput.dir=testoutput/%out%/03/build/troff -Dtranstype=troff -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build.xml -Dargs.input=testdata/03/03.ditamap -Doutput.dir=testoutput/%out%/03/build/wordrtf -Dtranstype=wordrtf -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build.xml -Dargs.input=testdata/03/03.ditamap -Doutput.dir=testoutput/%out%/03/build/xhtml -Dtranstype=xhtml -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita

call ant -f conductor.xml -Dargs.input=doc/articles/merge.ditamap -Doutput.dir=testoutput/%out%/03/conductor/doc/articles/merge/docbook -Dtranstype=docbook -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.xml
call ant -f conductor.xml -Dargs.input=doc/articles/DITA-articles.ditamap -Doutput.dir=testoutput/%out%/03/conductor/doc/articles/DITA-articles/eclipsecontent -Dtranstype=eclipsecontent -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.xml
call ant -f conductor.xml -Dargs.input=doc/installguide/installing-ditaot.ditamap -Doutput.dir=testoutput/%out%/03/conductor/doc/installguide/installing-ditaot/eclipsehelp -Dtranstype=eclipsehelp -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.xml
call ant -f conductor.xml -Dargs.input=doc/installguide/web_installing-ditaot.ditamap -Doutput.dir=testoutput/%out%/03/conductor/doc/installguide/web_installing-ditaot/htmlhelp -Dtranstype=htmlhelp -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.xml
call ant -f conductor.xml -Dargs.input=doc/installguide/installing-ditaot.ditamap -Doutput.dir=testoutput/%out%/03/conductor/doc/installguide/installing-ditaot/javahelp -Dtranstype=javahelp -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.xml
call ant -f conductor.xml -Dargs.input=doc/installguide/web_installing-ditaot.ditamap -Doutput.dir=testoutput/%out%/03/conductor/doc/installguide/web_installing-ditaot/pdf -Dtranstype=pdf -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.xml
call ant -f conductor.xml -Dargs.input=doc/userguide/DITA-userguide.ditamap -Doutput.dir=testoutput/%out%/03/conductor/doc/userguide/DITA-userguide/troff -Dtranstype=troff -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.xml
call ant -f conductor.xml -Dargs.input=doc/userguide/DITA-userguide.ditamap -Doutput.dir=testoutput/%out%/03/conductor/doc/userguide/DITA-userguide/wordrtf -Dtranstype=wordrtf -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.xml
call ant -f conductor.xml -Dargs.input=doc/DITA-readme.ditamap -Doutput.dir=testoutput/%out%/03/conductor/doc/DITA-readme/xhtml -Dtranstype=xhtml -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.xml

call ant -f build_dita2docbook.xml -Dargs.input=testdata/OldcasesTest/samples/hierarchy.ditamap -Doutput.dir=testoutput/%out%/03/dita2/OldcasesTest/samples/hierarchy/docbook -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.xml
call ant -f build_dita2eclipsehelp.xml -Dargs.input=testdata/OldcasesTest/samples/hierarchy.ditamap -Doutput.dir=testoutput/%out%/03/dita2/OldcasesTest/samples/hierarchy/eclipsehelp -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.xml
call ant -f build_dita2eclipsehelp.xml -Dargs.input=testdata/OldcasesTest/rowsep/rowsep.ditamap -Doutput.dir=testoutput/%out%/03/dita2/OldcasesTest/rowsep/rowsep/eclipsecontent -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build_dita2htmlhelp.xml -Dargs.input=testdata/OldcasesTest/samples/sequence.ditamap -Doutput.dir=testoutput/%out%/03/dita2/OldcasesTest/samples/sequence/htmlhelp -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.xml
call ant -f build_dita2javahelp.xml -Dargs.input=testdata/OldcasesTest/E003523.ditamap -Doutput.dir=testoutput/%out%/03/dita2/OldcasesTest/E003523/javahelp -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build_dita2pdf.xml -Dargs.input=testdata/OldcasesTest/E003776.ditamap -Doutput.dir=testoutput/%out%/03/dita2/OldcasesTest/E003776/pdf -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build_dita2troff.xml -Dargs.input=testdata/OldcasesTest/estonia.ditamap -Doutput.dir=testoutput/%out%/03/dita2/OldcasesTest/estonia/xml -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build_dita2wordrtf.xml -Dargs.input=testdata/OldcasesTest/infotypes.ditamap -Doutput.dir=testoutput/%out%/03/dita2/OldcasesTest/infotypes/wordrtf -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita
call ant -f build_dita2xhtml.xml -Dargs.input=testdata/OldcasesTest/P016893.ditamap -Doutput.dir=testoutput/%out%/03/dita2/OldcasesTest/P016893/xhtml -logger org.dita.dost.log.DITAOTBuildLogger -Ddita.extname=.dita

java -jar lib/dost.jar /i:testdata/03/03.ditamap /outdir:testoutput/%out%/03/java/docbook /transtype:docbook /ditaext:.dita
java -jar lib/dost.jar /i:testdata/03/03.ditamap /outdir:testoutput/%out%/03/java/eclipsecontent /transtype:eclipsecontent /ditaext:.dita
java -jar lib/dost.jar /i:testdata/03/03.ditamap /outdir:testoutput/%out%/03/java/eclipsehelp /transtype:eclipsehelp /ditaext:.dita
java -jar lib/dost.jar /i:testdata/03/03.ditamap /outdir:testoutput/%out%/03/java/javahelp /transtype:javahelp /ditaext:.dita
java -jar lib/dost.jar /i:testdata/03/03.ditamap /outdir:testoutput/%out%/03/java/htmlhelp /transtype:htmlhelp /ditaext:.dita
java -jar lib/dost.jar /i:testdata/03/03.ditamap /outdir:testoutput/%out%/03/java/pdf /transtype:pdf /ditaext:.dita
java -jar lib/dost.jar /i:testdata/03/03.ditamap /outdir:testoutput/%out%/03/java/troff /transtype:troff /ditaext:.dita
java -jar lib/dost.jar /i:testdata/03/03.ditamap /outdir:testoutput/%out%/03/java/wordrtf /transtype:wordrtf /ditaext:.dita
java -jar lib/dost.jar /i:testdata/03/03.ditamap /outdir:testoutput/%out%/03/java/xhtml /transtype:xhtml /ditaext:.dita

call ant -f testdata/03/importconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger docbook
call ant -f testdata/03/importconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger eclipsecontent
call ant -f testdata/03/importconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger eclipsehelp
call ant -f testdata/03/importconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger javahelp
call ant -f testdata/03/importconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger htmlhelp
call ant -f testdata/03/importconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger pdf
call ant -f testdata/03/importconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger troff
call ant -f testdata/03/importconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger wordrtf
call ant -f testdata/03/importconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger xhtml

call ant -f testdata/03/antconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger docbook
call ant -f testdata/03/antconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger eclipsecontent
call ant -f testdata/03/antconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger eclipsehelp
call ant -f testdata/03/antconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger javahelp
call ant -f testdata/03/antconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger htmlhelp
call ant -f testdata/03/antconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger pdf
call ant -f testdata/03/antconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger troff
call ant -f testdata/03/antconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger wordrtf
call ant -f testdata/03/antconductor.xml -logger org.dita.dost.log.DITAOTBuildLogger xhtml

call ant -f testdata/03/importbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger docbook
call ant -f testdata/03/importbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger eclipsecontent
call ant -f testdata/03/importbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger eclipsehelp
call ant -f testdata/03/importbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger javahelp
call ant -f testdata/03/importbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger htmlhelp
call ant -f testdata/03/importbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger pdf
call ant -f testdata/03/importbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger troff
call ant -f testdata/03/importbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger wordrtf
call ant -f testdata/03/importbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger xhtml

call ant -f testdata/03/antbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger docbook
call ant -f testdata/03/antbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger eclipsecontent
call ant -f testdata/03/antbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger eclipsehelp
call ant -f testdata/03/antbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger javahelp
call ant -f testdata/03/antbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger htmlhelp
call ant -f testdata/03/antbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger pdf
call ant -f testdata/03/antbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger troff
call ant -f testdata/03/antbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger wordrtf
call ant -f testdata/03/antbuild.xml -logger org.dita.dost.log.DITAOTBuildLogger xhtml

echo ********ICU********

java -jar lib/dost.jar /i:testdata/04/TC1/TC1.ditamap /outdir:testoutput/%out%/04/TC1/javahelp /transtype:javahelp /ditaext:dita
java -jar lib/dost.jar /i:testdata/04/TC2/TC2.ditamap /outdir:testoutput/%out%/04/TC2/javahelp /transtype:javahelp /ditaext:dita
java -jar lib/dost.jar /i:testdata/04/TC3/TC3.ditamap /outdir:testoutput/%out%/04/TC3/javahelp /transtype:javahelp /ditaext:dita
java -jar lib/dost.jar /i:testdata/04/TC4/TC4.ditamap /outdir:testoutput/%out%/04/TC4/javahelp /transtype:javahelp /ditaext:dita

java -jar lib/dost.jar /i:testdata/04/TC2/TC2.ditamap /outdir:testoutput/%out%/04/TC2/htmlhelp /transtype:htmlhelp /ditaext:dita

echo ********New Index Element********
java -jar lib/dost.jar /i:testdata/05/05.ditamap /outdir:testoutput/%out%/05/htmlhelp /transtype:htmlhelp
java -jar lib/dost.jar /i:testdata/05/05.ditamap /outdir:testoutput/%out%/05/javahelp /transtype:javahelp

echo ********Graphic Scaling********
java -jar lib/dost.jar /i:testdata/06/06.ditamap /outdir:testoutput/%out%/06/xhtml /transtype:xhtml

echo ********Shortdesc Proposal********
java -jar lib/dost.jar /i:testdata/07/07.ditamap /outdir:testoutput/%out%/07/htmlhelp /transtype:htmlhelp /ditaext:.dita
java -jar lib/dost.jar /i:testdata/07/07.ditamap /outdir:testoutput/%out%/07/eclipsehelp /transtype:eclipsehelp /ditaext:.dita

echo ********Data Unknow********
java -jar lib/dost.jar /i:testdata/08/08.ditamap /outdir:testoutput/%out%/08/docbook /transtype:docbook
java -jar lib/dost.jar /i:testdata/08/08.ditamap /outdir:testoutput/%out%/08/eclipsecontent /transtype:eclipsecontent
java -jar lib/dost.jar /i:testdata/08/08.ditamap /outdir:testoutput/%out%/08/eclipsehelp /transtype:eclipsehelp
java -jar lib/dost.jar /i:testdata/08/08.ditamap /outdir:testoutput/%out%/08/javahelp /transtype:javahelp
java -jar lib/dost.jar /i:testdata/08/08.ditamap /outdir:testoutput/%out%/08/htmlhelp /transtype:htmlhelp
java -jar lib/dost.jar /i:testdata/08/08.ditamap /outdir:testoutput/%out%/08/pdf /transtype:pdf
java -jar lib/dost.jar /i:testdata/08/08.ditamap /outdir:testoutput/%out%/08/wordrtf /transtype:wordrtf
java -jar lib/dost.jar /i:testdata/08/08.ditamap /outdir:testoutput/%out%/08/troff /transtype:troff
java -jar lib/dost.jar /i:testdata/08/08.ditamap /outdir:testoutput/%out%/08/xhtml /transtype:xhtml

echo ********Copy To********
java -jar lib/dost.jar /i:testdata/22/TC1.ditamap /outdir:testoutput/%out%/22/TC1/xhtml /transtype:xhtml /ditaext:.dita
java -jar lib/dost.jar /i:testdata/22/TC2.ditamap /outdir:testoutput/%out%/22/TC2/xhtml /transtype:xhtml /ditaext:.dita
java -jar lib/dost.jar /i:testdata/22/TC3.ditamap /outdir:testoutput/%out%/22/TC3/xhtml /transtype:xhtml /ditaext:.dita
java -jar lib/dost.jar /i:testdata/22/TC4.ditamap /outdir:testoutput/%out%/22/TC4/xhtml /transtype:xhtml /ditaext:.dita
java -jar lib/dost.jar /i:testdata/22/TC5.ditamap /outdir:testoutput/%out%/22/TC5/xhtml /transtype:xhtml
java -jar lib/dost.jar /i:testdata/22/TC6.ditamap /outdir:testoutput/%out%/22/TC6/xhtml /transtype:xhtml
java -jar lib/dost.jar /i:testdata/22/TC7.ditamap /outdir:testoutput/%out%/22/TC7/xhtml /transtype:xhtml

echo ********DITA Extension********
java -jar lib/dost.jar /i:testdata/12/TC1.ditamap /outdir:testoutput/%out%/12/TC1/xhtml /transtype:xhtml
java -jar lib/dost.jar /i:testdata/12/TC1.ditamap /outdir:testoutput/%out%/12/TC1/xhtml1 /transtype:xhtml /ditaext:.xml
java -jar lib/dost.jar /i:testdata/12/TC2.ditamap /outdir:testoutput/%out%/12/TC2/xhtml /transtype:xhtml
java -jar lib/dost.jar /i:testdata/12/TC2.ditamap /outdir:testoutput/%out%/12/TC2/xhtml1 /transtype:xhtml /ditaext:.dita
java -jar lib/dost.jar /i:testdata/12/TC3.ditamap /outdir:testoutput/%out%/12/TC3/xhtml /transtype:xhtml
java -jar lib/dost.jar /i:testdata/12/TC3.ditamap /outdir:testoutput/%out%/12/TC3/xhtml1 /transtype:xhtml /ditaext:.dita

echo ********Metadata Leftout********
java -jar lib/dost.jar /i:testdata/15/15.xml /outdir:testoutput/%out%/15/xhtml /transtype:xhtml /validate:no

echo ********Choicetable********
java -jar lib/dost.jar /i:testdata/16/16.ditamap /outdir:testoutput/%out%/16/docbook /transtype:docbook
java -jar lib/dost.jar /i:testdata/16/16.ditamap /outdir:testoutput/%out%/16/eclipsecontent /transtype:eclipsecontent
java -jar lib/dost.jar /i:testdata/16/16.ditamap /outdir:testoutput/%out%/16/eclipsehelp /transtype:eclipsehelp
java -jar lib/dost.jar /i:testdata/16/16.ditamap /outdir:testoutput/%out%/16/javahelp /transtype:javahelp
java -jar lib/dost.jar /i:testdata/16/16.ditamap /outdir:testoutput/%out%/16/htmlhelp /transtype:htmlhelp
java -jar lib/dost.jar /i:testdata/16/16.ditamap /outdir:testoutput/%out%/16/pdf /transtype:pdf
java -jar lib/dost.jar /i:testdata/16/16.ditamap /outdir:testoutput/%out%/16/troff /transtype:troff
java -jar lib/dost.jar /i:testdata/16/16.ditamap /outdir:testoutput/%out%/16/wordrtf /transtype:wordrtf
java -jar lib/dost.jar /i:testdata/16/16.ditamap /outdir:testoutput/%out%/16/xhtml /transtype:xhtml

echo ********Step Attribute********
java -jar lib/dost.jar /i:testdata/17/17.xml /outdir:testoutput/%out%/17/xhtml /transtype:xhtml /filter:c:/DITA-OT1.4.1/testdata/17/17.ditaval

echo ********Null Topichead********
java -jar lib/dost.jar /i:testdata/19/TC1.ditamap /outdir:testoutput/%out%/19/TC1/htmlhelp /transtype:htmlhelp
java -jar lib/dost.jar /i:testdata/19/TC2.ditamap /outdir:testoutput/%out%/19/TC2/htmlhelp /transtype:htmlhelp
java -jar lib/dost.jar /i:testdata/19/TC3.ditamap /outdir:testoutput/%out%/19/TC3/htmlhelp /transtype:htmlhelp
java -jar lib/dost.jar /i:testdata/19/TC4.ditamap /outdir:testoutput/%out%/19/TC4/htmlhelp /transtype:htmlhelp
java -jar lib/dost.jar /i:testdata/19/TC1.ditamap /outdir:testoutput/%out%/19/TC1/javahelp /transtype:javahelp
java -jar lib/dost.jar /i:testdata/19/TC2.ditamap /outdir:testoutput/%out%/19/TC2/javahelp /transtype:javahelp
java -jar lib/dost.jar /i:testdata/19/TC3.ditamap /outdir:testoutput/%out%/19/TC3/javahelp /transtype:javahelp
java -jar lib/dost.jar /i:testdata/19/TC4.ditamap /outdir:testoutput/%out%/19/TC4/javahelp /transtype:javahelp

echo ********Conref Only********
java -jar lib/dost.jar /i:testdata/23/TC1/tc1.xml /outdir:testoutput/%out%/23/tc1 /transtype:xhtml
java -jar lib/dost.jar /i:testdata/23/TC2/tc2.xml /outdir:testoutput/%out%/23/tc2 /transtype:xhtml
java -jar lib/dost.jar /i:testdata/23/TC3/tc3.xml /outdir:testoutput/%out%/23/tc3 /transtype:xhtml
java -jar lib/dost.jar /i:testdata/23/TC4/tc4.xml /outdir:testoutput/%out%/23/tc4 /transtype:xhtml
java -jar lib/dost.jar /i:testdata/23/TC5/tc5.xml /outdir:testoutput/%out%/23/tc5 /transtype:xhtml

echo ********a Override********
java -jar lib/dost.jar /i:testdata/24/24.xml /outdir:testoutput/%out%/24/xhtml /transtype:xhtml /xsl:testdata/24/24.xsl

echo *************End of one cycle******************
  goto :EOF
goto :EOF

echo *************End of test******************

endlocal
