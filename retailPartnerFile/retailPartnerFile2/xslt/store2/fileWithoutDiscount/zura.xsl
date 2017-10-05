<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='product_name link imgurl category category_id'/>
  <xsl:key name='distinctModeloCor' match='item' use='substring(sku_id, 1, 8)' />
	<xsl:template match="/">
		<centauro>
      <xsl:for-each select="rss/channel/item[generate-id() = generate-id(key('distinctModeloCor', substring(sku_id, 1, 8)))]">
			<product>
				<original_id><xsl:value-of select="substring(sku_id, 1, 8)" /></original_id>
				<product_name><xsl:value-of select="title"/></product_name>
				<originalvalue><xsl:value-of select="listprice"/></originalvalue>
				<finalvalue><xsl:value-of select="saleprice"/></finalvalue>
				<link><xsl:value-of select="link"/>?utm_source=Zura&amp;utm_medium=xml&amp;utm_campaign=Zura-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/></link>
				<imgurl><xsl:value-of select="image_link"/></imgurl>
				<category><xsl:value-of select="categoria"/></category>
				<category_id><xsl:value-of select="categoria_id"/></category_id>
				<description><xsl:value-of select="title"/></description>
				<parts><xsl:value-of select="numberOfInstallment"/></parts>
				<partValue><xsl:value-of select="amountPerInstallment"/></partValue>
			</product>
			</xsl:for-each>
		</centauro>
	</xsl:template>
</xsl:stylesheet>