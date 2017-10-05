<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='NOME CATEGORIA SUBCATEGORIA'/>
  <xsl:key name='distinctModeloCor' match='item' use='substring(sku_id, 1, 8)' />
  <xsl:template match="/">
    <produtos>
      <xsl:for-each select="rss/channel/item[generate-id() = generate-id(key('distinctModeloCor', substring(sku_id, 1, 8)))]">
        <PRODUTO>
          <SKU><xsl:value-of select="substring(sku_id, 1, 8)" /></SKU>
          <NOME><xsl:value-of select="title"/></NOME>
          <CATEGORIA><xsl:value-of select="categoria"/></CATEGORIA>
          <SUBCATEGORIA><xsl:value-of select="subgroup"/></SUBCATEGORIA>
          <PRECO>
            <POR><xsl:value-of select="saleprice"/></POR>
          </PRECO>
          <PARCELAMENTO>
            <N_PARCELAS><xsl:value-of select="numberOfInstallment"/></N_PARCELAS>
            <V_PARCELAS><xsl:value-of select="amountPerInstallment"/></V_PARCELAS>
          </PARCELAMENTO>
          <FRETE>
            <GRATIS><xsl:value-of select="free_ship"/></GRATIS>
            <CONDICAO></CONDICAO>
          </FRETE>
          <URL><xsl:value-of select="link"/></URL>
          <IMAGEM><xsl:value-of select="image_link"/></IMAGEM>
          <DISPONIBILIDADE><xsl:value-of select="onsale"/></DISPONIBILIDADE>
          <VARIAVEIS>
            <VARIAVEL_A></VARIAVEL_A>
            <VARIAVEL_B><xsl:value-of select="color_code"/>?utm_source=WebDescontos&amp;utm_medium=xml&amp;utm_campaign=WebDescontos-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/></VARIAVEL_B>
            <VARIAVEL_C></VARIAVEL_C>
            <VARIAVEL_D></VARIAVEL_D>
            <VARIAVEL_E></VARIAVEL_E>
          </VARIAVEIS>
        </PRODUTO>
      </xsl:for-each>
    </produtos>
  </xsl:template>
</xsl:stylesheet>