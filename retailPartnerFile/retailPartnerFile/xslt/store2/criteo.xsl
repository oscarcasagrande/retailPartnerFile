<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements=''/>
  <xsl:key name='distinctModelo' match='item' use='./id'/>
  <xsl:template match="/">
    <products>
      <xsl:for-each select="rss/channel/item[generate-id() = generate-id(key('distinctModelo', ./id))]">
        <product>
          <xsl:attribute name="id">
            <xsl:value-of select="id"/>
          </xsl:attribute>
          <name>
            <xsl:value-of select="title"/>
          </name>
          <smallimage>
            <xsl:value-of select="image_link"/>
          </smallimage>
          <bigimage>
            http://images.lojista.com.br/900x900/<xsl:value-of select="id"/><xsl:value-of select="color_code"/>.jpg
          </bigimage>
          <producturl>
            <xsl:value-of select="link" />?utm_source=Criteo&amp;utm_medium=xml&amp;utm_campaign=Criteo-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/>
          </producturl>
          <description>
            <xsl:value-of select="title"/>
          </description>
          <price>
            <xsl:value-of select="saleprice"/>
          </price>
          <recommendable>1</recommendable>
          <instock>1</instock>
        </product>
      </xsl:for-each>
    </products>
  </xsl:template>
</xsl:stylesheet>