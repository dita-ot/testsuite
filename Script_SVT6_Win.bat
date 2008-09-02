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


REM Regression Test of Major Fixes before DITA-OT1.2
REM TC33
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC1/abc.ditamap  /tempdir:tempSVT6   /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC1/xhtml     /ditaext:.dita   /transtype:xhtml  
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC1/wordrtf   /ditaext:.dita   /transtype:wordrtf  
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC1/pdf       /ditaext:.dita   /transtype:pdf  
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC1/javahelp  /ditaext:.dita   /transtype:javahelp  
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC1/htmlhelp  /ditaext:.dita   /transtype:htmlhelp  
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC1/troff     /ditaext:.dita   /transtype:troff  
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC1/docbook   /ditaext:.dita   /transtype:docbook  
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC1/eclipsehelp    /ditaext:.dita   /transtype:eclipsehelp 
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC1/eclipsecontent    /ditaext:.dita   /transtype:eclipsecontent

java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC2/nobelprize.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC2/xhtml     /ditaext:.dita   /transtype:xhtml  
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC2/nobelprize.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC2/wordrtf   /ditaext:.dita   /transtype:wordrtf  
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC2/nobelprize.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC2/pdf       /ditaext:.dita   /transtype:pdf 
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC2/nobelprize.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC2/javahelp  /ditaext:.dita   /transtype:javahelp  
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC2/nobelprize.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC2/htmlhelp  /ditaext:.dita   /transtype:htmlhelp  


REM java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC2/nobelprize.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC2/troff     /ditaext:.dita   /transtype:troff  
REM java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC2/nobelprize.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC2/docbook   /ditaext:.dita   /transtype:docbook  
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC2/nobelprize.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC2/eclipsehelp    /ditaext:.dita   /transtype:eclipsehelp 
java -jar lib/dost.jar /i:Testdata/XML_Catalog_Support/TC2/nobelprize.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/XML_Catalog_Support/TC2/eclipsecontent    /ditaext:.dita   /transtype:eclipsecontent

REM TC34
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC1/xhtml      /ditaext:.dita   /transtype:xhtml  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC1/wordrtf    /ditaext:.dita   /transtype:wordrtf  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC1/pdf        /ditaext:.dita   /transtype:pdf  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC1/javahelp   /ditaext:.dita   /transtype:javahelp  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC1/htmlhelp   /ditaext:.dita   /transtype:htmlhelp  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC1/troff      /ditaext:.dita   /transtype:troff  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC1/docbook    /ditaext:.dita   /transtype:docbook  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC1/eclipsehelp  /ditaext:.dita   /transtype:eclipsehelp 
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC1/eclipsecontent    /ditaext:.dita   /transtype:eclipsecontent

java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC2/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC2/xhtml     /transtype:xhtml 
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC2/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC2/wordrtf  /transtype:wordrtf  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC2/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC2/pdf        /transtype:pdf  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC2/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC2/javahelp   /transtype:javahelp  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC2/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC2/htmlhelp   /transtype:htmlhelp  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC2/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC2/troff      /transtype:troff  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC2/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC2/docbook    /transtype:docbook  
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC2/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC2/eclipsehelp   /transtype:eclipsehelp 
java -jar lib/dost.jar /i:Testdata/Topicref_refer_to_Nested_Topic/TC2/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Topicref_refer_to_Nested_Topic/TC2/eclipsecontent    /transtype:eclipsecontent


REM TC35
java -jar lib/dost.jar /i:Testdata/Index_information_in_output/TC1/hierarchy.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Index_information_in_output/TC1/javahelp  /transtype:javahelp  
java -jar lib/dost.jar /i:Testdata/Index_information_in_output/TC1/hierarchy.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Index_information_in_output/TC1/htmlhelp   /transtype:htmlhelp  

java -jar lib/dost.jar /i:Testdata/Index_information_in_output/TC2/sref_3584_pdf.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Index_information_in_output/TC2/javahelp  /transtype:javahelp  /ditaext:.dita
java -jar lib/dost.jar /i:Testdata/Index_information_in_output/TC2/sref_3584_pdf.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Index_information_in_output/TC2/htmlhelp   /transtype:htmlhelp  /ditaext:.dita


