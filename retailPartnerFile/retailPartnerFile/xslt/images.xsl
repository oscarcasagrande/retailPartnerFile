<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements=''/>
  <xsl:key name='distinctModeloCor' match='item' use='substring(sku_id, 1, 8)' />
  <xsl:template match="/">
    <lojista>
      <xsl:for-each select="rss/channel/item[generate-id() = generate-id(key('distinctModeloCor', substring(sku_id, 1, 8)))]">
        <images>
          <xsl:attribute name="id">
            <xsl:value-of select="id"/>
          </xsl:attribute>
          <image>
            http://images.lojista.com.br/180x180/<xsl:value-of select="id"/><xsl:value-of select="color_code"/>.jpg
          </image>
          <image>
            http://images.lojista.com.br/180x180/<xsl:value-of select="id"/><xsl:value-of select="color_code"/>A1.jpg
          </image>
          <image>
            http://images.lojista.com.br/180x180/<xsl:value-of select="id"/><xsl:value-of select="color_code"/>A2.jpg
          </image>
          <image>
            http://images.lojista.com.br/180x180/<xsl:value-of select="id"/><xsl:value-of select="color_code"/>A3.jpg
          </image>
        </images>
      </xsl:for-each>
    </lojista>
  </xsl:template>
</xsl:stylesheet>