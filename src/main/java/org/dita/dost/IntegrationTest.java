package org.dita.dost;

import static org.junit.Assert.assertEquals;
import static org.custommonkey.xmlunit.XMLAssert.assertXMLEqual;

import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Properties;
import java.util.Vector;
import java.util.regex.Pattern;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.tools.ant.DemuxOutputStream;

import org.apache.tools.ant.DemuxInputStream;

import nu.validator.htmlparser.dom.HtmlDocumentBuilder;

import org.apache.tools.ant.BuildEvent;
import org.apache.tools.ant.BuildListener;
import org.apache.tools.ant.MagicNames;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.ProjectHelper;
import org.custommonkey.xmlunit.XMLUnit;
import org.dita.dost.util.FileUtils;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

@RunWith(Parameterized.class)
public final class IntegrationTest {
    
    private static final Collection<String> canCompare = Arrays.asList(new String[] { "xhtml", "preprocess" });
    
    private static final File baseDir = new File(System.getProperty("basedir"));
    private static final File resourceDir = new File(baseDir, "testcase");
    private static final File resultDir = new File(baseDir, "testresult");
    private static DocumentBuilder db;
    private static HtmlDocumentBuilder htmlb;

    private final File testDir;
    
    /**
     * Get test cases
     * 
     * @return test cases which have comparable expected results
     */
    @Parameters
    public static Collection<Object[]> getFiles() {
        final File[] cases = resourceDir.listFiles(new FileFilter() {
            public boolean accept(File f) {
                if (!f.isDirectory() || !new File(f, "build.xml").exists()) {
                    return false;
                }
                final File exp = new File(f, "exp");
                if (exp.exists()) {
                    for (final String t: exp.list()) {
                        if (canCompare.contains(t)) {
                            return true;
                        }
                    }
                }
                return false;
            }}); 
        final Collection<Object[]> params = new ArrayList<Object[]>(cases.length);
        for (final File f : cases) {
                final Object[] arr = new Object[] { f };
                params.add(arr);
        }
        return params;
    }
    
    public IntegrationTest(final File testDir) {
        this.testDir = testDir;
    }
    
    @BeforeClass
    public static void setUpBeforeClass() throws Exception {
        db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
        htmlb = new HtmlDocumentBuilder();
    }
    
    @Test
    public void test() throws Exception {
        final File expDir = new File(testDir, "exp");
        System.out.println(testDir.getName());
        try {
            run(testDir, expDir.list());
            compare(expDir, new File(resultDir, testDir.getName()));
        } catch (final Exception e) {
            throw new Exception("Case " + testDir.getName() + " failed: " + e.getMessage(), e);
        }
        
    }
    
    private int countMessages(final List<TestListener.Message> messages, final int level) {
        int count = 0;
        for (final TestListener.Message m: messages) {
            if (m.level == level) {
                count++;
            }
        }
        return count;
    }

    /**
     * Run test conversion
     * 
     * @param d test source directory
     * @param transtypes list of transtypes to test
     * @throws Exception if conversion failed
     */
    private void run(final File d, final String[] transtypes) throws Exception {
        if (transtypes.length == 0) {
            return;
        }
        final TestListener listener = new TestListener(System.out, System.err);
        final PrintStream savedErr = System.err;
        final PrintStream savedOut = System.out;
        try {
            final File buildFile = new File(d, "build.xml");
            final Project project = new Project();
            project.addBuildListener(listener);
            System.setOut(new PrintStream(new DemuxOutputStream(project, false)));
            System.setErr(new PrintStream(new DemuxOutputStream(project, true)));
            project.fireBuildStarted();
            project.init();
            for (final String transtype: transtypes) {
                if (canCompare.contains(transtype)) {
                    project.setUserProperty("run." + transtype, "true");
                }
            }
            project.setUserProperty("preprocess.copy-generated-files.skip", "true");
            project.setUserProperty("ant.file", buildFile.getAbsolutePath());
            project.setUserProperty("ant.file.type", "file");
            final String ditaDirProperty = System.getProperty("dita.dir");
            project.setUserProperty("dita.dir", ditaDirProperty != null ? new File(ditaDirProperty).getAbsolutePath() : "");
            project.setKeepGoingMode(false);
            ProjectHelper.configureProject(project, buildFile);
            final Vector<String> targets = new Vector<String>();
            targets.addElement(project.getDefaultTarget());
            project.executeTargets(targets);
            
            assertEquals("Warn message count does not match expected",
                         project.getProperty("exp.message-count.warn") != null ? Integer.parseInt(project.getProperty("exp.message-count.warn")) : 0,
                         countMessages(listener.messages, Project.MSG_WARN));
            assertEquals("Error message count does not match expected",
                         project.getProperty("exp.message-count.error") != null ? Integer.parseInt(project.getProperty("exp.message-count.error")) : 0,
                         countMessages(listener.messages, Project.MSG_ERR ));
        } finally {
            System.setOut(savedOut);
            System.setErr(savedErr);
        }
    }
    
