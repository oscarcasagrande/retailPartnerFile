<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='descricao link_prod imagem categ'/>
  <xsl:key name='distinctModeloCor' match='item' use='substring(sku_id, 1, 8)' />
	<xsl:template match="/">
		<centauro>
      <xsl:for-each select="rss/channel/item[generate-id() = generate-id(key('distinctModeloCor', substring(sku_id, 1, 8)))]">
			<produto>
				 <descricao><xsl:value-of select="title"/></descricao>
				 <preco><xsl:value-of select="saleprice"/></preco>
				 <id_produto><xsl:value-of select="substring(sku_id, 1, 8)" /></id_produto>
				 <link_prod><xsl:value-of select="link"/>?utm_source=Zoom&amp;utm_medium=xml&amp;utm_campaign=Zoom-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/></link_prod>
				 <imagem><xsl:value-of select="image_link"/></imagem>
				 <categ><xsl:value-of select="categoria"/></categ>
				 <parcel>ou <xsl:value-of select="numberOfInstallment"/>x <xsl:value-of select="amountPerInstallment"/></parcel>
			</produto>
			</xsl:for-each>
		</centauro>
	</xsl:template>
</xsl:stylesheet>