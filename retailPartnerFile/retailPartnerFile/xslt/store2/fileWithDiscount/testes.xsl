﻿<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  extension-element-prefixes="date" >
  <xsl:import href="C:\Users\o.casagrande\Downloads\date\date.xsl" />
  <xsl:template match="/">
    <dataHora><xsl:value-of select="date:date-time()"/></dataHora>  
    <produtos>
			<xsl:for-each select="rss/channel/item[gender_code='0001']">
			<PRODUTO>
				<SKU><xsl:value-of select="id"/><xsl:value-of select="color_code"/></SKU>
				<NOME><xsl:value-of select="title"/></NOME>
				<CATEGORIA><xsl:value-of select="categoria"/></CATEGORIA>
				<SUBCATEGORIA><xsl:value-of select="subgroup"/></SUBCATEGORIA>
				<PRECO>
					<DE><xsl:value-of select="listprice"/></DE>
					<POR><xsl:value-of select="saleprice"/></POR>
				</PRECO>
				<PARCELAMENTO>
					<N_PARCELAS><xsl:value-of select="numberOfInstallment"/></N_PARCELAS>
					<V_PARCELAS><xsl:value-of select="amountPerInstallment"/></V_PARCELAS>
				</PARCELAMENTO>
				<FRETE>
					<GRATIS><xsl:value-of select="free_ship"/></GRATIS>
					<CONDICAO></CONDICAO>
				</FRETE>
				<URL><xsl:value-of select="link"/>?utm_source=Abril&amp;utm_medium=xml&amp;utm_campaign=Abril-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/></URL>
				<IMAGEM><xsl:value-of select="image_link"/></IMAGEM>
			</PRODUTO>
			</xsl:for-each>
		</produtos>
  </xsl:template>
</xsl:stylesheet>