    private void compare(final File exp, final File act) throws Exception {
        for (final File e: exp.listFiles()) {
            final File a = new File(act, e.getName());
            if (a.exists()) {
                if (e.isDirectory()) {
                    compare(e, a);
                } else {
                    final String name = e.getName();
                    if (name.endsWith(".html") || name.endsWith(".htm") || name.endsWith(".xhtml")) {
                        TestUtils.resetXMLUnit();
                        XMLUnit.setNormalizeWhitespace(true);
                        XMLUnit.setIgnoreWhitespace(true);
                        XMLUnit.setIgnoreDiffBetweenTextAndCDATA(true);
                        assertXMLEqual(parseHtml(e), parseHtml(a));
                    } else if (FileUtils.isDITAFile(name)) {
                        TestUtils.resetXMLUnit();
                        XMLUnit.setNormalizeWhitespace(true);
                        XMLUnit.setIgnoreWhitespace(true);
                        XMLUnit.setIgnoreDiffBetweenTextAndCDATA(true);
                        assertXMLEqual(parseXml(e), parseXml(a));
                    }
                }
            }
        }
    }
    
    private Document parseHtml(final File f) throws SAXException, IOException {
        final Document d = htmlb.parse(f);
        return d;
    }
    
    private Document parseXml(final File f) throws SAXException, IOException {
        final Document d = db.parse(f);
        final NodeList elems = d.getElementsByTagName("*");
        for (int i = 0; i < elems.getLength(); i++) {
            final Element e = (Element) elems.item(i);
            for (final String a: new String[] {"xtrf", "xtrc"}) {
                e.removeAttribute(a);
            }
        }
        return d;
    }
    
    static class TestListener implements BuildListener {
        
        private final Pattern fatalPattern = Pattern.compile("\\[\\w+F\\]\\[FATAL\\]");
        private final Pattern errorPattern = Pattern.compile("\\[\\w+E\\]\\[ERROR\\]");
        private final Pattern warnPattern = Pattern.compile("\\[\\w+W\\]\\[WARN\\]");
        private final Pattern infoPattern = Pattern.compile("\\[\\w+I\\]\\[INFO\\]");
        private final Pattern debugPattern = Pattern.compile("\\[\\w+D\\]\\[DEBUG\\]");
        
        public final List<Message> messages = new ArrayList<Message>();
        final PrintStream out;
        final PrintStream err;
        
        public TestListener(final PrintStream out, final PrintStream err) {
            this.out = out;
            this.err = err;
        }
        
        @Override
        public void buildStarted(BuildEvent event) {
            //System.out.println("build started: " + event.getMessage());
        }

        @Override
        public void buildFinished(BuildEvent event) {
            //System.out.println("build finished: " + event.getMessage());
        }

        @Override
        public void targetStarted(BuildEvent event) {
            //System.out.println(event.getTarget().getName() + ":");
        }

        @Override
        public void targetFinished(BuildEvent event) {
            //System.out.println("target finished: " + event.getTarget().getName());
        }

        @Override
        public void taskStarted(BuildEvent event) {
            //System.out.println("task started: " + event.getTask().getTaskName());
        }

        @Override
        public void taskFinished(BuildEvent event) {
            //System.out.println("task finished: " + event.getTask().getTaskName());
        }

        @Override
        public void messageLogged(BuildEvent event) {
            final String message = event.getMessage();
            int level;
            if (fatalPattern.matcher(message).find()) {
                level = Project.MSG_ERR;
            } else if (errorPattern.matcher(message).find()) {
                level = Project.MSG_ERR;
            } else if (warnPattern.matcher(message).find()) {
                level = Project.MSG_WARN;
            } else if (infoPattern.matcher(message).find()) {
                level = Project.MSG_INFO;
            } else if (debugPattern.matcher(message).find()) {
                level = Project.MSG_DEBUG;
            } else {
                level = event.getPriority();
            }

            switch (level) {
            case Project.MSG_DEBUG:
            case Project.MSG_VERBOSE:
                break;
            case Project.MSG_INFO:
                // out.println(event.getMessage());
                break;
            default:
                err.println(message);
            }
            
            messages.add(new Message(level, message));
        }
        
        static class Message {
            
            public final int level;
            public final String message;
            
            public Message(final int level, final String message) {
                this.level = level;
                this.message = message;
            }
            
        }
        
    }
    
}