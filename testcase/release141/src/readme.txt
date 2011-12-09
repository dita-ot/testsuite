testcase:

1.input: abc.ditamap | transtype:xhtml
test whether &lt; &gt; is resolved in text and attribute value

2.input: booktest.ditamap | transtype:xhtml
test whether <mainbooktitle> can work in transformation for bookmap

3.input: plugintest.ditamap | transtype:eclipsehelp xhtml | needs eclipsemap plug-in
test whether <tocref> specialized from <topicref> will be resolved in transformation to eclipsemap
In eclipsehelp transformation, it is not expected to be resolved
In xhtml transformation, it is expected to be resolved.

4.input: test.ditamap | transtype:xhtml
test whether second level chunk will be processed correctly

5.input: chunk\chunk.ditamap | transtype:xhtml
Michael Priestley reported a bug against chunking. The problem appeared in release 1.4 that the second level "to-content" topicref couldn't be resolved.
This case is used to address the problem.

6.input: emptytopicref\a.ditamap | transtype:xhtml pdf2 | needs fo plug-in installed
This case is used to address three problem reported by Dick and Anna
a) empty <topicref> is generated as an empty bullet in toc of xhtml output.
Robert thinks the expected output should be if the empty <topicref> contains displayable sub <topicref>,
the sub <topicref> should be moved uplevel in the toc. If not, the empty <topicref> will be nothing in the toc.
b) <image> with @href in <title> elements will be treated as <topicref> in java topicmerge. It will generate 
"xxx.jpg cannot be read" exception when topics are being merged because jpg cannot be parsed by XML parser.
c) in SUN JDK 5 or above, new StreamResult(new File("abc.xml")) will generate error in runtime. This might be 
a bug in SUN JDK but we can avoid this problem by using  new StreamResult(new FileOutputStream(new File("abc.xml")))

7.input:flag\flag.dita | transtype: xhtml | ditaval: flag\flag.ditaval
This case is used to address the problem of copying flag pictures. We found that from release 1.2, all pictures 
referred in ditaval are copied to output directory with all path info removed. For example, I have a.ditaval and it 
referred to subdir\b.jpg. The picture will be copied to output\b.jpg instead of output\subdir\b.jpg

8.input:flag\test2.xml | transtype: xhtml | ditaval: flag\revision.ditaval
This case is used to address the problem of using revblock. In release 1.4, we updated to DITA 1.1 standard which 
contains completely new ditaval. Thus we re-implement flagging logic in xhtml transformation. "rev-block" template was changed 
to use new parameter but the code cannot fall back to the old version "rev-block" template if the new parameter wasn't passed.

9.input:hangs-in-move-meta\hangs-in-move-meta-1.ditamap, hangs-in-move-meta-2.ditamap, does-not-hangs-in-move-meta-3.ditamap, hangs-in-move-meta-4.ditamap | 
transtype:xhtml
This case is contributed by community user. It address the problem of the infinite loop in move-meta module when parent and child 
<topicref> refers to the same file.
reference: bug 1833801 Infinite loop in MapMetaReader

10.input: index\R009572index.ditamap | transtype:htmlhelp
This case is used to test whether <index-sort-as> takes effect in index processing

11.input: index\DITA-OT1.4.1\indexdir.ditamap | transtype:htmlhelp
This case is used to test whether index processing works in htmlhelp transformation

12.input: index\DITA-OT1.4.1-a\indexdir.ditamap | transtype:htmlhelp
This case is used to test whether index processing works in htmlhelp transformation

13.input: htmlhelp\infotypes.ditamap | transtype:htmlhelp
This case is used to test whether htmlhelp transformation works

14.input: move-meta-invalid-output\move-meta-invalid-out.ditamap | transtype:xhtml
This case addresses the problem of entity like &lt; is resolved during move-meta module

