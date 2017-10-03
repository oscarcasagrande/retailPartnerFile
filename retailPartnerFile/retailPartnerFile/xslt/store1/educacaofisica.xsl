<?xml version="1.0" encoding="ISO-8859-1" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='NOME CATEGORIA SUBCATEGORIA URL IMAGEM'/> 
	<xsl:template match="/">
		<produtos>
			<xsl:for-each select="catalogo/produto">
			<PRODUTO>
				<SKU><xsl:value-of select="codModelo"/><xsl:value-of select="codCor"/></SKU>
				<NOME><xsl:value-of select="descricaoPDP"/></NOME>
				<CATEGORIA><xsl:value-of select="grupo"/></CATEGORIA>
				<SUBCATEGORIA><xsl:value-of select="categoria"/></SUBCATEGORIA>
				<PRECOPOR><xsl:value-of select="precoPromocional"/></PRECOPOR>
				<N_PARCELAS><xsl:value-of select="valorParcela"/></N_PARCELAS>
				<V_PARCELAS><xsl:value-of select="numeroParcela"/></V_PARCELAS>
				<URL><xsl:value-of select="linkPDP"/>?utm_source=PortalEducacaoFisica&amp;utm_medium=xml&amp;utm_campaign=PortalEducacaoFisica-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/>
                </URL>
				<IMAGEM><xsl:value-of select="linkImagem"/></IMAGEM>
			</PRODUTO>
			</xsl:for-each>
		</produtos>
	</xsl:template>
</xsl:stylesheet>