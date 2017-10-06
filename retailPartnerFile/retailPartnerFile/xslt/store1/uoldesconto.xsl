<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='NOME CATEGORIA SUBCATEGORIA URL'/>
  <xsl:key name='distinctModeloCor' match='catalogo/produto' use='substring(sku, 1, 8)' />
  <xsl:decimal-format name="real" decimal-separator="." />
  <xsl:template match="/" name="Desconto">
    <produtos>
      <xsl:for-each select="catalogo/produto[generate-id() = generate-id(key('distinctModeloCor', substring(sku, 1, 8)))]">
        <PRODUTO>
          <SKU>
            <xsl:value-of select="substring(sku, 1, 8)" />
          </SKU>
          <xsl:if test="codCor = '00'">
            <NOME>
              <xsl:value-of select="descricaoPDP"/>
            </NOME>
          </xsl:if>
          <xsl:if test="codCor != '00'">
            <NOME>
              <xsl:value-of select="descricaoPDP"/> - <xsl:value-of select="cor"/>
            </NOME>
          </xsl:if>
          <CATEGORIA>
            <xsl:value-of select="grupo"/>
          </CATEGORIA>
          <SUBCATEGORIA>
            <xsl:value-of select="categoria"/>
          </SUBCATEGORIA>
          <PRECO>
            <!--sem desconto-->
            <xsl:if test="marca = '2239' or marca = '0256' or marca = '1349' or marca = '1246' or marca = '1357' or marca = '2013' or marca = '1363' or marca = '1167' or marca = '2171' or marca = '2167' or marca = '1791' or marca = '2092' or marca = '1524' or marca = '1084' or marca = '1239' or marca = '0328' or marca = '0374' or marca = '0197' or marca = '1216' or marca = '1352' or marca = '1695' or marca = '0158' or marca = '0113' or marca = '0321' or marca = '1943' or marca = '0363' or marca = '0352' or marca = '0008' or marca = '0343' or marca = '1275' or marca = '1053' or marca = '1998' or marca = '1180' or marca = '1228' or marca = '0124' or marca = '0309' or marca = '1184' or marca = '1948' or marca = '1295' or marca ='0005' or marca = '0091'">
              <POR>
                <xsl:value-of select="precoPromocional"/>
              </POR>
            </xsl:if>
            <!--aplica o desconto-->
            <xsl:if test="marca != '2239' and marca != '0256' and marca != '1349' and marca != '1246' and marca != '1357' and marca != '2013' and marca != '1363' and marca != '1167' and marca != '2171' and marca != '2167' and marca != '1791' and marca != '2092' and marca != '1524' and marca != '1084' and marca != '1239' and marca != '0328' and marca != '0374' and marca != '0197' and marca != '1216' and marca != '1352' and marca != '1695' and marca != '0158' and marca != '0113' and marca != '0321' and marca != '1943' and marca != '0363' and marca != '0352' and marca != '0008' and marca != '0343' and marca != '1275' and marca != '1053' and marca != '1998' and marca != '1180' and marca != '1228' and marca != '0124' and marca != '0309' and marca != '1184' and marca != '1948' and marca != '1295' and marca!='0005' and marca != '0091'">
              <POR>
                <xsl:value-of select="format-number(precoPromocional * 0.9, '###.00', 'real')"/>
              </POR>
            </xsl:if>
          </PRECO>
          <PARCELAMENTO>
            <xsl:if test="marca != '2239' and marca != '0256' and marca != '1349' and marca != '1246' and marca != '1357' and marca != '2013' and marca != '1363' and marca != '1167' and marca != '2171' and marca != '2167' and marca != '1791' and marca != '2092' and marca != '1524' and marca != '1084' and marca != '1239' and marca != '0328' and marca != '0374' and marca != '0197' and marca != '1216' and marca != '1352' and marca != '1695' and marca != '0158' and marca != '0113' and marca != '0321' and marca != '1943' and marca != '0363' and marca != '0352' and marca != '0008' and marca != '0343' and marca != '1275' and marca != '1053' and marca != '1998' and marca != '1180' and marca != '1228' and marca != '0124' and marca != '0309' and marca != '1184' and marca != '1948' and marca != '1295' and marca!='0005' and marca != '0091'">
              <xsl:if test="19.9 >= valorParcela * 0.9 and numeroParcela > 1">
                <N_PARCELAS>
                  <xsl:value-of select="numeroParcela - 1 "/>
                </N_PARCELAS>
                <V_PARCELAS>
                  <xsl:value-of select="format-number((precoPromocional * 0.9) div (numeroParcela - 1), '###.00', 'real')"/>
                </V_PARCELAS>
              </xsl:if>
              <xsl:if test="valorParcela * 0.9 > 19.9 or numeroParcela = 1" >
                <N_PARCELAS>
                  <xsl:value-of select="numeroParcela"/>
                </N_PARCELAS>
                <V_PARCELAS>
                  <xsl:value-of select="format-number(valorParcela * 0.9, '###.00', 'real')"/>
                </V_PARCELAS>
              </xsl:if>
            </xsl:if>
            <xsl:if test="marca = '2239' or marca = '0256' or marca = '1349' or marca = '1246' or marca = '1357' or marca = '2013' or marca = '1363' or marca = '1167' or marca = '2171' or marca = '2167' or marca = '1791' or marca = '2092' or marca = '1524' or marca = '1084' or marca = '1239' or marca = '0328' or marca = '0374' or marca = '0197' or marca = '1216' or marca = '1352' or marca = '1695' or marca = '0158' or marca = '0113' or marca = '0321' or marca = '1943' or marca = '0363' or marca = '0352' or marca = '0008' or marca = '0343' or marca = '1275' or marca = '1053' or marca = '1998' or marca = '1180' or marca = '1228' or marca = '0124' or marca = '0309' or marca = '1184' or marca = '1948' or marca = '1295' or marca = '0005' or marca = '0091'">
              <N_PARCELAS>
                <xsl:value-of select="numeroParcela"/>
              </N_PARCELAS>
              <V_PARCELAS>
                <xsl:value-of select="format-number(valorParcela, '###.00', 'real')"/>
              </V_PARCELAS>
            </xsl:if>
          </PARCELAMENTO>
          <FRETE>
            <GRATIS>
              <xsl:value-of select="isFreteGratis"/>
            </GRATIS>
            <CONDICAO></CONDICAO>
          </FRETE>
          <URL>
            http://www.lojista.com.br/promotion2.jsp;$urlparam$811mw2QFyKi2JljHqwxfpct1WOpCWB?page=pdp&amp;productId=<xsl:value-of select="codModelo"/>&amp;utm_source=UolDesconto&amp;utm_medium=cpc&amp;utm_campaign=INST_Institucional
          </URL>
          <IMAGEM>
            <xsl:value-of select="linkImagem"/>
          </IMAGEM>
          <DISPONIBILIDADE>1</DISPONIBILIDADE>
          <VARIAVEIS>
            <VARIAVEL_A></VARIAVEL_A>
            <VARIAVEL_B>
              <xsl:value-of select="codCor"/>?utm_source=UolDesconto&amp;utm_medium=xml&amp;utm_campaign=UolDesconto-<xsl:value-of select="grupo"/>-<xsl:value-of select="categoria"/>-<xsl:value-of select="marca"/>-<xsl:value-of select="codModelo"/>-<xsl:value-of select="codCor"/>
            </VARIAVEL_B>
            <VARIAVEL_C></VARIAVEL_C>
            <VARIAVEL_D></VARIAVEL_D>
            <VARIAVEL_E></VARIAVEL_E>
          </VARIAVEIS>
        </PRODUTO>
      </xsl:for-each>
    </produtos>
  </xsl:template>
</xsl:stylesheet>