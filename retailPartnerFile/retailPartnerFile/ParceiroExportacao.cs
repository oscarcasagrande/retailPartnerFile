using System;
using System.Collections.Generic;
using System.Text;

namespace retailPartnerFile
{
    public static partial class Parceiro
    {
        public static class Exportacao
        {
            const string CATALOGXML = "catalog.xml";

            #region ##################################### Metodos Publicos #####################################

            public static bool ExportarXmlParceiroPorLoja(NameValueCollection configuracao, int codigoHistoricoExecucaoProcesso)
            {
                bool resultadoFTP = false;
                bool resultadoSFTP = false;
                List<Loja> lojas = new List<Loja>();

                lojas = MontarLojas(configuracao);

                foreach (Loja loja in lojas)
                {
                    resultadoFTP = ExportarParceiroViaFTP(loja, codigoHistoricoExecucaoProcesso);

                    resultadoSFTP = ExportarParceiroViaSFTP(loja, codigoHistoricoExecucaoProcesso);
                }

                return resultadoFTP == resultadoSFTP == true;
            }

            #endregion

            #region ##################################### Metodos Privados #####################################

            #region ##################################### Exportar FTP #########################################

            private static bool ExportarParceiroViaFTP(Loja loja, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;
                List<ParceiroFtp> parceiros = new List<ParceiroFtp>();

                try
                {
                    parceiros = ObterDadosFtpParceiro(loja.Nome, codigoHistoricoExecucaoProcesso);

                    foreach (ParceiroFtp parceiro in parceiros)
                    {
                        resultado = EnviarXmlPorFtp(loja.Nome, parceiro, codigoHistoricoExecucaoProcesso);
                    }
                }
                catch (Exception ex)
                {
                    try
                    {
                        LogHelper.GravarDetalheErro(Processo.CatalogoParceiroExportacaoFtp, codigoHistoricoExecucaoProcesso, ex, string.Empty);
                    }
                    catch
                    {
                    }
                    try
                    {
                        EmailHelper.EnviarEmail("EquipeErroEaiEcommerce@gruposbf.com.br", "EquipeErroEaiEcommerce@gruposbf.com.br", string.Format("Erro EAI - {0} - Parceiro - Exportacao FTP", System.Environment.MachineName), ex.ToString());
                    }
                    catch
                    {
                    }
                }

                return resultado;
            }

            private static bool EnviarXmlPorFtp(string loja, ParceiroFtp parceiro, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;

                if (ArquivoGeradoSeraExportado(loja, parceiro.CaminhoArquivoOrigem, codigoHistoricoExecucaoProcesso) == true)
                {
                    resultado = EnviarXmlPorFtpParaParceiro(parceiro, codigoHistoricoExecucaoProcesso);
                }

                return resultado;
            }

