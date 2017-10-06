<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='Descricao Categoria SubGrupo LinkSite LinkImagem'/>
  <xsl:template match="/">
    <channel>
      <xsl:for-each select="catalogo/produto">
        <Produto>
          <CodModelo>
            <xsl:value-of select="codModelo"/>
          </CodModelo>
          <CodModeloCor>
            <xsl:value-of select="codModelo"/>
            <xsl:value-of select="codCor"/>
          </CodModeloCor>
          <Descricao>
            <xsl:value-of select="descricaoPDP"/>
          </Descricao>
          <Categoria>
            <xsl:value-of select="grupo"/>
          </Categoria>
          <SubGrupo>
            <xsl:value-of select="categoria"/>
          </SubGrupo>
          <LinkSite>
            <xsl:value-of select="linkPDP"/>?utm_source=Iconna&amp;utm_medium=xml&amp;utm_campaign=Iconna-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/>
          </LinkSite>
          <LinkImagem>
            <xsl:value-of select="linkImagem"/>
          </LinkImagem>
        </Produto>
      </xsl:for-each>
    </channel>
  </xsl:template>
</xsl:stylesheet>