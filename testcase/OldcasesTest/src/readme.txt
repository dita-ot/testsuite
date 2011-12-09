Test case description

1. CR  (P016893)
files: CR.ditamap   CRtest102.dita  CRtwo.dita
Cross reference to topic with index terms in titles, gives a bad link
transformation: eclipsehelp eclipsecontent htmlhelp

2. E003776 (pending, test case not implemented)
files: E003776.ditamap  E003776topicc.dita  E003776generationsonline.dita  E003776concepta.dita
don't know what it tests
transformation: eclipsehelp pdf eclipsecontent

3. rowsep
file: rowsep/*
test separator in the table
transformation:eclipsehelp eclipsecontent

4. simplemap
file:simplemap.ditamap  child1.dita  child2.dita  child2a.dita  child2b.dita child3.dita simple.dita
test the hierarchy structure of ditamap
transformation:eclipsehelp eclipsecontent javahelp htmlhelp xhtml troff

5 thisthat
file:thisthat/*
test the function of move index entries from ditamap to topic
transformation:eclipsehelp eclipsecontent javahelp htmlhelp xhtml troff

6 infotypes
file:infotypes/*
test information types like topic task concept reference dita
transformation:eclipsehelp eclipsecontent javahelp htmlhelp xhtml troff

7 testprint (E003523)
file:testprint/*
test whether topicref will appear in toc after set @print="no"
transformation: pdf

8 outputclass (R008361specific)
files:outputclass/*
test whether @outputclass works for terms
transformation:pdf


10 hi-d.dita
files: hi-d.dita
test tags in highlight domain
transformation:xhtml troff

11 pr-d.dita
files: pr-d.dita
test tags in programming domain
transformation: xhtml troff

12 sw-d.dita
files: sw-d.dita
test tags in software domain
transformation: xhtml troff

13 ui-d.dita
files: ui-d.dita
test tags in ui domain
transformation: xhtml troff

14 image.dita 
files: image.dita smileface.jpg
test <image> tag and its attributes
transformation: xhtml troff

15 generalphrase.dita
files: generalphrase.dita
test phrases in dita
transformation: xhtml troff

16 notetypes.dita
files: notetypes.dita
test different types of <note> element
transformation: xhtml troff

17 everythinginsection.dita
files: infotypes/everythinginsection.dita
test subelements in <section> element
transformation: xhtml troff

18 metaconcept.dita
files: metaconcept.dita
test metadata elements in a concept topic
transformation: xhtml troff

19 table.dita
files: table.dita
test different kinds of table in dita
transformation: xhtml troff

20 table-nocolnum
files: table-nocolnum.dita
test table spans without @colnum specified
transformation: xhtml troff

21 unordered-steps.dita
files: unordered-steps.dita
test steps in task
transformation:xhtml troff

22 metakeywords
files: metakeywords.dita
test metadata in concept
transformation: xhtml troff

23 dldlentry
files: dldlentry.dita
test: <dl> element and <dlentry> element
transformation: xhtml troff

24 relativecolumnwidth
files: relativecolumnwidth.dita
test @relcolwidth in table elements
transformation: xhtml

25 proptable
files: proptable.dita
test test property table in a reference
transformation: xhtml

26 xreftest
files: xreftest.dita
test difference usage of xref element
transformation: xhtml troff

27 topicnest
files: topicnest.dita
test nested topics
transformation: xhtml troff

28 lang
files: lang/*
test language translation in toolkit for different languages
transformation: xhtml
filer: lang/lang-ref.ditaval

29 conrefbreaksxref
files: conrefbreaksxref/*
test whether conref will break original xref
transformation: xhtml troff
