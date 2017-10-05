<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='title description category categoria groups subgroup brand color link image_link'/>
  <xsl:template match="/">
    <rss version="2.0" xmlns:g="http://base.google.com/ns/1.0" xmlns:c="http://base.google.com/cns/1.0">
      <channel>
        <xsl:for-each select="rss/channel/item">
          <xsl:if test="listprice != 0 and saleprice != 0 and amountPerInstallment != 0 and numberOfInstallment != 0">
            <item>
              <id><xsl:value-of select="id"/></id>
              <sku_id><xsl:value-of select="sku_id"/></sku_id>
              <title><xsl:value-of select="title"/></title>
              <description><xsl:value-of select="description"/></description>
              <category><xsl:value-of select="category"/></category>
              <categoria><xsl:value-of select="categoria"/></categoria>
              <categoria_id><xsl:value-of select="categoria_id"/></categoria_id>
              <groups><xsl:value-of select="groups"/></groups>
              <group_id><xsl:value-of select="group_id"/></group_id>
              <subgroup><xsl:value-of select="subgroup"/></subgroup>
              <subgroup_id><xsl:value-of select="subgroup_id"/></subgroup_id>
              <brand><xsl:value-of select="brand"/></brand>
              <brand_code><xsl:value-of select="brand_code"/></brand_code>
              <color_code><xsl:value-of select="color_code"/></color_code>
              <color><xsl:value-of select="color"/></color>
              <size><xsl:value-of select="size"/></size>
              <link><xsl:value-of select="link"/></link>
              <image_link><xsl:value-of select="image_link"/></image_link>
              <gender><xsl:value-of select="gender"/></gender>
              <gender_code><xsl:value-of select="gender_code"/></gender_code>
              <age><xsl:value-of select="age"/></age>
              <age_code><xsl:value-of select="age_code"/></age_code>
              <onsale><xsl:value-of select="onsale"/></onsale>
              <listprice><xsl:value-of select="listprice"/></listprice>
              <saleprice><xsl:value-of select="saleprice"/></saleprice>
              <amountPerInstallment><xsl:value-of select="amountPerInstallment"/></amountPerInstallment>
              <numberOfInstallment><xsl:value-of select="numberOfInstallment"/></numberOfInstallment>
              <free_ship><xsl:value-of select="free_ship"/></free_ship>
              <quantityAvailable><xsl:value-of select="quantityAvailable"/></quantityAvailable>
              <weight><xsl:value-of select="weight"/></weight>
            </item>
          </xsl:if>
        </xsl:for-each>
      </channel>
    </rss>
  </xsl:template>
</xsl:stylesheet>
