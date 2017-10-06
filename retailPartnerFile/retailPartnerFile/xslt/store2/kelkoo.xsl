<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='Categoria Marca Nome Codigo Link Imagem Descricao'/>
  <xsl:template match="/">
    <produtos>
      <xsl:for-each select="rss/channel/item">
        <PRODUTO>
          <Categoria>
            <xsl:value-of select="categoria"/>
          </Categoria>
          <Marca>
            <xsl:value-of select="brand"/>
          </Marca>
          <Nome>
            <xsl:value-of select="title"/>
          </Nome>
          <Codigo>
            <xsl:value-of select="id"/>
            <xsl:value-of select="color_code"/>
          </Codigo>
          <Preco>
            <xsl:value-of select="saleprice"/>
          </Preco>
          <nparcelar>
            <xsl:value-of select="numberOfInstallment"/>
          </nparcelar>
          <vparcelas>
            <xsl:value-of select="amountPerInstallment"/>
          </vparcelas>
          <Disponibilidade>
            Em Estoque
          </Disponibilidade>
          <Link>
            <xsl:value-of select="link"/>?utm_source=Kelkoo&amp;utm_medium=xml&amp;utm_campaign=Kelkoo-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/>
          </Link>
          <Imagem>
            <xsl:value-of select="image_link"/>
          </Imagem>
          <Descricao>
            <xsl:value-of select="title"/>
          </Descricao>
        </PRODUTO>
      </xsl:for-each>
    </produtos>
  </xsl:template>
</xsl:stylesheet>