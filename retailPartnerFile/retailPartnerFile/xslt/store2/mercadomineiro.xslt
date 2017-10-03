﻿<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='NOME CATEGORIA SUBCATEGORIA'/>
  <xsl:template match="/">
    <produtos>
      <xsl:for-each select="rss/channel/item">
        <PRODUTO>
          <SKU><xsl:value-of select="id"/><xsl:value-of select="color_code"/></SKU>
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
          <IMAGEM><xsl:value-of select="image_link"/>?utm_source=MercadoMineiro&amp;utm_medium=xml&amp;utm_campaign=MercadoMineiro-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/>
          </IMAGEM>
          <DISPONIBILIDADE><xsl:value-of select="onsale"/></DISPONIBILIDADE>
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