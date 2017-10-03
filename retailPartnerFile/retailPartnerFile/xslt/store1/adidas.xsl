<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='NOME  CATEGORIA SUBCATEGORIA URL IMAGEM COR TAMANHO DATAATUALIZACAO'/>
    <xsl:template match="/">
        <produtos>
            <xsl:for-each select="catalogo/produto[marca='Adidas']">
                <PRODUTO>
                    <SKU><xsl:value-of select="sku"/></SKU>
                    <NOME><xsl:value-of select="descricaoPDP"/></NOME>
                    <CATEGORIA><xsl:value-of select="grupo"/></CATEGORIA>
                    <SUBCATEGORIA><xsl:value-of select="categoria"/></SUBCATEGORIA>
                    <PRECOPOR><xsl:value-of select="precoPromocional"/></PRECOPOR>
                    <N_PARCELAS><xsl:value-of select="numeroParcela"/></N_PARCELAS>
                    <V_PARCELAS><xsl:value-of select="valorParcela"/></V_PARCELAS>
                    <URL><xsl:value-of select="linkPDP"/>?utm_source=Adidas&amp;utm_medium=xml&amp;utm_campaign=Adidas-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/></URL>
                    <IMAGEM><xsl:value-of select="linkImagem"/></IMAGEM>
                    <TAMANHO><xsl:value-of select="tamanho"/></TAMANHO>
                    <COR><xsl:value-of select="cor"/></COR>
                    <QUANTIDADE><xsl:value-of select="quantidadeDisponivel"/></QUANTIDADE>
                    <DATAATUALIZACAO><![CDATA[22/9/2011 18:23:14]]></DATAATUALIZACAO>
                </PRODUTO>
            </xsl:for-each>
        </produtos>
    </xsl:template>
</xsl:stylesheet>