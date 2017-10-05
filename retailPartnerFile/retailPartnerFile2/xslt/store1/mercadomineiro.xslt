<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='NOME CATEGORIA SUBCATEGORIA'/>
  <xsl:template match="/">
    <produtos>
      <xsl:for-each select="catalogo/produto">
        <PRODUTO>
          <SKU><xsl:value-of select="codModelo"/><xsl:value-of select="codCor"/></SKU>
          <NOME><xsl:value-of select="descricaoPDP"/></NOME>
          <CATEGORIA><xsl:value-of select="grupo"/></CATEGORIA>
          <SUBCATEGORIA><xsl:value-of select="categoria"/></SUBCATEGORIA>
          <PRECO>
            <POR><xsl:value-of select="precoPromocional"/></POR>
          </PRECO>
          <PARCELAMENTO>
            <N_PARCELAS><xsl:value-of select="numeroParcela"/></N_PARCELAS>
            <V_PARCELAS><xsl:value-of select="valorParcela"/></V_PARCELAS>
          </PARCELAMENTO>
          <FRETE>
            <GRATIS><xsl:value-of select="isFreteGratis"/></GRATIS>
            <CONDICAO></CONDICAO>
          </FRETE>
          <URL><xsl:value-of select="linkPDP"/></URL>
          <IMAGEM><xsl:value-of select="linkImagem"/>?utm_source=MercadoMineiro&amp;utm_medium=xml&amp;utm_campaign=MercadoMineiro-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/>
          </IMAGEM>
          <DISPONIBILIDADE>1</DISPONIBILIDADE>
          <VARIAVEIS>
            <VARIAVEL_A></VARIAVEL_A>
            <VARIAVEL_B></VARIAVEL_B>
            <VARIAVEL_C></VARIAVEL_C>
            <VARIAVEL_D></VARIAVEL_D>
            <VARIAVEL_E></VARIAVEL_E>
          </VARIAVEIS>
        </PRODUTO>
      </xsl:for-each>
    </produtos>
  </xsl:template>
</xsl:stylesheet>