<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='descricao link_prod imagem categ'/> 
	<xsl:template match="/">
		<centauro>
			<xsl:for-each select="catalogo/produto">
				<produto>
				 <descricao><xsl:value-of select="descricaoPDP"/></descricao>
				 <preco><xsl:value-of select="precoPromocional"/></preco>
				 <id_produto><xsl:value-of select="codModelo"/><xsl:value-of select="codCor"/></id_produto>
				 <link_prod><xsl:value-of select="linkPDP"/>?utm_source=JaCotei&amp;utm_medium=xml&amp;utm_campaign=JaCotei-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/>
                 </link_prod>
				 <imagem><xsl:value-of select="linkImagem"/></imagem>
				 <categ><xsl:value-of select="grupo"/></categ>
				 <parcel>ou <xsl:value-of select="numeroParcela"/>x <xsl:value-of select="valorParcela"/></parcel>
			</produto>
			</xsl:for-each>
		</centauro>
	</xsl:template>
</xsl:stylesheet>