package org.dita.dost;

import org.junit.Test;

import static org.dita.dost.AbstractIntegrationTest.Transtype.PREPROCESS;

public class ChunkAttributeTest extends AbstractIntegrationTest {

    @Test
    public void testMap1() {
        test(new TestCase(PREPROCESS, "map1.ditamap"));
    }

    @Test
    public void testMap2() {
        test(new TestCase(PREPROCESS, "map2.ditamap"));
    }

    @Test
    public void testMap3() {
        test(new TestCase(PREPROCESS, "map3.ditamap"));
    }

    @Test
    public void testMap4() {
        test(new TestCase(PREPROCESS, "map4.ditamap"));
    }

    @Test
    public void testMap5() {
        test(new TestCase(PREPROCESS, "map5.ditamap"));
    }

    @Test
    public void testMap6() {
        test(new TestCase(PREPROCESS, "map6.ditamap"));
    }

    @Test
    public void testMap7() {
        test(new TestCase(PREPROCESS, "map7.ditamap"));
    }

    @Test
    public void testMap9() {
        test(new TestCase(PREPROCESS, "map9.ditamap"));
    }

    @Test
    public void testMap10() {
        test(new TestCase(PREPROCESS, "map10.ditamap"));
    }

    @Test
    public void testMap11() {
        test(new TestCase(PREPROCESS, "map11.ditamap"));
    }

}
