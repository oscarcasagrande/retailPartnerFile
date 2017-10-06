<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='link_produto nome_produto nivel_categoria img_produto'/>
  <xsl:template match="/">
    <Loja>
      <xsl:for-each select="catalogo/produto">
        <PRODUTO>
          <id_produto>
            <xsl:value-of select="codModelo"/>
            <xsl:value-of select="codCor"/>
          </id_produto>
          <link_produto>
            <xsl:value-of select="linkPDP"/>?utm_source=ConfieAqui&amp;utm_medium=xml&amp;utm_campaign=ConfieAqui-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/>
          </link_produto>
          <nome_produto>
            <xsl:value-of select="descricaoPDP"/>
          </nome_produto>
          <preco_produto>
            <xsl:value-of select="precoBase"/>
          </preco_produto>
          <preco_promocao>
            <xsl:value-of select="precoPromocional"/>
          </preco_promocao>
          <parcelamento>
            <xsl:value-of select="numeroParcela"/>
          </parcelamento>
          <nivel_categoria>
            <xsl:value-of select="grupo"/>
          </nivel_categoria>
          <img_produto>
            <xsl:value-of select="linkImagem"/>
          </img_produto>
        </PRODUTO>
      </xsl:for-each>
    </Loja>
  </xsl:template>
</xsl:stylesheet>