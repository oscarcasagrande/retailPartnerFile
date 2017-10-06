<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes'/>
  <xsl:key name='distinctModelo' match='item' use='./id'/>
  <xsl:template match="/">
    <rss version ="2.0" xmlns:g="http://base.google.com/ns/1.0">
      <channel>
        <xsl:for-each select="rss/channel/item[generate-id() = generate-id(key('distinctModelo', ./id))]">
          <item>
            <g:mpn>
              <xsl:value-of select="id"/>
            </g:mpn>
            <g:id>
              <xsl:value-of select="id"/>
            </g:id>
            <title>
              <xsl:value-of select="title"/>
              <xsl:value-of select="color"/>
            </title>
            <g:quantity>
              <xsl:value-of select="quantityAvailable"/>
            </g:quantity>
            <g:availability>in stock</g:availability>
            <g:price>
              <xsl:value-of select="saleprice"/>
            </g:price>
            <link>
              <xsl:value-of select="link"/>?utm_source=GoogleShop&amp;utm_medium=xml&amp;utm_campaign=GoogleShop-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/>
            </link>
            <adwords_redirect>
              <xsl:value-of select="link"/>?utm_source=GoogleShop&amp;utm_medium=xml&amp;utm_campaign=GoogleShop-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/>&amp;adtype={ifpe:pe}{ifpla:pla}{ifdyn:dyn}
            </adwords_redirect>
            <g:condition>new</g:condition>
            <g:image_link>
              <xsl:value-of select="image_link"/>
            </g:image_link>
            <g:product_type>
              <xsl:value-of select="brand"/>&gt;<xsl:value-of select="categoria"/>&gt;<xsl:value-of select="subgroup"/>
            </g:product_type>
            <description>
              <xsl:value-of select="title"/>
            </description>
            <g:google_product_category>
              <xsl:value-of select="subgroup"/>&gt;<xsl:value-of select="categoria"/>&gt;<xsl:value-of select="brand"/>
            </g:google_product_category>
            <g:shipping_weight>
              <xsl:value-of select="weight"/>
            </g:shipping_weight>
            <g:brand>
              <xsl:value-of select="brand"/>
            </g:brand>
            <g:color>
              <xsl:value-of select="color"/>
            </g:color>
            <g:size>
              <xsl:value-of select="size"/>
            </g:size>
            <g:installment>
              <g:months>
                <xsl:value-of select="numberOfInstallment"/>
              </g:months>
              <g:amount>
                <xsl:value-of select="amountPerInstallment"/> BRL
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