            private static List<ParceiroFtp> ObterDadosFtpParceiro(string loja, int codigoHistoricoExecucaoProcesso)
            {
                string query = string.Empty;
                List<ParceiroFtp> resultado = new List<ParceiroFtp>();
                ParceiroFtp parceiro;
                DataTable dadosParceiroDataTable = new DataTable();
                Dictionary<string, string> parametros = new Dictionary<string, string>();

                query = @"SELECT
                            PARCEIRO.NOME,
                            PARCEIROFTP.IDPARCEIRO,
                            PARCEIROFTP.HOST,
                            PARCEIROFTP.USUARIO,
                            PARCEIROFTP.SENHA,
                            PARCEIROFTP.CAMINHOARQUIVOORIGEM,
                            PARCEIROFTP.PASTADESTINO
                          FROM
                            CATALOGO_PARCEIRO.PARCEIRO PARCEIRO
                          INNER JOIN 
                            CATALOGO_PARCEIRO.PARCEIROFTP PARCEIROFTP ON PARCEIRO.IDPARCEIRO = PARCEIROFTP.IDPARCEIRO
                          WHERE
                            PARCEIRO.ATIVO = 'S'
                         AND
                            PARCEIROFTP.LOJA = :LOJA";
                parametros.Add("@LOJA", loja);

                try
                {
                    dadosParceiroDataTable = OracleDatabaseHelper.ExecutarDataTable(query, parametros);

                    foreach (DataRow linha in dadosParceiroDataTable.AsEnumerable())
                    {
                        parceiro = new ParceiroFtp();

                        parceiro.Host = linha["HOST"].ToString();
                        parceiro.Usuario = linha["USUARIO"].ToString();
                        parceiro.Senha = linha["SENHA"].ToString();
                        parceiro.CaminhoArquivoOrigem = linha["CAMINHOARQUIVOORIGEM"].ToString();
                        parceiro.PastaDestino = linha["PASTADESTINO"].ToString();
                        parceiro.Nome = linha["NOME"].ToString();
                        parceiro.Codigo = linha["IDPARCEIRO"].ToString();

                        resultado.Add(parceiro);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(string.Format("Ocorreu um erro na tentativa de obter os dados de FTP da loja {0}. Detalhes {1}. Código de execução {1} \n", loja, ex.ToString(), codigoHistoricoExecucaoProcesso));
                }

                return resultado;
            }

            private static bool EnviarXmlPorFtpParaParceiro(ParceiroFtp parceiro, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;
                string caminho = string.Empty;
                FTPHandler ftp = null;

                caminho = Path.Combine(parceiro.CaminhoArquivoOrigem, CATALOGXML);

                try
                {
                    ftp = new FTPHandler(parceiro.Host, parceiro.Usuario, parceiro.Senha, true);
                    resultado = ftp.Upload(caminho, parceiro.PastaDestino);
                }
                catch (Exception ex)
                {
                    throw new Exception(string.Format("Ocorreu um erro na tentativa de enviar xml do parceiro {0}. Detalhes {1}.Código de execução {2}", parceiro.Nome, ex.ToString(), codigoHistoricoExecucaoProcesso));
                }

                return resultado;
            }

            #endregion

            #region ##################################### Exportar SFTP ########################################

            private static bool ExportarParceiroViaSFTP(Loja loja, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;
                string usuario = string.Empty;
                string senha = string.Empty;
                string host = string.Empty;
                string caminhoDiretorioSFTP = string.Empty;
                string nomeParceiro = string.Empty;
                string[] listaCaminhosXmlsParaExportacao = null;

                usuario = ObterUsuarioExportacao(loja.Nome, codigoHistoricoExecucaoProcesso);
                senha = ObterSenhaExportacao(loja.Nome, codigoHistoricoExecucaoProcesso);
                host = ObterHostExportacao(loja.Nome, codigoHistoricoExecucaoProcesso);
                caminhoDiretorioSFTP = ObterCaminhoArquivoXmlParceiro(loja.Nome, codigoHistoricoExecucaoProcesso);

                try
                {
                    listaCaminhosXmlsParaExportacao = ObterListaDeCaminhosDeArquivosXmlGerados(loja.Nome, codigoHistoricoExecucaoProcesso);

                    if (listaCaminhosXmlsParaExportacao.Length > 0)
                    {
                        using (SftpClient cliente = new SftpClient(host, usuario, senha))
                        {
                            cliente.Connect();
                            cliente.ChangeDirectory(caminhoDiretorioSFTP);

                            foreach (string XmlParceiro in listaCaminhosXmlsParaExportacao)
                            {
                                nomeParceiro = ObterNomeParceiro(XmlParceiro);

                                EnviarXmlPorSftp(loja.Nome, nomeParceiro, cliente, caminhoDiretorioSFTP, codigoHistoricoExecucaoProcesso);
                            }

                            cliente.Disconnect();
                        }
                    }
                }
                catch (Exception ex)
                {
                    try
                    {
                        LogHelper.GravarTerminoOperacaoComErro(codigoHistoricoExecucaoProcesso, ex, DateTime.Now);
                    }
                    catch
                    {
                    }
                    try
                    {
                        EmailHelper.EnviarEmail("EquipeErroEaiEcommerce@gruposbf.com.br", "EquipeErroEaiEcommerce@gruposbf.com.br", string.Format("Erro EAI - {0} - Parceiro - Exportação", System.Environment.MachineName), ex.ToString());
                    }
                    catch
                    {
                    }
                }

                return resultado;
            }

            private static string[] ObterListaDeCaminhosDeArquivosXmlGerados(string loja, int codigoHistoricoExecucaoProcesso)
            {
                string caminhoXmlParaExportacao = string.Empty;
                string[] listaDeDiretoriosDeArquivosXmlGerados = null;
                List<string> resultado = new List<string>();

                try
                {
                    caminhoXmlParaExportacao = ObterCaminhoArquivosExportados(loja, codigoHistoricoExecucaoProcesso);

                    listaDeDiretoriosDeArquivosXmlGerados = Directory.GetDirectories(caminhoXmlParaExportacao);

                    foreach (string diretorioDeArquivoXmlGerado in listaDeDiretoriosDeArquivosXmlGerados)
                    {
                        if (ArquivoGeradoSeraExportado(loja, diretorioDeArquivoXmlGerado, codigoHistoricoExecucaoProcesso) == true)
                        {
                            resultado.Add(diretorioDeArquivoXmlGerado);
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(string.Format("Ocorreu um erro ao obter os caminhos dos arquivos para exportacao via SFTP da loja {0}. Detalhe {1}. Codigo execucao {2} \n", loja, ex.ToString(), codigoHistoricoExecucaoProcesso));
                }

                return resultado.ToArray();
            }

            private static bool ArquivoGeradoSeraExportado(string loja, string diretorioDeArquivoXmlGerado, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;
                string caminhoArquivo = string.Empty;
                string caminhoPastaUltimoArquivoExportado = string.Empty;
                string caminhoUltimoArquivoExportado = string.Empty;
                try
                {
                    caminhoArquivo = Path.Combine(diretorioDeArquivoXmlGerado, CATALOGXML);

                    if (File.Exists(caminhoArquivo))
                    {
                        caminhoPastaUltimoArquivoExportado = Path.Combine(diretorioDeArquivoXmlGerado, "last");

                        caminhoUltimoArquivoExportado = Path.Combine(caminhoPastaUltimoArquivoExportado, CATALOGXML);

                        VerificarDiretorio(caminhoPastaUltimoArquivoExportado);

                        if (File.Exists(caminhoUltimoArquivoExportado))
                        {
                            FileInfo arquivoNaPastaRaiz = new FileInfo(caminhoArquivo);

                            FileInfo ultimoArquivoExportado = new FileInfo(caminhoUltimoArquivoExportado);

                            resultado = arquivoNaPastaRaiz.LastWriteTime > ultimoArquivoExportado.LastWriteTime ? true : false;

                            if (resultado)
                            {
                                CopiarArquivoParaLast(loja, diretorioDeArquivoXmlGerado, caminhoArquivo, Processo.CatalogoParceiroExportacaoFtp, codigoHistoricoExecucaoProcesso);
                            }
                        }
                        else
                        {
                            resultado = true;

                            CopiarArquivoParaLast(loja, diretorioDeArquivoXmlGerado, caminhoArquivo, Processo.CatalogoParceiroExportacaoFtp, codigoHistoricoExecucaoProcesso);
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(string.Format("Ocorreu um erro ao copirar o XMl do parceiro {0} da loja {1} para pasta 'Last' Detalhe {2}. Codigo execucao {3} \n", diretorioDeArquivoXmlGerado, loja, ex.ToString(), codigoHistoricoExecucaoProcesso));
                }

                return resultado;
            }

            private static void EnviarXmlPorSftp(string loja, string nomeParceiro, SftpClient cliente, string caminhoRemoto, int codigoHistoricoExecucaoProcesso)
            {
                string destino = string.Empty;
                string caminhoArquivo = string.Empty;

                caminhoArquivo = Path.Combine(Parceiro.ObterCaminhoArquivosExportados(loja, codigoHistoricoExecucaoProcesso), nomeParceiro, CATALOGXML);

                try
                {
                    using (var arquivo = File.OpenRead(caminhoArquivo))
                    {
                        destino = string.Format("{0}/{1}/{2}", caminhoRemoto, nomeParceiro, CATALOGXML);

                        try
                        {
                            cliente.UploadFile(arquivo, destino);

                            RegistrarTransferenciaDeArquivo(codigoHistoricoExecucaoProcesso, DateTime.Now, Direcao.Exportado, Status.Sucesso, arquivo.Name, destino, nomeParceiro);
                        }
                        catch (Exception ex)
                        {
                            RegistrarTransferenciaDeArquivo(codigoHistoricoExecucaoProcesso, DateTime.Now, Direcao.Exportado, Status.Erro, arquivo.Name, destino, nomeParceiro);

                            LogHelper.GravarDetalheErro(Processo.CatalogoParceiroExportacaoFtp, codigoHistoricoExecucaoProcesso, new Exception(string.Format("Ocorreu um erro ao exportar o XML do {0} da loja {1}. Detalhes {2}. Codigo execucao {3}", nomeParceiro, loja, ex.ToString(), codigoHistoricoExecucaoProcesso)), string.Format("{0} {1}", nomeParceiro, Direcao.Exportado));
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(string.Format("Ocorreu um erro ao criar um arquivo do xml do parceiro {0} da loja {1}. Detalhe {2}. Codigo execucao {3} \n", nomeParceiro, loja, ex.ToString(), codigoHistoricoExecucaoProcesso));
                }
            }

            #endregion

            #endregion

            public static bool ExportarXmlClassificacao(int codigoHistoricoExecucaoProcesso)
            {


                bool resultado = false;

                string queryClassificacaoDeProduto = @"
select distinct
   catalogo.cod_produto_modelo codigo_modelo
   ,nvl(deparafrontcategoria.depara, catalogo.des_categoria) categoria
   ,nvl(deparafrontsubgrupo.depara, catalogo.des_sub_grupo) sub_grupo
   ,nvl(deparafrontgrupo.depara, catalogo.des_sub_grupo) grupo
   ,nvl(deparafrontmarca.depara, catalogo.des_marca) marca
   ,nvl(deparafrontgenero.depara, catalogo.des_sexo) genero
   ,nvl(deparafrontfaixaetaria.depara, catalogo.des_faixa_etaria) faixa_etaria
   ,nvl(deparafrontlinha.depara, catalogo.des_linha) linha
from
   backoffice.catalogo_produtos catalogo
left join  
   (select distinct agrupamento.des_agr, deparafront.cod_categoria, deparafront.categoria_store_front depara from backoffice.agrupamento agrupamento inner join controle_integracao.categoria_store_front deparafront on agrupamento.cod_agr = deparafront.cod_tipo where deparafront.cod_tipo = 1) deparafrontgrupo 
   on deparafrontgrupo.cod_categoria = catalogo.cod_grupo
left join
   (select distinct agrupamento.des_agr, deparafront.cod_categoria, deparafront.categoria_store_front depara from backoffice.agrupamento agrupamento inner join controle_integracao.categoria_store_front deparafront on agrupamento.cod_agr = deparafront.cod_tipo where deparafront.cod_tipo in (2, 99)) deparafrontsubgrupo
   on deparafrontsubgrupo.cod_categoria = catalogo.cod_sub_grupo
left join
   (select distinct agrupamento.des_agr, deparafront.cod_categoria, deparafront.categoria_store_front depara from backoffice.agrupamento agrupamento inner join controle_integracao.categoria_store_front deparafront on agrupamento.cod_agr = deparafront.cod_tipo where deparafront.cod_tipo = 3) deparafrontcategoria 
   on deparafrontcategoria.cod_categoria = catalogo.cod_categoria
left join
   (select distinct agrupamento.des_agr, deparafront.cod_categoria, deparafront.categoria_store_front depara from backoffice.agrupamento agrupamento inner join controle_integracao.categoria_store_front deparafront on agrupamento.cod_agr = deparafront.cod_tipo where deparafront.cod_tipo = 5) deparafrontmarca
   on deparafrontmarca.cod_categoria = catalogo.cod_marca
left join
   (select distinct agrupamento.des_agr, deparafront.cod_categoria, deparafront.categoria_store_front depara from backoffice.agrupamento agrupamento inner join controle_integracao.categoria_store_front deparafront on agrupamento.cod_agr = deparafront.cod_tipo where deparafront.cod_tipo = 8) deparafrontgenero
   on deparafrontgenero.cod_categoria = catalogo.cod_sexo
left join
   (select distinct agrupamento.des_agr, deparafront.cod_categoria, deparafront.categoria_store_front depara from backoffice.agrupamento agrupamento inner join controle_integracao.categoria_store_front deparafront on agrupamento.cod_agr = deparafront.cod_tipo where deparafront.cod_tipo = 9) deparafrontfaixaetaria
   on deparafrontfaixaetaria.cod_categoria = catalogo.cod_faixa_etaria
left join
   (select distinct agrupamento.des_agr, deparafront.cod_categoria, deparafront.categoria_store_front depara from backoffice.agrupamento agrupamento inner join controle_integracao.categoria_store_front deparafront on agrupamento.cod_agr = deparafront.cod_tipo where deparafront.cod_tipo = 11) deparafrontlinha
   on deparafrontlinha.cod_categoria = catalogo.cod_linha";

                string transformador = Parceiro.ObterCaminhoArquivoXslClassificacao(codigoHistoricoExecucaoProcesso);
                string caminhoArquivoXmlClassificacao = Parceiro.ObterCaminhoArquivoXmlClassificacao(codigoHistoricoExecucaoProcesso);

                try
                {
                    TimeSpan tempoGerarArquivoClassificacao = new TimeSpan(Parceiro.ObterTempoParaGerarAruivoClassificacao(codigoHistoricoExecucaoProcesso), 0, 0);
                    FileInfo arquivoClassificacao = null;
                    bool gerarArquivo = false;

                    if (File.Exists(caminhoArquivoXmlClassificacao))
                    {
                        arquivoClassificacao = new FileInfo(caminhoArquivoXmlClassificacao);

                        if (DateTime.Now - arquivoClassificacao.CreationTime > tempoGerarArquivoClassificacao)
                        {
                            File.Delete(caminhoArquivoXmlClassificacao);
                            gerarArquivo = true;
                        }
                    }
                    else
                    {
                        gerarArquivo = true;
                    }

                    if (gerarArquivo)
                    {
                        TextReader arquivoXslClassificacao = File.OpenText(transformador);
                        string templateXslClassificacao = arquivoXslClassificacao.ReadToEnd();
                        XmlDocument xmlClassificacao = new XmlDocument();

                        xmlClassificacao = GrupoSBF.Ecommerce.EAI.Infrastructure.OracleDatabaseHelper.ExecutarXmlReader(queryClassificacaoDeProduto, templateXslClassificacao);
                        xmlClassificacao.Save(caminhoArquivoXmlClassificacao);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(string.Format("Ocorreu um erro ao tentar gerar o XML de Classificação de produtos. \n Erro: {0} \n Código Histórico Execução: {1}", ex.ToString(), codigoHistoricoExecucaoProcesso));

                }



                return resultado;
            }
        }
    }
}