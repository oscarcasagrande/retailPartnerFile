<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements=''/>
  <xsl:key name='distinctModelo' match='catalogo/produto' use='./codModelo'/>
  <xsl:template match="/">
    <products>
      <xsl:for-each select="catalogo/produto[generate-id() = generate-id(key('distinctModelo', ./codModelo))]">
        <product>
          <xsl:attribute name="id">
            <xsl:value-of select="codModelo"/>
          </xsl:attribute>
          <name><xsl:value-of select="descricaoPDP"/></name>
          <smallimage><xsl:value-of select="linkImagem"/></smallimage>
          <bigimage>http://images.lojista.com.br/900x900/<xsl:value-of select="codModelo"/><xsl:value-of select="codCor"/>.jpg</bigimage>
          <producturl><xsl:value-of select="linkPDP" />?utm_source=Criteo&amp;utm_medium=xml&amp;utm_campaign=Criteo-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/></producturl>
          <description><xsl:value-of select="descricaoPDP"/></description>
          <price><xsl:value-of select="precoPromocional"/></price>
          <recommendable>1</recommendable>
          <instock>1</instock>
        </product>
      </xsl:for-each>
    </products>
  </xsl:template>
</xsl:stylesheet>