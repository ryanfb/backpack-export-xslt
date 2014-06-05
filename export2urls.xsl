<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>
  <xsl:strip-space elements="*"/>

<xsl:variable name="account">
  <xsl:value-of select="/user/@account"/>
</xsl:variable>

<xsl:template match="/">
  <xsl:apply-templates />
</xsl:template>

<!-- don't copy text nodes -->
<xsl:template match="text()" />

<xsl:template match="attachment|image">
  <xsl:text>https://</xsl:text>
  <xsl:value-of select="$account"/>
  <xsl:text>.backpackit.com/assets/</xsl:text>
  <xsl:value-of select="@id"/>
  <xsl:text>/as/</xsl:text>
  <xsl:value-of select="@file_name"/>
  <xsl:text>
</xsl:text>
</xsl:template>

</xsl:stylesheet>