<?xml version="1.0" encoding="UTF-8"?>
<!--  enote2html_shell.xsl
 | DITA domains support for the demo set; extend as needed
 |
 | (C) Copyright IBM Corporation 2001, 2004. All Rights Reserved.
 | This file is part of the DITA package on IBM's developerWorks site.
 | See license.txt for disclaimers and permissions.
 +
 | updates:
 *-->

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../../xsl/xslhtml/topic2htmlImpl.xsl"/>
<xsl:import href="../../xsl/xslhtml/domains2html.xsl"/>
<xsl:import href="enote2html.xsl"/>

<!-- HTML output with HTML 4.0 syntax) -->
<xsl:output method="html"
            encoding="utf-8"
            indent="no"
            doctype-system="http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd"
            doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
/>

</xsl:stylesheet>
