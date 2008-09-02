<?xml version="1.0" encoding="UTF-8" ?> 
<!--  (c) Copyright IBM Corp. All Rights Reserved.  --> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://icl.com/saxon" xmlns:xt="http://www.jclark.com/xt" extension-element-prefixes="saxon xt">
<!--  override --> 

<xsl:import href="../../xsl/dita2xhtml.xsl" /> 
<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/loose.dtd" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" /> 

<xsl:template name="add-user-link-attributes">
	<xsl:apply-templates select="@keyref" /> 
</xsl:template>

<xsl:template match="@keyref">
	<xsl:attribute name="keyref">
		<xsl:value-of select="." /> 
	</xsl:attribute>
</xsl:template>

</xsl:stylesheet>