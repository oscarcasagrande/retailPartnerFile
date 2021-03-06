﻿<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='NOME CATEGORIA SUBCATEGORIA URL'/>
  <xsl:key name='distinctModeloCor' match='item' use='substring(sku_id, 1, 8)' />
  <xsl:decimal-format name="real" decimal-separator="." />
  <xsl:template match="/" name="Desconto">
    <produtos>
      <xsl:for-each select="rss/channel/item[generate-id() = generate-id(key('distinctModeloCor', substring(sku_id, 1, 8)))]">
        <PRODUTO>
          <SKU>
            <xsl:value-of select="substring(sku_id, 1, 8)" />
          </SKU>
          <xsl:if test="color_code = '00'">
            <NOME>
              <xsl:value-of select="title"/>
            </NOME>
          </xsl:if>
          <xsl:if test="color_code != '00'">
            <NOME>
              <xsl:value-of select="title"/> - <xsl:value-of select="color"/>
            </NOME>
          </xsl:if>
          <CATEGORIA>
            <xsl:value-of select="categoria"/>
          </CATEGORIA>
          <SUBCATEGORIA>
            <xsl:value-of select="subgroup"/>
          </SUBCATEGORIA>
          <PRECO>
            <!--sem desconto-->
            <xsl:if test="brand_code = '2239' or brand_code = '0256' or brand_code = '1349' or brand_code = '1246' or brand_code = '1357' or brand_code = '2013' or brand_code = '1363' or brand_code = '1167' or brand_code = '2171' or brand_code = '2167' or brand_code = '1791' or brand_code = '2092' or brand_code = '1524' or brand_code = '1084' or brand_code = '1239' or brand_code = '0328' or brand_code = '0374' or brand_code = '0197' or brand_code = '1216' or brand_code = '1352' or brand_code = '1695' or brand_code = '0158' or brand_code = '0113' or brand_code = '0321' or brand_code = '1943' or brand_code = '0363' or brand_code = '0352' or brand_code = '0008' or brand_code = '0343' or brand_code = '1275' or brand_code = '1053' or brand_code = '1998' or brand_code = '1180' or brand_code = '1228' or brand_code = '0124' or brand_code = '0309' or brand_code = '1184' or brand_code = '1948' or brand_code = '1295' or brand_code ='0005' or brand_code = '0091'">
              <POR>
                <xsl:value-of select="saleprice"/>
              </POR>
            </xsl:if>
            <!--aplica o desconto-->
            <xsl:if test="brand_code != '2239' and brand_code != '0256' and brand_code != '1349' and brand_code != '1246' and brand_code != '1357' and brand_code != '2013' and brand_code != '1363' and brand_code != '1167' and brand_code != '2171' and brand_code != '2167' and brand_code != '1791' and brand_code != '2092' and brand_code != '1524' and brand_code != '1084' and brand_code != '1239' and brand_code != '0328' and brand_code != '0374' and brand_code != '0197' and brand_code != '1216' and brand_code != '1352' and brand_code != '1695' and brand_code != '0158' and brand_code != '0113' and brand_code != '0321' and brand_code != '1943' and brand_code != '0363' and brand_code != '0352' and brand_code != '0008' and brand_code != '0343' and brand_code != '1275' and brand_code != '1053' and brand_code != '1998' and brand_code != '1180' and brand_code != '1228' and brand_code != '0124' and brand_code != '0309' and brand_code != '1184' and brand_code != '1948' and brand_code != '1295' and brand_code!='0005' and brand_code != '0091'">
              <POR>
                <xsl:value-of select="format-number(saleprice * 0.9, '###.00', 'real')"/>
              </POR>
            </xsl:if>
          </PRECO>
          <PARCELAMENTO>
            <xsl:if test="brand_code != '2239' and brand_code != '0256' and brand_code != '1349' and brand_code != '1246' and brand_code != '1357' and brand_code != '2013' and brand_code != '1363' and brand_code != '1167' and brand_code != '2171' and brand_code != '2167' and brand_code != '1791' and brand_code != '2092' and brand_code != '1524' and brand_code != '1084' and brand_code != '1239' and brand_code != '0328' and brand_code != '0374' and brand_code != '0197' and brand_code != '1216' and brand_code != '1352' and brand_code != '1695' and brand_code != '0158' and brand_code != '0113' and brand_code != '0321' and brand_code != '1943' and brand_code != '0363' and brand_code != '0352' and brand_code != '0008' and brand_code != '0343' and brand_code != '1275' and brand_code != '1053' and brand_code != '1998' and brand_code != '1180' and brand_code != '1228' and brand_code != '0124' and brand_code != '0309' and brand_code != '1184' and brand_code != '1948' and brand_code != '1295' and brand_code!='0005' and brand_code != '0091'">
              <xsl:if test="19.9 >= amountPerInstallment * 0.9 and numberOfInstallment > 1">
                <N_PARCELAS>
                  <xsl:value-of select="numberOfInstallment - 1 "/>
                </N_PARCELAS>
                <V_PARCELAS>
                  <xsl:value-of select="format-number((saleprice * 0.9) div (numberOfInstallment - 1), '###.00', 'real')"/>
                </V_PARCELAS>
              </xsl:if>
              <xsl:if test="amountPerInstallment * 0.9 > 19.9 or numberOfInstallment = 1" >
                <N_PARCELAS>
                  <xsl:value-of select="numberOfInstallment"/>
                </N_PARCELAS>
                <V_PARCELAS>
                  <xsl:value-of select="format-number(amountPerInstallment * 0.9, '###.00', 'real')"/>
                </V_PARCELAS>
              </xsl:if>
            </xsl:if>
            <xsl:if test="brand_code = '2239' or brand_code = '0256' or brand_code = '1349' or brand_code = '1246' or brand_code = '1357' or brand_code = '2013' or brand_code = '1363' or brand_code = '1167' or brand_code = '2171' or brand_code = '2167' or brand_code = '1791' or brand_code = '2092' or brand_code = '1524' or brand_code = '1084' or brand_code = '1239' or brand_code = '0328' or brand_code = '0374' or brand_code = '0197' or brand_code = '1216' or brand_code = '1352' or brand_code = '1695' or brand_code = '0158' or brand_code = '0113' or brand_code = '0321' or brand_code = '1943' or brand_code = '0363' or brand_code = '0352' or brand_code = '0008' or brand_code = '0343' or brand_code = '1275' or brand_code = '1053' or brand_code = '1998' or brand_code = '1180' or brand_code = '1228' or brand_code = '0124' or brand_code = '0309' or brand_code = '1184' or brand_code = '1948' or brand_code = '1295' or brand_code = '0005' or brand_code = '0091'">
              <N_PARCELAS>
                <xsl:value-of select="numberOfInstallment"/>
              </N_PARCELAS>
              <V_PARCELAS>
                <xsl:value-of select="format-number(amountPerInstallment, '###.00', 'real')"/>
              </V_PARCELAS>
            </xsl:if>
          </PARCELAMENTO>
          <FRETE>
            <GRATIS>
              <xsl:value-of select="free_ship"/>
            </GRATIS>
            <CONDICAO></CONDICAO>
          </FRETE>
          <URL>
            http://www.lojista.com.br/promotion2.jsp;$urlparam$811mw2QFyKi2JljHqwxfpct1WOpCWB?page=pdp&amp;productId=<xsl:value-of select="id"/>&amp;utm_source=UolDesconto&amp;utm_medium=cpc&amp;utm_campaign=INST_Institucional
          </URL>
          <IMAGEM>
            <xsl:value-of select="image_link"/>
          </IMAGEM>
          <DISPONIBILIDADE>1</DISPONIBILIDADE>
          <VARIAVEIS>
            <VARIAVEL_A></VARIAVEL_A>
            <VARIAVEL_B>
              <xsl:value-of select="color_code"/>?utm_source=UolDesconto&amp;utm_medium=xml&amp;utm_campaign=UolDesconto-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/>
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