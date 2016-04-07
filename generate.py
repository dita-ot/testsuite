#!/usr/bin/python

import sys
import os
import os.path

def main(id, input, types):
    casedir = os.path.join(os.path.abspath("."), "testcase", id)
    if not os.path.exists(casedir):
        os.makedirs(casedir)
    buildfile = os.path.join(casedir, "build.xml")
    if os.path.exists(buildfile):
        sys.stderr.write("Error: Test case " + buildfile + " already exists\n");
        sys.exit(2)
    case = open(buildfile, "w")
    try:
        case.write("""<?xml version="1.0" encoding="UTF-8"?>
<project name="%(id)s" default="all">
  <dirname property="test.basedir" file="${ant.file.%(id)s}"/>
  <property name="test.name" value="${ant.project.name}"/>
  <property name="dita.dir" location="${basedir}/../.."/>
  <property name="temp.dir" location="${dita.dir}/temp/${test.name}"/>
  <property name="result.dir" location="${dita.dir}/testresult/${test.name}"/>
  <target name="all" depends="%(default)s"/>\n""" % { "id": id, "default": ", ".join([id + "." + t for t in types]) })
        for t in types:
            __vals = { "id": id, "type": t, "input": input }
            case.write("""  <target name="%(id)s.%(type)s" if="run.%(type)s" unless="skip.%(type)s">
    <ant antfile="${dita.dir}/build.xml">\n""" % __vals)
            if t == "preprocess":
                case.write("""      <target name="build-init"/>
      <target name="preprocess"/>\n""")
            else:
                case.write("""      <property name="transtype" value="%(type)s"/>\n""" % __vals)
            case.write("""      <property name="args.input" location="${test.basedir}/src/%(input)s"/>
      <property name="output.dir" location="${result.dir}/%(type)s"/>
      <property name="dita.temp.dir" location="${temp.dir}/%(type)s"/>
    </ant>\n""" % __vals)
            if t == "preprocess":
                case.write("""    <copy todir="${result.dir}/preprocess">
      <fileset dir="${temp.dir}/preprocess"/>
    </copy>\n""")
            case.write("""  </target>\n""")
        case.write("""</project>""" % __vals)
    finally:
        case.close
    datadir = os.path.join(os.path.abspath("."), "testcase", id, "src")
    if not os.path.exists(datadir):
        os.makedirs(datadir)

default_types = ["html5", "xhtml", "eclipsehelp", "eclipsecontent", "javahelp", "htmlhelp", "pdf", "troff", "docbook", "wordrtf", "odt", "tocjs"]
valid_types = ["preprocess"]
valid_types.extend(default_types)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print "Usage: generate.py ID INPUT [TYPES]"
        print "  ID     test identfier"
        print "  INPUT  input document"
        print "  TYPES  transformation types:"
        for t in valid_types:
            print "         * " + t
        sys.exit(1)
    __id = sys.argv[1]
    __input = sys.argv[2]
    if len(sys.argv) > 3:
        __types = sys.argv[3:]
    else:
        __types = default_types
    for __t in __types:
        if not __t in valid_types:
            print "Error: Type %s is not a valid type" % __t
            sys.exit(1)
    main(__id, __input, __types)
