<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='NOME  CATEGORIA SUBCATEGORIA URL IMAGEM COR TAMANHO DATAATUALIZACAO'/>
  <xsl:template match="/">
    <produtos>
      <xsl:for-each select="rss/channel/item[brand_code='0002']">
        <PRODUTO>
          <SKU>
            <xsl:value-of select="sku_id"/>
          </SKU>
          <NOME>
            <xsl:value-of select="title"/>
          </NOME>
          <CATEGORIA>
            <xsl:value-of select="categoria"/>
          </CATEGORIA>
          <SUBCATEGORIA>
            <xsl:value-of select="subgroup"/>
          </SUBCATEGORIA>
          <PRECOPOR>
            <xsl:value-of select="saleprice"/>
          </PRECOPOR>
          <N_PARCELAS>
            <xsl:value-of select="numberOfInstallment"/>
          </N_PARCELAS>
          <V_PARCELAS>
            <xsl:value-of select="amountPerInstallment"/>
          </V_PARCELAS>
          <URL>
            <xsl:value-of select="link"/>?utm_source=Adidas&amp;utm_medium=xml&amp;utm_campaign=Adidas-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/>
          </URL>
          <IMAGEM>
            <xsl:value-of select="image_link"/>
          </IMAGEM>
          <TAMANHO>
            <xsl:value-of select="size"/>
          </TAMANHO>
          <COR>
            <xsl:value-of select="color"/>
          </COR>
          <QUANTIDADE>
            <xsl:value-of select="quantityAvailable"/>
          </QUANTIDADE>
          <DATAATUALIZACAO><![CDATA[22/9/2011 18:23:14]]></DATAATUALIZACAO>
        </PRODUTO>
      </xsl:for-each>
    </produtos>
  </xsl:template>
</xsl:stylesheet>