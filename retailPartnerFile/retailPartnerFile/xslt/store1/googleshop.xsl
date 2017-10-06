<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes'/>
  <xsl:key name='distinctModelo' match='catalogo/produto' use='./codModelo'/>
  <xsl:template match="/">
    <rss version ="2.0" xmlns:g="http://base.google.com/ns/1.0">
      <channel>
        <xsl:for-each select="catalogo/produto[generate-id() = generate-id(key('distinctModelo', ./codModelo))]">
          <item>
            <g:mpn>
              <xsl:value-of select="codModelo"/>
            </g:mpn>
            <g:id>
              <xsl:value-of select="codModelo"/>
            </g:id>
            <title>
              <xsl:value-of select="descricaoPDP"/>
              <xsl:value-of select="cor"/>
            </title>
            <g:quantity>
              <xsl:value-of select="quantidadeDisponivel"/>
            </g:quantity>
            <g:availability>in stock</g:availability>
            <xsl:if test="promocaoVigente = 'false'">
              <g:price>
                <xsl:value-of select="precoPromocional"/>
              </g:price>
            </xsl:if>
            <xsl:if test="promocaoVigente != 'false'">
              <g:price>
                <xsl:value-of select="precoBase"/>
              </g:price>
            </xsl:if>
            <link>
              <xsl:value-of select="linkPDP"/>&amp;utm_source=GoogleShop&amp;utm_medium=xml&amp;utm_campaign=GoogleShop-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/>
            </link>
            <adwords_redirect>
              <xsl:value-of select="linkPDP"/>&amp;utm_source=GoogleShop&amp;utm_medium=xml&amp;utm_campaign=GoogleShop-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/>&amp;adtype={ifpe:pe}{ifpla:pla}{ifdyn:dyn}
            </adwords_redirect>
            <g:condition>new</g:condition>
            <g:image_link>
              <xsl:value-of select="linkImagem"/>
            </g:image_link>
            <g:product_type>
              <xsl:value-of select="marca"/>&gt;<xsl:value-of select="grupo"/>&gt;<xsl:value-of select="categoria"/>
            </g:product_type>
            <description>
              <xsl:value-of select="descricaoPDP"/>
            </description>
            <g:google_product_category>
              <xsl:value-of select="categoria"/>&gt;<xsl:value-of select="grupo"/>&gt;<xsl:value-of select="marca"/>
            </g:google_product_category>
            <g:shipping_weight>
              <xsl:value-of select="peso"/>
            </g:shipping_weight>
            <g:brand>
              <xsl:value-of select="marca"/>
            </g:brand>
            <g:color>
              <xsl:value-of select="cor"/>
            </g:color>
            <g:size>
              <xsl:value-of select="tamanho"/>
            </g:size>
            <g:installment>
              <g:months>
                <xsl:value-of select="numeroParcela"/>
              </g:months>
              <g:amount>
                <xsl:value-of select="valorParcela"/> BRL
              </g:amount>
            </g:installment>
            <g:shipping>
              <g:country>BR</g:country>
              <g:service>Terrestre</g:service>
              <g:price>0,00</g:price>
            </g:shipping>
          </item>
        </xsl:for-each>
      </channel>
    </rss>
  </xsl:template>
</xsl:stylesheet>
