package org.dita.dost;

import com.google.common.collect.ImmutableMap;
import nu.validator.htmlparser.dom.HtmlDocumentBuilder;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.tools.ant.*;
import org.custommonkey.xmlunit.XMLUnit;
import org.junit.BeforeClass;
import org.w3c.dom.*;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.custommonkey.xmlunit.XMLAssert.assertEquals;
import static org.custommonkey.xmlunit.XMLAssert.assertXMLEqual;
import static org.dita.dost.util.Constants.*;
import static org.junit.Assert.assertArrayEquals;

public abstract class AbstractIntegrationTest {

    enum Transtype {
        HTML5, XHTML, ECLIPSEHELP, HTMLHELP, PREPROCESS, PDF
    }

    public static class TestCase {
        public final Transtype type;
        public final String transtype;
        public final Vector<String> targets;
        public final String input;
        public final Map<String, String> params;

        private TestCase(final Transtype type, final String transtype, final Vector<String> targets, final String input,
                         final Map<String, String> params) {
            this.type = type;
            this.transtype = transtype;
            this.targets = targets;
            this.input = input;
            this.params = params;
        }

        public TestCase(final Transtype type, final String input) {
            this.type = type;
            this.transtype = type.toString().toLowerCase();
            this.input = input;
            this.targets = new Vector<>();
            if (this.type == Transtype.PREPROCESS) {
                targets.addElement("build-init");
                targets.addElement("preprocess");
            } else {
                targets.addElement("dita2" + transtype);
            }
            this.params = Collections.emptyMap();
        }

//        public TestCase filter(final String filter) {
//            return new TestCase(type, targets, input,
//                    ImmutableMap.<String, String>builder()
//                            .putAll(params)
//                            .put("args.filter", filter)
//                            .build());
//        }
    }

    public static final String BASEDIR = "basedir";
    public static final String DITA_DIR = "dita_dir";
    public static final String LOG_LEVEL = "log_level";
    public static final String TEST = "test";

    private static final String EXP_DIR = "exp";

    private static final String ditaDirProperty = System.getProperty(DITA_DIR);
    private static final File ditaDir = new File(ditaDirProperty != null ? ditaDirProperty : "src" + File.separator + "main").getAbsoluteFile();
    private static final Collection<String> canCompare = Arrays.asList("html5", "xhtml", "eclipsehelp", "htmlhelp", "preprocess", "pdf");
    private static final File baseDir = new File(System.getProperty(BASEDIR) != null
            ? System.getProperty(BASEDIR)
            : "src" + File.separator + "test" + File.separator + "testsuite").getAbsoluteFile();
    private static final File resourceDir = new File(baseDir, "testcase").getAbsoluteFile();
    private static final File resultDir = new File(baseDir, "testresult").getAbsoluteFile();
    private static DocumentBuilder db;
    private static HtmlDocumentBuilder htmlb;
    private static int level;

    private File baseResultDir;
    private File baseTempDir;

    @BeforeClass
    public static void setUpBeforeClass() throws Exception {
        final DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        db = dbf.newDocumentBuilder();
        htmlb = new HtmlDocumentBuilder();
        final String l = System.getProperty(LOG_LEVEL);
        level = l != null ? Integer.parseInt(l) : -1;
    }

    public void test(final TestCase testCase) {
        final String testName = this.getClass().getSimpleName();

        baseResultDir = new File(resultDir, testName);
        baseTempDir = new File(ditaDir, "temp" + File.separator + testName);

        final File testDir = new File(resourceDir, testName);
        final File expDir = new File(testDir, EXP_DIR);
        List<TestListener.Message> log = null;
        try {
            log = run(testDir, testCase);
            final File exp = new File(expDir, testCase.transtype + File.separator + FilenameUtils.getBaseName(testCase.input));
            final File act = new File(resultDir, testName + File.separator + testCase.transtype + File.separator + FilenameUtils.getBaseName(testCase.input));
            compare(exp, act);
//            if (log != null && level >= 0) {
//                outputLog(log);
//            }
        } catch (final RuntimeException e) {
            throw e;
        } catch (final Throwable e) {
            if (log != null && level >= 0) {
                outputLog(log);
            }
            e.printStackTrace();
//            throw new Throwable("Case " + testDir.getName() + " failed: " + e.getMessage(), e);
        }
    }

