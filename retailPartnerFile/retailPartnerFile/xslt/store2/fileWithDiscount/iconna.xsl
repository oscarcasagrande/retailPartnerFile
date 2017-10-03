<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='Descricao Categoria SubGrupo LinkSite LinkImagem'/>
  <xsl:decimal-format name="real" decimal-separator="." />
  <xsl:key name='distinctModeloCor' match='item' use='substring(sku_id, 1, 8)' />
  <xsl:template match="/">
    <channel>
      <xsl:for-each select="rss/channel/item[generate-id() = generate-id(key('distinctModeloCor', substring(sku_id, 1, 8)))]">
        <xsl:if test="saleprice > 0">
          <Produto>
            <CodModelo><xsl:value-of select="id"/></CodModelo>
            <CodModeloCor><xsl:value-of select="substring(sku_id, 1, 8)" /></CodModeloCor>
            <Descricao><xsl:value-of select="title"/></Descricao>
            <Categoria><xsl:value-of select="categoria"/></Categoria>
            <SubGrupo><xsl:value-of select="subgroup"/></SubGrupo>
            <LinkSite>http://www.centauro.com.br/promotion2.jsp;$urlparam$811mw2QFyKi2JljHqwxfpel1WOpCWA?page=pdp&amp;productId=<xsl:value-of select="id"/>&amp;utm_source=Iconna&amp;utm_medium=xml&amp;utm_campaign=Iconna-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/></LinkSite>
            <LinkImagem><xsl:value-of select="image_link"/></LinkImagem>
          </Produto>
        </xsl:if>
      </xsl:for-each>
    </channel>
  </xsl:template>
</xsl:stylesheet>