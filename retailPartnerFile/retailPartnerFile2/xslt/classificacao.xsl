<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" version="1.0" encoding="UTF-8" standalone="yes" cdata-section-elements="codigoModelo categoria subGrupo grupo marca genero faixaEtaria linha" />
  <xsl:template match="/">
    <modelos>
      <xsl:for-each select="ROWSET/ROW">
        <modelo>
          <xsl:attribute name="codigoModelo">
            <xsl:value-of select="CODIGO_MODELO"/>
          </xsl:attribute>
			    <codigoModelo><xsl:value-of select="CODIGO_MODELO" /></codigoModelo>
			    <categoria><xsl:value-of select="CATEGORIA" /></categoria>
			    <subGrupo><xsl:value-of select="SUB_GRUPO" /></subGrupo>
			    <grupo><xsl:value-of select="GRUPO" /></grupo>
			    <marca><xsl:value-of select="MARCA" /></marca>
			    <genero><xsl:value-of select="GENERO" /></genero>
			    <faixaEtaria><xsl:value-of select="FAIXA_ETARIA" /></faixaEtaria>
			    <linha><xsl:value-of select="LINHA" /></linha>
        </modelo>
      </xsl:for-each>
    </modelos>
  </xsl:template>
</xsl:stylesheet>