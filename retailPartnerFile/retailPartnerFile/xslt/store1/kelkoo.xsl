<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='Categoria Marca Nome Codigo Link Imagem Descricao'/>
  <xsl:template match="/">
    <produtos>
      <xsl:for-each select="catalogo/produto">
        <PRODUTO>
          <Categoria>
            <xsl:value-of select="grupo"/>
          </Categoria>
          <Marca>
            <xsl:value-of select="marca"/>
          </Marca>
          <Nome>
            <xsl:value-of select="descricaoPDP"/>
          </Nome>
          <Codigo>
            <xsl:value-of select="codModelo"/>
            <xsl:value-of select="codCor"/>
          </Codigo>
          <Preco>
            <xsl:value-of select="precoPromocional"/>
          </Preco>
          <nparcelar>
            <xsl:value-of select="numeroParcela"/>
          </nparcelar>
          <vparcelas>
            <xsl:value-of select="valorParcela"/>
          </vparcelas>
          <Disponibilidade>
            Em Estoque
          </Disponibilidade>
          <Link>
            <xsl:value-of select="linkPDP"/>?utm_source=Kelkoo&amp;utm_medium=xml&amp;utm_campaign=Kelkoo-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/>
          </Link>
          <Imagem>
            <xsl:value-of select="linkImagem"/>
          </Imagem>
          <Descricao>
            <xsl:value-of select="descricaoPDP"/>
          </Descricao>
        </PRODUTO>
      </xsl:for-each>
    </produtos>
  </xsl:template>
</xsl:stylesheet>