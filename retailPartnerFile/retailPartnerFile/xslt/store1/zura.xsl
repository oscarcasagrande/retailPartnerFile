<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='product_name link imgurl category category_id'/> 
	<xsl:template match="/">
		<lojista>
			<xsl:for-each select="catalogo/produto">
			<product>
				<original_id><xsl:value-of select="codModelo"/><xsl:value-of select="codCor"/></original_id>
				<product_name><xsl:value-of select="descricaoPDP"/></product_name>
				<originalvalue><xsl:value-of select="precoBase"/></originalvalue>
				<finalvalue><xsl:value-of select="precoPromocional"/></finalvalue>
				<link><xsl:value-of select="linkPDP"/>?utm_source=Zura&amp;utm_medium=xml&amp;utm_campaign=Zura-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/>
                </link>
				<imgurl><xsl:value-of select="linkImagem"/></imgurl>
				<category><xsl:value-of select="grupo"/></category>
				<category_id><xsl:value-of select="grupo"/></category_id>
				<description><xsl:value-of select="descricaoPDP"/></description>
				<parts><xsl:value-of select="numeroParcela"/></parts>
				<partValue><xsl:value-of select="valorParcela"/></partValue>
			</product>
			</xsl:for-each>
		</lojista>
	</xsl:template>
</xsl:stylesheet>