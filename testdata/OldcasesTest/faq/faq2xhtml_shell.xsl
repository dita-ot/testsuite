<?xml version="1.0" encoding="UTF-8" ?>
<!--  
 | Specific override stylesheet for faq (demo)
 | This demonstrates the XSLT override mechanism tied to a specialization.
 |
 | (C) Copyright IBM Corporation 2001, 2002, 2003. All Rights Reserved.
 | This file is part of the DITA package on IBM's developerWorks site.
 | See license.txt for disclaimers.
 +
 | updates:
 *-->

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="faq2html_shellImpl.xsl"/>

<xsl:output
    method="xml"
    encoding="utf-8"
    indent="no"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
/>

<xsl:param name="OUTEXT" select="'xml'"/>

</xsl:stylesheet>
