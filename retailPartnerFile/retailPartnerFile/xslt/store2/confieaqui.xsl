<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='link_produto nome_produto nivel_categoria img_produto'/> 
	<xsl:template match="/">
		<Loja>
			<xsl:for-each select="rss/channel/item">
			<PRODUTO>
				<id_produto><xsl:value-of select="id"/><xsl:value-of select="color_code"/></id_produto>
				<link_produto><xsl:value-of select="link"/>?utm_source=ConfieAqui&amp;utm_medium=xml&amp;utm_campaign=ConfieAqui-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/>
                </link_produto>
				<nome_produto><xsl:value-of select="title"/></nome_produto>
				<preco_produto><xsl:value-of select="listprice"/></preco_produto>
				<preco_promocao><xsl:value-of select="saleprice"/></preco_promocao>
				<parcelamento><xsl:value-of select="numberOfInstallment"/></parcelamento>
				<nivel_categoria><xsl:value-of select="categoria"/></nivel_categoria>
				<img_produto><xsl:value-of select="image_link"/></img_produto>
			</PRODUTO>
			</xsl:for-each>
		</Loja>
	</xsl:template>
</xsl:stylesheet>