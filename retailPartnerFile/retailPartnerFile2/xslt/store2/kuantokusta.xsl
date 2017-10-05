<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='NOME MARCA DESCRICAO CATEGORIA URL'/>
  <xsl:template match="/">
    <produtos>
    <xsl:for-each select="rss/channel/item">
      <PRODUTO>
        <CODIGOLOJA><xsl:value-of select="sku_id"/></CODIGOLOJA>
        <CODIGOBARRAS></CODIGOBARRAS>
        <CODIGOREFERENCIA></CODIGOREFERENCIA>
        <MODELO></MODELO>
        <NOME><xsl:value-of select="title"/></NOME>
        <MARCA><xsl:value-of select="brand"/></MARCA>
        <DESCRICAO><xsl:value-of select="description"/></DESCRICAO>
        <DEPARTAMENTO><xsl:value-of select="subgroup"/></DEPARTAMENTO>
        <CATEGORIA><xsl:value-of select="categoria"/></CATEGORIA>
        <URL><xsl:value-of select="link"/>?utm_source=KuantoKusta&amp;utm_medium=xml&amp;utm_campaign=KuantoKusta-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/></URL>
        <URL_IMAGEM><xsl:value-of select="image_link"/></URL_IMAGEM>
        <xsl:if test="listprice > saleprice">
        <PRECO_DE><xsl:value-of select="listprice"/></PRECO_DE>
        </xsl:if>
        <PRECO><xsl:value-of select="saleprice"/></PRECO>
        <NPARCELAS><xsl:value-of select="numberOfInstallment"/></NPARCELAS>
        <VALORDAPARCELA><xsl:value-of select="amountPerInstallment"/></VALORDAPARCELA>
      </PRODUTO>
    </xsl:for-each>
    </produtos>
  </xsl:template>
</xsl:stylesheet>