REM TC36
java -jar lib/dost.jar /i:Testdata/Mapref_Function/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Mapref_Function/TC1/xhtml      /transtype:xhtml  
java -jar lib/dost.jar /i:Testdata/Mapref_Function/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Mapref_Function/TC1/wordrtf    /transtype:wordrtf  
java -jar lib/dost.jar /i:Testdata/Mapref_Function/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Mapref_Function/TC1/pdf        /transtype:pdf  
java -jar lib/dost.jar /i:Testdata/Mapref_Function/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Mapref_Function/TC1/javahelp   /transtype:javahelp  
java -jar lib/dost.jar /i:Testdata/Mapref_Function/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Mapref_Function/TC1/htmlhelp   /transtype:htmlhelp  
java -jar lib/dost.jar /i:Testdata/Mapref_Function/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Mapref_Function/TC1/troff      /transtype:troff  
java -jar lib/dost.jar /i:Testdata/Mapref_Function/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Mapref_Function/TC1/docbook    /transtype:docbook  
java -jar lib/dost.jar /i:Testdata/Mapref_Function/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Mapref_Function/TC1/eclipsehelp     /transtype:eclipsehelp 
java -jar lib/dost.jar /i:Testdata/Mapref_Function/TC1/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Mapref_Function/TC1/eclipsecontent     /transtype:eclipsecontent

REM TC37
java -jar lib/dost.jar /i:Testdata/SF1220569/sequence.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/SF1220569/xhtml      /transtype:xhtml  
java -jar lib/dost.jar /i:Testdata/SF1220569/sequence.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/SF1220569/wordrtf    /transtype:wordrtf  
java -jar lib/dost.jar /i:Testdata/SF1220569/sequence.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/SF1220569/pdf        /transtype:pdf  
java -jar lib/dost.jar /i:Testdata/SF1220569/sequence.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/SF1220569/javahelp   /transtype:javahelp  
java -jar lib/dost.jar /i:Testdata/SF1220569/sequence.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/SF1220569/htmlhelp   /transtype:htmlhelp  
java -jar lib/dost.jar /i:Testdata/SF1220569/sequence.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/SF1220569/troff      /transtype:troff  
java -jar lib/dost.jar /i:Testdata/SF1220569/sequence.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/SF1220569/docbook    /transtype:docbook  
java -jar lib/dost.jar /i:Testdata/SF1220569/sequence.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/SF1220569/eclipsehelp     /transtype:eclipsehelp 
java -jar lib/dost.jar /i:Testdata/SF1220569/sequence.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/SF1220569/eclipsecontent     /transtype:eclipsecontent

REM TC38
java -jar lib/dost.jar /i:Testdata/Schema_Validation/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Schema_Validation/xhtml     /ditaext:.dita   /transtype:xhtml  
java -jar lib/dost.jar /i:Testdata/Schema_Validation/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Schema_Validation/wordrtf   /ditaext:.dita   /transtype:wordrtf  
java -jar lib/dost.jar /i:Testdata/Schema_Validation/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Schema_Validation/pdf       /ditaext:.dita   /transtype:pdf  
java -jar lib/dost.jar /i:Testdata/Schema_Validation/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Schema_Validation/javahelp  /ditaext:.dita   /transtype:javahelp  
java -jar lib/dost.jar /i:Testdata/Schema_Validation/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Schema_Validation/htmlhelp  /ditaext:.dita   /transtype:htmlhelp  
java -jar lib/dost.jar /i:Testdata/Schema_Validation/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Schema_Validation/troff     /ditaext:.dita   /transtype:troff  
java -jar lib/dost.jar /i:Testdata/Schema_Validation/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Schema_Validation/docbook   /ditaext:.dita   /transtype:docbook  
java -jar lib/dost.jar /i:Testdata/Schema_Validation/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Schema_Validation/eclipsehelp    /ditaext:.dita   /transtype:eclipsehelp 
java -jar lib/dost.jar /i:Testdata/Schema_Validation/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Schema_Validation/eclipsecontent    /ditaext:.dita   /transtype:eclipsecontent

REM TC39
REM java -jar lib/dost.jar /i:Testdata/Namespace_Prefix/b.dita      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Namespace_Prefix/xhtml     /ditaext:.dita   /transtype:xhtml  
REM java -jar lib/dost.jar /i:Testdata/Namespace_Prefix/b.dita      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Namespace_Prefix/wordrtf   /ditaext:.dita   /transtype:wordrtf  
REM java -jar lib/dost.jar /i:Testdata/Namespace_Prefix/b.dita      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/Namespace_Prefix/pdf       /ditaext:.dita   /transtype:pdf  

REM TC40
java -jar lib/dost.jar /i:Testdata/SF1196409/abc.ditamap      /tempdir:tempSVT6  /outdir:Output/%out%/MajorFixes_BeforeDITA-OT1.2/SF1196409  /ditaext:.dita   /transtype:htmlhelp 
REM *******************************************************************


echo *************End of one cycle******************
  goto :EOF
goto :EOF

echo *************End of test******************

endlocal