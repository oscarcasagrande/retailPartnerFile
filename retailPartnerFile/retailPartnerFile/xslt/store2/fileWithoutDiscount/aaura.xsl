<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='produto_informacoes'/>
  <xsl:key name='distinctModeloCor' match='item' use='substring(sku_id, 1, 6)' />
  <xsl:template match="/">
    <Aura>
      <versao>1.0</versao>
      <loja_codigo>0005</loja_codigo>
      <loja_nome>Centauro.com.br</loja_nome>
      <data_ultima_atualizacao>aaaa-mm-dd hh:mm:ss</data_ultima_atualizacao>
      <data_ultima_atualizacao_fotos>aaaa-mm-dd hh:mm:ss</data_ultima_atualizacao_fotos>
      <xsl:for-each select="rss/channel/item[generate-id() = generate-id(key('distinctModeloCor', substring(sku_id, 1, 6)))]">
        <xsl:variable name="id" select="id"/>
        <Produto>
          <produto_codigo><xsl:value-of select="id"/></produto_codigo>
          <categoria_pai_codigo>0000</categoria_pai_codigo>
          <categoria_nome><xsl:value-of select="categoria"/></categoria_nome>
          <categoria_codigo><xsl:value-of select="categoria_id"/></categoria_codigo>
          <produto_status>1</produto_status>
          <produto_grupo><xsl:value-of select="subgroup"/></produto_grupo>
          <produto_nome><xsl:value-of select="title"/></produto_nome>
          <produto_codigo_grupo><xsl:value-of select="subgroup_id"/></produto_codigo_grupo>
          <produto_url><xsl:value-of select="link"/>?utm_source=aaura&amp;utm_medium=xml&amp;utm_campaign=aaura-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/></produto_url>
          <xsl:if test="listprice > saleprice">
            <produto_preco><xsl:value-of select="listprice"/></produto_preco>
          </xsl:if>
          <xsl:if test="saleprice >= listprice">
            <produto_preco><xsl:value-of select="saleprice"/></produto_preco>
          </xsl:if>
          <produto_preco_de><xsl:value-of select="saleprice"/></produto_preco_de>
          <produto_parcelas><xsl:value-of select="numberOfInstallment"/></produto_parcelas>
          <produto_dias_postagem>3</produto_dias_postagem>
          <produto_tags></produto_tags>
          <Itens>
          <xsl:for-each select="../item[substring(sku_id, 1, 6)=$id]">
            <item>
              <item_status>1</item_status>
              <item_codigo_unico><xsl:value-of select="sku_id"/></item_codigo_unico>
              <item_atributo1_nome>Tamanho</item_atributo1_nome>
              <item_atributo1_valor><xsl:value-of select="size"/></item_atributo1_valor>
              <item_atributo2_nome>Cor</item_atributo2_nome>
              <item_atributo2_valor><xsl:value-of select="color"/></item_atributo2_valor>
            </item>
          </xsl:for-each>
          </Itens>
          <produto_informacoes><xsl:value-of select="description"/></produto_informacoes>
          <produto_especificacoes></produto_especificacoes>
          <Fotos>
          <xsl:for-each select="../item[id=$id]">
            <foto>http://images.centauro.com.br/900x900/<xsl:value-of select="id"/><xsl:value-of select="color_code"/>.jpg</foto>
          </xsl:for-each>
          </Fotos>
        </Produto>
      </xsl:for-each>
      </Aura>
  </xsl:template>
</xsl:stylesheet>