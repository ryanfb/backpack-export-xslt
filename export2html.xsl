<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

<xsl:variable name="account">
  <xsl:value-of select="/user/@account"/>
</xsl:variable>

<xsl:template match="/">
  <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
  <html>
    <body>
      <xsl:apply-templates />
    </body>
  </html>
</xsl:template>

<!-- don't copy text nodes -->
<!-- <xsl:template match="text()" /> -->

<xsl:template match="position"/>

<xsl:template match="belongings">
  <xsl:for-each select="belonging">
    <xsl:variable name="wid" select="widget/@id" />
    <xsl:apply-templates select="//*[not(self::widget) and @id = $wid]" />
  </xsl:for-each>
</xsl:template>

<xsl:template match="page|note|list|email|separator">
  <div>
    <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
    <xsl:attribute name="class"><xsl:value-of select ="name(.)"/></xsl:attribute>
    <h1>
      <xsl:value-of select="@title|@name|@subject"/>
    </h1>
    <xsl:choose>
      <xsl:when test="name(.) = 'page'">
        <xsl:apply-templates select="belongings"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates />
      </xsl:otherwise>
    </xsl:choose>
  </div>
</xsl:template>

<xsl:template match="items">
  <ul>
    <xsl:apply-templates />
  </ul>
</xsl:template>

<xsl:template match="item">
  <li>
    <xsl:apply-templates />
  </li>
</xsl:template>

<xsl:template match="attachment">
  <a>
    <xsl:attribute name="href"><xsl:value-of select="$account"/>.backpackit.com/assets/<xsl:value-of select="@id"/>/as/<xsl:value-of select="@file_name"/></xsl:attribute>
    <xsl:value-of select="@file_name"/>
  </a><br />
</xsl:template>

</xsl:stylesheet>