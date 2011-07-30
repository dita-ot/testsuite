<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs"
                version="2.0">
  
  <xsl:strip-space elements="*"/>
  
  <xsl:output indent="yes"/>
  
  <xsl:param name="dir"/>
  
  <xsl:template match="/comment()">
    <xsl:copy/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>
 
  <xsl:template match="project">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="name" select="$dir"/>
      <xsl:apply-templates select="*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="sequential/subant/fileset/@includes">
    <xsl:choose>
      <xsl:when test="concat($dir, '_*.xml') = .">
        <xsl:attribute name="includes">${ant.project.name}_*.xml</xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>  
  
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>