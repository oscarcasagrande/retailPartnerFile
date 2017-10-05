<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='CategoriaA1 CategoriaA2 CategoriaA3 CategoriaB1 CategoriaB2 CategoriaB3 CategoriaC1 CategoriaC2 CategoriaC3 CategoriaD1 CategoriaD2 CategoriaD3 URL Descricao_Resumida Descricao_Completa'/>
  <xsl:decimal-format name="real" decimal-separator="." />
  <xsl:key name='distinctModeloCor' match='item' use='substring(sku_id, 1, 6)' />
  <xsl:template match="/">
    <ArrayOfProduto xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
      <xsl:for-each select="rss/channel/item[generate-id() = generate-id(key('distinctModeloCor', substring(sku_id, 1, 6)))]">
        <xsl:variable name="id" select="id"/>
          <Produto>
            <Nome_do_Produto><xsl:value-of select="title"/></Nome_do_Produto>
            <Codigo><xsl:value-of select="id"/></Codigo>
            <Marca><xsl:value-of select="brand"/></Marca>
            <CategoriaA1><xsl:value-of select="categoria"/></CategoriaA1>
            <CategoriaA2><xsl:value-of select="groups"/></CategoriaA2>
            <CategoriaA3><xsl:value-of select="gender"/></CategoriaA3>
            <CategoriaB1><xsl:value-of select="age"/></CategoriaB1>
            <CategoriaB2></CategoriaB2>
            <CategoriaB3></CategoriaB3>
            <CategoriaC1></CategoriaC1>
            <CategoriaC2></CategoriaC2>
            <CategoriaC3></CategoriaC3>
            <CategoriaD1></CategoriaD1>
            <CategoriaD2></CategoriaD2>
            <CategoriaD3></CategoriaD3>
            <URL><xsl:value-of select="link"/>?utm_source=sli&amp;utm_medium=xml&amp;utm_campaign=sli-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/></URL>
            <Caracteristicas>
              <Caracteristica>
                <Valor><xsl:value-of select="gender"/></Valor>
                <Nome>Gênero</Nome>
              </Caracteristica>
            </Caracteristicas>
            <Variantes>
              <Cor><xsl:for-each select="../item[id=$id]"><xsl:value-of select="color"/>;<xsl:value-of select="color_code"/>|</xsl:for-each></Cor>
              <Tamanhos><xsl:for-each select="../item[id=$id]"><xsl:value-of select="size"/>;<xsl:value-of select="substring(sku_id, 9, 3)"/>|</xsl:for-each></Tamanhos>
            </Variantes>
            <Fotos_Variantes>
              <xsl:for-each select="../item[id=$id]">
                <Variante>
                  <Cor><xsl:value-of select="color"/></Cor>
                  <URL_Imagem>http://images.centauro.com.br/900x900/<xsl:value-of select="id"/><xsl:value-of select="color_code"/>.jpg </URL_Imagem>
                </Variante>
              </xsl:for-each>
            </Fotos_Variantes>
            <ListaURLImagens>
              <URLImagem><xsl:value-of select="image_link"/></URLImagem>
            </ListaURLImagens>
            <Preco_de>R$ <xsl:value-of select="listprice"/></Preco_de>
            <Preco_por>R$ <xsl:value-of select="saleprice"/></Preco_por>
            <Condicao_de_Pagamento>
              <xsl:value-of select="numberOfInstallment"/>x de R$ <xsl:value-of select="amountPerInstallment"/> sem juros</Condicao_de_Pagamento>
            <Descricao_Resumida><xsl:value-of select="title"/></Descricao_Resumida>
            <Descricao_Completa><xsl:value-of select="description"/></Descricao_Completa>
            <Estoque><xsl:value-of select="quantityAvailable"/></Estoque>
            <Avaliacoes>0</Avaliacoes>
            <Lancamento>false</Lancamento>
            <Oferta>false</Oferta>
            <FreteGratis><xsl:value-of select="free_ship"/></FreteGratis>
          </Produto>      
      </xsl:for-each>
    </ArrayOfProduto>
  </xsl:template>
</xsl:stylesheet>