    private void outputLog(List<TestListener.Message> log) {
        for (final TestListener.Message m : log) {
            if (m.level <= level) {
                switch (m.level) {
                    case -1:
                        break;
                    case Project.MSG_ERR:
                        System.err.print("ERROR: ");
                        break;
                    case Project.MSG_WARN:
                        System.err.print("WARN:  ");
                        break;
                    case Project.MSG_INFO:
                        System.err.print("INFO:  ");
                        break;
                    case Project.MSG_VERBOSE:
                        System.err.print("VERBO: ");
                        break;
                    case Project.MSG_DEBUG:
                        System.err.print("DEBUG: ");
                        break;
                }
                System.err.println(m.message);
            }
        }
    }

    private int countMessages(final List<TestListener.Message> messages, final int level) {
        int count = 0;
        for (final TestListener.Message m : messages) {
            if (m.level == level) {
                count++;
            }
        }
        return count;
    }

    /**
     * Run test conversion
     *
     * @param sourceDir test source directory
     * @param testCase  list of transtypes to test
     * @return list of log messages
     * @throws Exception if conversion failed
     */
    private List<TestListener.Message> run(final File sourceDir, final TestCase testCase) throws Exception {
        final File inputFile = new File(sourceDir, "src" + File.separator + testCase.input);
        final File resultDir = new File(baseResultDir, testCase.transtype + File.separator + FilenameUtils.getBaseName(testCase.input));
        final File tempDir = new File(baseTempDir, testCase.transtype + File.separator + FilenameUtils.getBaseName(testCase.input));

        FileUtils.deleteDirectory(resultDir);
        FileUtils.deleteDirectory(tempDir);

        final TestListener listener = new TestListener(System.out, System.err);
        final PrintStream savedErr = System.err;
        final PrintStream savedOut = System.out;
        try {
            final File buildFile = new File(ditaDir, "build.xml");
            final Project project = new Project();
            project.addBuildListener(listener);
            System.setOut(new PrintStream(new DemuxOutputStream(project, false)));
            System.setErr(new PrintStream(new DemuxOutputStream(project, true)));
            project.fireBuildStarted();
            project.init();
//            for (final String transtype : transtypes) {
//                if (canCompare.contains(transtype)) {
//                    project.setUserProperty("run." + transtype, "true");
//                    if (transtype.equals("pdf") || transtype.equals("pdf2")) {
//                        project.setUserProperty("pdf.formatter", "fop");
//                        project.setUserProperty("fop.formatter.output-format", "text/plain");
//                    }
//                }
//            }
            project.setUserProperty("generate-debug-attributes", "false");
            project.setUserProperty("preprocess.copy-generated-files.skip", "true");
            project.setUserProperty("ant.file", buildFile.getAbsolutePath());
            project.setUserProperty("ant.file.type", "file");
            project.setUserProperty("args.input", inputFile.getAbsolutePath());
//            project.setUserProperty("dita.dir", ditaDir.getAbsolutePath());
            project.setUserProperty("output.dir", resultDir.getAbsolutePath());
            project.setUserProperty("dita.temp.dir", tempDir.getAbsolutePath());
            project.setUserProperty("transtype", testCase.type == Transtype.PREPROCESS
                    ? Transtype.HTML5.toString().toLowerCase()
                    : testCase.toString().toLowerCase());
            for (final Map.Entry<String, String> param : testCase.params.entrySet()) {
                project.setUserProperty(param.getKey(), param.getValue());
            }
            project.setKeepGoingMode(false);
            ProjectHelper.configureProject(project, buildFile);
            project.executeTargets(testCase.targets);

            assertEquals("Warn message count does not match expected",
                    getMessageCount(project, "warn"),
                    countMessages(listener.messages, Project.MSG_WARN));
            assertEquals("Error message count does not match expected",
                    getMessageCount(project, "error"),
                    countMessages(listener.messages, Project.MSG_ERR));

            if (testCase.type == Transtype.PREPROCESS) {
                FileUtils.copyDirectory(tempDir, resultDir);
            }
        } finally {
            System.setOut(savedOut);
            System.setErr(savedErr);
            return listener.messages;
        }
    }

    private int getMessageCount(final Project project, final String type) {
        int errorCount = 0;
        if (isWindows() && project.getProperty("exp.message-count." + type + ".windows") != null) {
            errorCount = Integer.parseInt(project.getProperty("exp.message-count." + type + ".windows"));
        } else if (project.getProperty("exp.message-count." + type) != null) {
            errorCount = Integer.parseInt(project.getProperty("exp.message-count." + type));
        }
        return errorCount;
    }

