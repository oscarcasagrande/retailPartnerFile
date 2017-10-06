<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='NOME MARCA DESCRICAO CATEGORIA URL'/>
  <xsl:template match="/">
    <produtos>
      <xsl:for-each select="catalogo/produto">
        <PRODUTO>
          <CODIGOLOJA>
            <xsl:value-of select="sku"/>
          </CODIGOLOJA>
          <CODIGOBARRAS></CODIGOBARRAS>
          <CODIGOREFERENCIA></CODIGOREFERENCIA>
          <MODELO></MODELO>
          <NOME>
            <xsl:value-of select="descricaoPDP"/>
          </NOME>
          <MARCA>
            <xsl:value-of select="marca"/>
          </MARCA>
          <DESCRICAO>
            <xsl:value-of select="description"/>
          </DESCRICAO>
          <DEPARTAMENTO>
            <xsl:value-of select="categoria"/>
          </DEPARTAMENTO>
          <CATEGORIA>
            <xsl:value-of select="grupo"/>
          </CATEGORIA>
          <URL>
            <xsl:value-of select="linkPDP"/>?utm_source=KuantoKusta&amp;utm_medium=xml&amp;utm_campaign=KuantoKusta-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/>
          </URL>
          <URL_IMAGEM>
            <xsl:value-of select="linkImagem"/>
          </URL_IMAGEM>
          <xsl:if test="precoBase > precoPromocional">
            <PRECO_DE>
              <xsl:value-of select="precoBase"/>
            </PRECO_DE>
          </xsl:if>
          <PRECO>
            <xsl:value-of select="precoPromocional"/>
          </PRECO>
          <NPARCELAS>
            <xsl:value-of select="numeroParcela"/>
          </NPARCELAS>
          <VALORDAPARCELA>
            <xsl:value-of select="valorParcela"/>
          </VALORDAPARCELA>
        </PRODUTO>
      </xsl:for-each>
    </produtos>
  </xsl:template>
</xsl:stylesheet>