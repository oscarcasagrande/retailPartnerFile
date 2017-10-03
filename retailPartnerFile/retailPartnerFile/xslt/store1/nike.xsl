<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='NOME  CATEGORIA SUBCATEGORIA URL IMAGEM COR TAMANHO'/>
  <xsl:decimal-format name='real' NaN="Nao é um numero" minus-sign="-" zero-digit="0" decimal-separator="," grouping-separator="." />
  <xsl:template match="/" name="Nike">
		<produtos>
			<xsl:for-each select="catalogo/produto[marca='Nike']">
			<PRODUTO>
				<SKU><xsl:value-of select="sku"/></SKU>
				<NOME><xsl:value-of select="descricaoPDP"/></NOME>				 
				<CATEGORIA><xsl:value-of select="grupo"/></CATEGORIA>
				<SUBCATEGORIA><xsl:value-of select="categoria"/></SUBCATEGORIA>
        <PRECOPOR><xsl:value-of select="format-number(precoPromocional, '###.###,00', 'real')"/></PRECOPOR>
				<N_PARCELAS><xsl:value-of select="numeroParcela"/></N_PARCELAS>
				<V_PARCELAS><xsl:value-of select="format-number(valorParcela, '###.###,00', 'real')"/></V_PARCELAS>
				<URL><xsl:value-of select="linkPDP"/>?utm_source=Nike&amp;utm_medium=xml&amp;utm_campaign=Nike-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/></URL>
				<IMAGEM><xsl:value-of select="linkImagem"/></IMAGEM>
				<TAMANHO><xsl:value-of select="tamanho"/></TAMANHO>
				<COR><xsl:value-of select="cor"/></COR>
        <QUANTIDADE><xsl:value-of select="quantidadeDisponivel"/></QUANTIDADE>
			</PRODUTO>
			</xsl:for-each>
		</produtos>
	</xsl:template>
</xsl:stylesheet>