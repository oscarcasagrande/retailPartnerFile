<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method='xml' indent='yes' version='1.0' encoding='UTF-8' standalone='yes' cdata-section-elements='linkProduto titulo imagem categoria subCategoria detalheProduto'/>
  <xsl:decimal-format name="real" decimal-separator="." />
  <xsl:key name='distinctModeloCor' match='item' use='substring(sku_id, 1, 8)' />
  <xsl:template match="/">
    <loja>
      <dataCriacao></dataCriacao>
      <moeda>R$</moeda>
      <nomeLoja><![CDATA[Centauro]]></nomeLoja>
      <lista>
        <xsl:for-each select="rss/channel/item[generate-id() = generate-id(key('distinctModeloCor', substring(sku_id, 1, 8)))]">
          <xsl:if test="saleprice > 0">
            <produto>
              <codigoProduto><xsl:value-of select="substring(sku_id, 1, 8)" /></codigoProduto>
              <link_prod>http://www.centauro.com.br/promotion2.jsp;$urlparam$811mw2QFyKi2JljHqwxfpel1WOpCWA?page=pdp&amp;productId=<xsl:value-of select="id"/>&amp;utm_source=SproolOfertas&amp;utm_medium=xml&amp;utm_campaign=SproolOfertas-<xsl:value-of select="categoria"/>-<xsl:value-of select="subgroup"/>-<xsl:value-of select="brand"/>-<xsl:value-of select="id"/>-<xsl:value-of select="color_code"/></link_prod>
              <titulo><xsl:value-of select="title"/></titulo>
              <imagem><xsl:value-of select="image_link"/></imagem>
              <categoria><xsl:value-of select="categoria"/></categoria>
              <subCategoria><xsl:value-of select="subgroup"/></subCategoria>
              <detalheProduto><xsl:value-of select="title"/></detalheProduto>
              <xsl:if test="brand_code = '0002' or brand_code = '0005' or brand_code = '0008' or brand_code = '0057' or brand_code = '0072' or brand_code = '0073' or brand_code = '0091' or brand_code = '0113' or brand_code = '0124' or brand_code = '0130' or brand_code = '0158' or brand_code = '0197' or brand_code = '0256' or brand_code = '0309' or brand_code = '0316' or brand_code = '0321' or brand_code = '0328' or brand_code = '0343' or brand_code = '0352' or brand_code = '0363' or brand_code = '0371' or brand_code = '0374' or brand_code = '1053' or brand_code = '1064' or brand_code = '1084' or brand_code = '1160' or brand_code = '1167' or brand_code = '1180' or brand_code = '1184' or brand_code = '1207' or brand_code = '1216' or brand_code = '1228' or brand_code = '1239' or brand_code = '1246' or brand_code = '1247' or brand_code = '1275' or brand_code = '1295' or brand_code = '1318' or brand_code = '1349' or brand_code = '1352' or brand_code = '1357' or brand_code = '1363' or brand_code = '1524' or brand_code = '1695' or brand_code = '1791' or brand_code = '1943' or brand_code = '1948' or brand_code = '1998' or brand_code = '2013' or brand_code = '2092' or brand_code = '2167' or brand_code = '2171' or brand_code = '2239' or categoria_id = '3-0097' or brand_code = '1278'">
                <preco><xsl:value-of select="saleprice"/></preco>
              </xsl:if>
              <xsl:if test="brand_code != '0002' and brand_code != '0005' and brand_code != '0008' and brand_code != '0057' and brand_code != '0072' and brand_code != '0073' and brand_code != '0091' and brand_code != '0113' and brand_code != '0124' and brand_code != '0130' and brand_code != '0158' and brand_code != '0197' and brand_code != '0256' and brand_code != '0309' and brand_code != '0316' and brand_code != '0321' and brand_code != '0328' and brand_code != '0343' and brand_code != '0352' and brand_code != '0363' and brand_code != '0371' and brand_code != '0374' and brand_code != '1053' and brand_code != '1064' and brand_code != '1084' and brand_code != '1160' and brand_code != '1167' and brand_code != '1180' and brand_code != '1184' and brand_code != '1207' and brand_code != '1216' and brand_code != '1228' and brand_code != '1239' and brand_code != '1246' and brand_code != '1247' and brand_code != '1275' and brand_code != '1295' and brand_code != '1318' and brand_code != '1349' and brand_code != '1352' and brand_code != '1357' and brand_code != '1363' and brand_code != '1524' and brand_code != '1695' and brand_code != '1791' and brand_code != '1943' and brand_code != '1948' and brand_code != '1998' and brand_code != '2013' and brand_code != '2092' and brand_code != '2167' and brand_code != '2171' and brand_code != '2239' and categoria_id != '3-0097' and brand_code != '0098'">
                <preco><xsl:value-of select="format-number(saleprice * 0.9, '###.00', 'real')"/></preco>
              </xsl:if>
              <precoDesconto>0.00</precoDesconto>
              <xsl:if test="brand_code != '0002' and brand_code != '0005' and brand_code != '0008' and brand_code != '0057' and brand_code != '0072' and brand_code != '0073' and brand_code != '0091' and brand_code != '0113' and brand_code != '0124' and brand_code != '0130' and brand_code != '0158' and brand_code != '0197' and brand_code != '0256' and brand_code != '0309' and brand_code != '0316' and brand_code != '0321' and brand_code != '0328' and brand_code != '0343' and brand_code != '0352' and brand_code != '0363' and brand_code != '0371' and brand_code != '0374' and brand_code != '1053' and brand_code != '1064' and brand_code != '1084' and brand_code != '1160' and brand_code != '1167' and brand_code != '1180' and brand_code != '1184' and brand_code != '1207' and brand_code != '1216' and brand_code != '1228' and brand_code != '1239' and brand_code != '1246' and brand_code != '1247' and brand_code != '1275' and brand_code != '1295' and brand_code != '1318' and brand_code != '1349' and brand_code != '1352' and brand_code != '1357' and brand_code != '1363' and brand_code != '1524' and brand_code != '1695' and brand_code != '1791' and brand_code != '1943' and brand_code != '1948' and brand_code != '1998' and brand_code != '2013' and brand_code != '2092' and brand_code != '2167' and brand_code != '2171' and brand_code != '2239' and categoria_id != '3-0097' and brand_code != '0098'">
                <xsl:if test="19.9 >= amountPerInstallment * 0.9 and numberOfInstallment > 1">
                  <quantidadeParcelas><xsl:value-of select="numberOfInstallment - 1 "/></quantidadeParcelas>
                  <valorParcela><xsl:value-of select="format-number((saleprice * 0.9) div (numberOfInstallment - 1), '###.00', 'real')"/></valorParcela>
                </xsl:if>
                <xsl:if test="amountPerInstallment * 0.9 > 19.9 or numberOfInstallment = 1" >
                  <quantidadeParcelas><xsl:value-of select="numberOfInstallment"/></quantidadeParcelas>
                  <valorParcela><xsl:value-of select="format-number(amountPerInstallment * 0.9, '###.00', 'real')"/></valorParcela>
                </xsl:if>
              </xsl:if>
              <xsl:if test="brand_code = '0002' or brand_code = '0005' or brand_code = '0008' or brand_code = '0057' or brand_code = '0072' or brand_code = '0073' or brand_code = '0091' or brand_code = '0113' or brand_code = '0124' or brand_code = '0130' or brand_code = '0158' or brand_code = '0197' or brand_code = '0256' or brand_code = '0309' or brand_code = '0316' or brand_code = '0321' or brand_code = '0328' or brand_code = '0343' or brand_code = '0352' or brand_code = '0363' or brand_code = '0371' or brand_code = '0374' or brand_code = '1053' or brand_code = '1064' or brand_code = '1084' or brand_code = '1160' or brand_code = '1167' or brand_code = '1180' or brand_code = '1184' or brand_code = '1207' or brand_code = '1216' or brand_code = '1228' or brand_code = '1239' or brand_code = '1246' or brand_code = '1247' or brand_code = '1275' or brand_code = '1295' or brand_code = '1318' or brand_code = '1349' or brand_code = '1352' or brand_code = '1357' or brand_code = '1363' or brand_code = '1524' or brand_code = '1695' or brand_code = '1791' or brand_code = '1943' or brand_code = '1948' or brand_code = '1998' or brand_code = '2013' or brand_code = '2092' or brand_code = '2167' or brand_code = '2171' or brand_code = '2239' or categoria_id = '3-0097' or brand_code = '1278'">
                <quantidadeParcelas><xsl:value-of select="numberOfInstallment"/></quantidadeParcelas>
                <valorParcela><xsl:value-of select="format-number(amountPerInstallment, '###.00', 'real')"/></valorParcela>
              </xsl:if>
              <estoque><xsl:value-of select="onsale"/></estoque>
            </produto>
          </xsl:if>
        </xsl:for-each>
      </lista>
    </loja>
  </xsl:template>
</xsl:stylesheet>