    private static boolean isWindows() {
        final String osName = System.getProperty("os.name");
        return osName.startsWith("Windows");
    }

    private void compare(final File expDir, final File actDir) throws Throwable {
        for (final File exp : expDir.listFiles()) {
            final File act = new File(actDir, exp.getName());
            if (act.exists()) {
                if (exp.isDirectory()) {
                    compare(exp, act);
                } else {
                    final String name = exp.getName();
                    try {
                        if (name.endsWith(".html") || name.endsWith(".htm") || name.endsWith(".xhtml")
                                || name.endsWith(".hhk")) {
                            TestUtils.resetXMLUnit();
                            XMLUnit.setNormalizeWhitespace(true);
                            XMLUnit.setIgnoreWhitespace(true);
                            XMLUnit.setIgnoreDiffBetweenTextAndCDATA(true);
                            XMLUnit.setIgnoreComments(true);
                            assertXMLEqual(parseHtml(exp), parseHtml(act));
                        } else if (name.endsWith(".xml") || name.endsWith(".dita") || name.endsWith(".ditamap")) {
                            TestUtils.resetXMLUnit();
                            XMLUnit.setNormalizeWhitespace(true);
                            XMLUnit.setIgnoreWhitespace(true);
                            XMLUnit.setIgnoreDiffBetweenTextAndCDATA(true);
                            XMLUnit.setIgnoreComments(true);
                            assertXMLEqual(parseXml(exp), parseXml(act));
                        } else if (name.endsWith(".txt")) {
                            //assertEquals(readTextFile(e), readTextFile(a));
                            assertArrayEquals(readTextFile(exp), readTextFile(act));
                        }
                    } catch (final RuntimeException ex) {
                        throw ex;
                    } catch (final Throwable ex) {
                        throw new Throwable("Failed comparing " + exp.getAbsolutePath() + " and " + act.getAbsolutePath() + ": " + ex.getMessage(), ex);
                    }
                }
            }
        }
    }

    /**
     * Read text file into a string.
     *
     * @param f file to read
     * @return file contents
     * @throws IOException if reading file failed
     */
    private String[] readTextFile(final File f) throws IOException {
        final List<String> buf = new ArrayList<String>();
        try (final BufferedReader r = new BufferedReader(new InputStreamReader(new FileInputStream(f), "UTF-8"))) {
            String l = null;
            while ((l = r.readLine()) != null) {
                buf.add(l);
            }
        } catch (final IOException e) {
            throw new IOException("Unable to read " + f.getAbsolutePath() + ": " + e.getMessage());
        }
        return buf.toArray(new String[buf.size()]);
    }

    private static final Map<String, Pattern> htmlIdPattern = new HashMap<String, Pattern>();
    private static final Map<String, Pattern> ditaIdPattern = new HashMap<String, Pattern>();

    static {
        final String SAXON_ID = "d\\d+e\\d+";
        htmlIdPattern.put("id", Pattern.compile("(.*__)" + SAXON_ID + "|" + SAXON_ID + "(.*)"));
        htmlIdPattern.put("href", Pattern.compile("#.+?/" + SAXON_ID + "|#(.+?__)?" + SAXON_ID + "(.*)"));
        htmlIdPattern.put("headers", Pattern.compile(SAXON_ID + "(.*)"));

        ditaIdPattern.put("id", htmlIdPattern.get("id"));
        ditaIdPattern.put("href", Pattern.compile("#.+?/" + SAXON_ID + "|#(.+?__)?" + SAXON_ID + "(.*)"));
    }

    private Document parseHtml(final File f) throws SAXException, IOException {
        Document d = htmlb.parse(f);
        d = removeCopyright(d);
        return rewriteIds(d, htmlIdPattern);
    }

