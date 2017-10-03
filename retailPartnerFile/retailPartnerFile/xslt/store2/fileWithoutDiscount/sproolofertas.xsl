<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='linkProduto titulo imagem categoria subCategoria detalheProduto'/>
  <xsl:key name='distinctModeloCor' match='item' use='substring(sku_id, 1, 8)' />
	<xsl:template match="/">
		<loja>
			<dataCriacao></dataCriacao>
			<moeda>R$</moeda>
			<nomeLoja><![CDATA[Centauro]]></nomeLoja>
			<lista>
        <xsl:for-each select="rss/channel/item[generate-id() = generate-id(key('distinctModeloCor', substring(sku_id, 1, 8)))]">
				<produto>
					<codigoProduto><xsl:value-of select="substring(sku_id, 1, 8)" /></codigoProduto>
					<linkProduto><xsl:value-of select="link"/>?utm_source=SproolOfertas&amp;utm_medium=xml&amp;utm_campaign=SproolOfertas-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/></linkProduto>
					<titulo><xsl:value-of select="title"/></titulo>
					<imagem></imagem>
					<categoria><xsl:value-of select="categoria"/></categoria>
					<subCategoria><xsl:value-of select="subgroup"/></subCategoria>
					<detalheProduto><xsl:value-of select="title"/></detalheProduto>
					<preco><xsl:value-of select="saleprice"/></preco>
					<precoDesconto>0.00</precoDesconto>                 
					<valorParcela><xsl:value-of select="amountPerInstallment"/></valorParcela>
					<quantidadeParcelas><xsl:value-of select="numberOfInstallment"/></quantidadeParcelas>
					<estoque><xsl:value-of select="onsale"/></estoque>  
				</produto>
				</xsl:for-each>
			</lista>
		</loja>
	</xsl:template>
</xsl:stylesheet>