<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='linkProduto titulo imagem categoria subCategoria detalheProduto'/> 
	<xsl:template match="/">
		<loja>
			<dataCriacao></dataCriacao>
			<moeda>R$</moeda>
			<nomeLoja><![CDATA[lojista]]></nomeLoja>
			<lista>
				<xsl:for-each select="catalogo/produto">
				<produto>
					<codigoProduto><xsl:value-of select="codModelo"/><xsl:value-of select="codCor"/></codigoProduto>
					<linkProduto><xsl:value-of select="linkPDP"/>?utm_source=SproolOfertas&amp;utm_medium=xml&amp;utm_campaign=SproolOfertas-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/>
                    </linkProduto>
					<titulo><xsl:value-of select="descricaoPDP"/></titulo>
					<imagem></imagem>
					<categoria><xsl:value-of select="grupo"/></categoria>
					<subCategoria><xsl:value-of select="categoria"/></subCategoria>
					<detalheProduto><xsl:value-of select="descricaoPDP"/></detalheProduto>
					<preco><xsl:value-of select="precoPromocional"/></preco>
					<precoDesconto>0.00</precoDesconto>                 
					<valorParcela><xsl:value-of select="valorParcela"/></valorParcela>
					<quantidadeParcelas><xsl:value-of select="numeroParcela"/></quantidadeParcelas>
					<estoque>1</estoque>  
				</produto>
				</xsl:for-each>
			</lista>
		</loja>
	</xsl:template>
</xsl:stylesheet>