    private Document parseXml(final File f) throws SAXException, IOException {
        final Document d = db.parse(f);
        final NodeList elems = d.getElementsByTagName("*");
        for (int i = 0; i < elems.getLength(); i++) {
            final Element e = (Element) elems.item(i);
            // remove debug attributes
            e.removeAttribute(ATTRIBUTE_NAME_XTRF);
            e.removeAttribute(ATTRIBUTE_NAME_XTRC);
            // remove DITA version and domains attributes
            e.removeAttributeNS(DITA_NAMESPACE, ATTRIBUTE_NAME_DITAARCHVERSION);
            e.removeAttribute(ATTRIBUTE_NAME_DOMAINS);
            // remove workdir processing instructions
            removeWorkdirProcessingInstruction(e);
        }
        // rewrite IDs
        return rewriteIds(d, ditaIdPattern);
    }

    private void removeWorkdirProcessingInstruction(final Element e) {
        Node n = e.getFirstChild();
        while (n != null) {
            final Node next = n.getNextSibling();
            if (n.getNodeType() == Node.PROCESSING_INSTRUCTION_NODE &&
                    (n.getNodeName().equals(PI_WORKDIR_TARGET) || n.getNodeName().equals(PI_WORKDIR_TARGET_URI))) {
                e.removeChild(n);
            }
            n = next;
        }
    }

    private Document removeCopyright(final Document doc) {
        final NodeList ns = doc.getElementsByTagName("meta");
        for (int i = 0; i < ns.getLength(); i++) {
            final Element e = (Element) ns.item(i);
            final String name = e.getAttribute("name");
            if (name.equals("copyright") || name.equals("DC.rights.owner")) {
                e.removeAttribute("content");
            }
        }
        return doc;
    }

    private Document rewriteIds(final Document doc, final Map<String, Pattern> patterns) {
        final Map<String, String> idMap = new HashMap<String, String>();
        AtomicInteger counter = new AtomicInteger();
        final NodeList ns = doc.getElementsByTagName("*");
        for (int i = 0; i < ns.getLength(); i++) {
            final Element e = (Element) ns.item(i);
            for (Map.Entry<String, Pattern> p : patterns.entrySet()) {
                final Attr id = e.getAttributeNode(p.getKey());
                if (id != null) {
                    if (p.getKey().equals("headers")) {// split value
                        final List<String> res = new ArrayList<String>();
                        for (final String v : id.getValue().trim().split("\\s+")) {
                            rewriteId(v, idMap, counter, p.getValue());
                            if (idMap.containsKey(v)) {
                                res.add(idMap.get(v));
                            } else {
                                res.add(v);
                            }
                        }
                        id.setNodeValue(join(res));

                    } else {
                        final String v = id.getValue();
                        rewriteId(v, idMap, counter, p.getValue());
                        if (idMap.containsKey(v)) {
                            id.setNodeValue(idMap.get(v));
                        }
                    }
                }
            }
        }
        return doc;
    }

    private String join(final List<String> vals) {
        final StringBuilder buf = new StringBuilder();
        for (final Iterator<String> i = vals.iterator(); i.hasNext(); ) {
            buf.append(i.next());
            if (i.hasNext()) {
                buf.append(" ");
            }
        }
        return buf.toString();
    }

    /**
     * @param id      old ID value
     * @param idMap   ID map
     * @param counter counter
     * @param pattern pattern to test
     */
    private void rewriteId(final String id, final Map<String, String> idMap, final AtomicInteger counter, final Pattern pattern) {
        final Matcher m = pattern.matcher(id);
        if (m.matches()) {
            if (!idMap.containsKey(id)) {
                final int i = counter.addAndGet(1);
                final StringBuilder buf = new StringBuilder("gen-id-").append(Integer.toString(i));
                idMap.put(id, buf.toString());
            }
        }
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

        //@Override
        public void buildStarted(BuildEvent event) {
            messages.add(new Message(-1, "build started: " + event.getMessage()));
        }

        //@Override
        public void buildFinished(BuildEvent event) {
            messages.add(new Message(-1, "build finished: " + event.getMessage()));
        }

        //@Override
        public void targetStarted(BuildEvent event) {
            messages.add(new Message(-1, event.getTarget().getName() + ":"));
        }

        //@Override
        public void targetFinished(BuildEvent event) {
            messages.add(new Message(-1, "target finished: " + event.getTarget().getName()));
        }

        //@Override
        public void taskStarted(BuildEvent event) {
            messages.add(new Message(Project.MSG_DEBUG, "task started: " + event.getTask().getTaskName()));
        }

        //@Override
        public void taskFinished(BuildEvent event) {
            messages.add(new Message(Project.MSG_DEBUG, "task finished: " + event.getTask().getTaskName()));
        }

        //@Override
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