<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

<xsl:variable name="account">
  <xsl:value-of select="/user/@account"/>
</xsl:variable>

<xsl:template match="/">
  <html>
    <head>
      <title>
        <xsl:value-of select="$account"/>
        <xsl:text>.backpackit.com</xsl:text>
      </title>
      <link rel="stylesheet" href="lib/css/bootstrap.min.css"/>
      <link rel="stylesheet" href="lib/css/bootstrap-theme.min.css"/>
    </head>
    <body>
      <div class="container">
        <br/>
        <div class="jumbotron">
          <h1>
            <xsl:value-of select="$account"/>
            <xsl:text>.backpackit.com</xsl:text>
          </h1>
        </div>
        <ul>
          <xsl:for-each select="//page">
            <xsl:variable name="page_id">
              <xsl:value-of select="@id"/>
            </xsl:variable>
            <xsl:variable name="page_title">
              <xsl:value-of select="translate(@title, ' \/:?', '_____')" />
            </xsl:variable>
            <li>
              <a>
                <xsl:attribute name="href"><xsl:value-of select="$page_id"/>-<xsl:value-of select="$page_title"/>.html</xsl:attribute>
                <xsl:value-of select="@title"/>
              </a>
            </li>
            <xsl:result-document href="{$page_id}-{$page_title}.html" method="html" encoding="utf-8" indent="yes">
              <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
              <html>
                <head>
                  <title>
                    <xsl:value-of select="$account"/>
                    <xsl:text>.backpackit.com - </xsl:text>
                    <xsl:value-of select="@title"/>
                  </title>
                  <link rel="stylesheet" href="lib/css/bootstrap.min.css"/>
                  <link rel="stylesheet" href="lib/css/bootstrap-theme.min.css"/>
                  <script src="lib/js/jquery-1.11.0.min.js"></script>
                  <script src="lib/js/bootstrap.min.js"></script>
                  <script src="lib/js/textile.js"></script>
                  <style>
                    .page {
                      border: 1px solid #e1e1e8;
                      background-color: #f7f7f9;
                      border-radius: 4px;
                      padding: 1em;
                      margin-bottom: 1em;
                      margin-top: 2em;
                    }
                    .page h1 {
                      margin-top: 0px;
                    }
                    .email h1, .list h1, .separator h1, .note h1, .gallery h1 {
                      font-size: 1em;
                      margin-top: 1em;
                    }
                    ul {
                      list-style-type: none;
                      padding: 0px;
                      margin: 0px;
                    }
                    .separator hr {
                      margin-top: 0px;
                    }
                    .separator h1 {
                      margin-top: 1em;
                      margin-bottom: .25em;
                    }
                  </style>
                  <script>
                  $(document).ready(function(){
                    $('.textile').each(function( index ) {
                      var result = textile($(this).text()).replace(/^.p./,"").replace(/..p.$/,"");
                      $(this).replaceWith(result);
                    });
                  });
                  </script>
                </head>
                <body>
                  <div class="container" role="main">
                    <xsl:apply-templates select="."/>
                  </div>
                </body>
              </html>
            </xsl:result-document>
          </xsl:for-each>
        </ul>
      </div>
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

<xsl:template match="tags">
  <p>
    Tags:
    <xsl:apply-templates />
  </p>
</xsl:template>

<xsl:template match="tag">
  <button type="button" class="btn btn-default btn-xs" disabled="disabled"><xsl:value-of select="@name"/></button>
  <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
</xsl:template>

<xsl:template match="page|note|list|email|separator|gallery">
  <div>
    <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
    <xsl:attribute name="class"><xsl:value-of select ="name(.)"/></xsl:attribute>
    <h1>
      <xsl:if test="name(.) = 'email'">
        <span class="glyphicon glyphicon-envelope"></span>
        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
      </xsl:if>
      <xsl:value-of select="@title|@name|@subject"/>
    </h1>
    <xsl:choose>
      <xsl:when test="name(.) = 'page'">
        <xsl:apply-templates select="tags"/>
        <xsl:apply-templates select="belongings"/>
      </xsl:when>
      <xsl:when test="name(.) = 'separator'">
        <h1>
          <xsl:apply-templates/>
        </h1>
        <hr/>
      </xsl:when>
      <xsl:when test="name(.) = 'note'">
        <div class="textile">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:when test="name(.) = 'email'">
        <pre><code>
          <xsl:apply-templates />
        </code></pre>
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
    <xsl:choose>
      <xsl:when test="@completed = 'true'">
        <span class="glyphicon glyphicon-check"></span>
        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <span class="glyphicon glyphicon-unchecked"></span>
        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <div class="textile">
      <xsl:apply-templates />
    </div>
  </li>
</xsl:template>


<xsl:template match="images">
  <div class="row">
    <xsl:apply-templates />
  </div>
</xsl:template>

<xsl:template match="message">
  <p>
    <xsl:value-of select="."/>
  </p>
</xsl:template>

<xsl:template match="image">
  <div class="col-lg-2 col-sm-3 col-xs-4">
    <a>
      <xsl:attribute name="href"><xsl:value-of select="$account"/>.backpackit.com/assets/<xsl:value-of select="@id"/>/as/<xsl:value-of select="@file_name"/></xsl:attribute>
      <xsl:if test="@description">
        <xsl:attribute name="title">
          <xsl:value-of select="@description"/>
        </xsl:attribute>
      </xsl:if>
      <img class="thumbnail img-responsive">
        <xsl:attribute name="src"><xsl:value-of select="$account"/>.backpackit.com/thumbs/<xsl:value-of select="@id"/>/as/<xsl:value-of select="@file_name"/></xsl:attribute>
      </img>
    </a>
  </div>
</xsl:template>

<xsl:template match="attachment">
  <span class="glyphicon glyphicon-file"></span>
  <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
  <a>
    <xsl:attribute name="href"><xsl:value-of select="$account"/>.backpackit.com/assets/<xsl:value-of select="@id"/>/as/<xsl:value-of select="@file_name"/></xsl:attribute>
    <xsl:value-of select="@file_name"/>
  </a><br />
</xsl:template>

</xsl:stylesheet>