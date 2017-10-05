using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Text;

namespace retailPartnerFile.Dominio
{
    public static partial class Parceiro
    {
        public static class Transformacao
        {
            #region ##################################### Metodos Publicos #####################################

            public static bool TransformarXmlParceiroPorLoja(NameValueCollection configuracao, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;
                List<Loja> lojas = new List<Loja>();

                lojas = MontarLojas(configuracao);

                foreach (Loja loja in lojas)
                {
                    resultado = TransformarXmlParceiro(loja, codigoHistoricoExecucaoProcesso);
                }

                return resultado;
            }

            #endregion

            #region ##################################### Metodos Privados #####################################

            private static bool TransformarXmlParceiro(Loja loja, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;
                bool gerarXmlParceiro = true;
                string nomeParceiro = string.Empty;
                string caminhoPastaParceiro = string.Empty;
                string caminhoArquivoParceiro = string.Empty;
                string[] listaCaminhoDeXsltDeParceiros = null;

                try
                {
                    listaCaminhoDeXsltDeParceiros = ObterListaDeXsltDeParceiros(loja.Nome, codigoHistoricoExecucaoProcesso);

                    foreach (string caminhoXslDeParceiro in listaCaminhoDeXsltDeParceiros)
                    {
                        gerarXmlParceiro = true;
                        nomeParceiro = ObterNomeParceiro(caminhoXslDeParceiro);
                        caminhoPastaParceiro = MontarCaminhoDiretorioParceiro(loja.Nome, nomeParceiro, codigoHistoricoExecucaoProcesso);
                        caminhoArquivoParceiro = MontarCaminhoArquivoParceiro(caminhoPastaParceiro);

                        VerificarDiretorio(caminhoPastaParceiro);

                        if (File.Exists(caminhoArquivoParceiro))
                        {
                            FileInfo fileInfoXmlBase = ObterArquivoXmlBaseLocal(loja.Nome, codigoHistoricoExecucaoProcesso);
                            FileInfo fileInfoXmlParceiro = new FileInfo(caminhoArquivoParceiro);

                            gerarXmlParceiro = fileInfoXmlBase.LastWriteTime > fileInfoXmlParceiro.LastWriteTime ? true : false;
                        }

                        if (gerarXmlParceiro == true)
                        {
                            resultado = GerarXmlBaseParaFormatoParceiroLocal(nomeParceiro, caminhoXslDeParceiro, caminhoArquivoParceiro, loja.Nome, codigoHistoricoExecucaoProcesso);
                        }
                    }
                }
                catch (Exception ex)
                {
                    try
                    {
                        LogHelper.WriteEventLog(string.Format("[CATÁLOGO PARCEIRO]: Execução ID {0} com erro: {1}", codigoHistoricoExecucaoProcesso, ex.ToString()), 600, EventLogEntryType.Error, "EAI Catálogo Parceiro (Transformação)");
                    }
                    catch
                    {
                    }

                    try
                    {
                        EmailHelper.EnviarEmail("EquipeErroEaiEcommerce@gruposbf.com.br", "EquipeErroEaiEcommerce@gruposbf.com.br", string.Format("Erro EAI - {0} - Parceiro - Transformação", System.Environment.MachineName), ex.ToString());
                    }
                    catch
                    {
                    }
                }

                return resultado;
            }

            private static bool GerarXmlBaseParaFormatoParceiroLocal(string nomeParceiro, string caminhoXsltParceiro, string caminhoXmlParceiro, string loja, int codigoHistoricoExecucaoProcesso)
            {
                bool statusXml = false;
                XslCompiledTransform xsltParceiro = null;
                FileInfo xmlParceiro = null;
                FileInfo xmlBase = null;
                XmlWriterSettings configuracoesXML = null;
                XmlReader reader = null;
                XmlWriter writer = null;

                if (caminhoXsltParceiro == "")
                {
                    throw new Exception(string.Format("O caminho do aquivo XSL do parceiro {0}, deve ser específicado. Codigo histórico execucao processo: {1} ", nomeParceiro, codigoHistoricoExecucaoProcesso));
                }
                else
                {
                    try
                    {
                        Parceiro.MoverArquivosParaOlds(Domain.Parceiro.ObterCaminhoArquivosExportados(loja, codigoHistoricoExecucaoProcesso), nomeParceiro, Processo.CatalogoParceiroTransformacao, codigoHistoricoExecucaoProcesso);

                        xsltParceiro = new XslCompiledTransform();
                        xmlParceiro = new FileInfo(caminhoXmlParceiro);
                        xmlBase = ObterArquivoXmlBaseLocal(loja, codigoHistoricoExecucaoProcesso);

                        configuracoesXML = new XmlWriterSettings();
                        configuracoesXML.Encoding = Encoding.UTF8;

                        xsltParceiro.Load(caminhoXsltParceiro, new XsltSettings(true, false), new XmlUrlResolver());

                        writer = XmlWriter.Create(xmlParceiro.FullName, xsltParceiro.OutputSettings);

                        reader = XmlReader.Create(xmlBase.FullName);

                        xsltParceiro.Transform(reader, writer);

                        statusXml = xmlParceiro.LastWriteTime > xmlBase.LastWriteTime ? true : false;
                    }
                    catch (Exception ex)
                    {
                        LogHelper.GravarDetalheErro(Processo.CatalogoParceiroTransformacao, codigoHistoricoExecucaoProcesso, ex, string.Empty);
                    }
                    finally
                    {
                        writer.Flush();
                        writer.Close();
                        reader.Close();
                    }
                }

                if (statusXml == true)
                {
                    try
                    {
                        Infrastructure.CompressHelper.Comprimir(xmlParceiro);
                    }
                    catch (Exception ex)
                    {
                        LogHelper.GravarDetalheErro(Processo.CatalogoParceiroTransformacao, codigoHistoricoExecucaoProcesso, ex, string.Empty);
                    }
                }

                return statusXml;
            }

            private static string[] ObterListaDeXsltDeParceiros(string loja, int codigoHistoricoExecucaoProcesso)
            {
                string[] resultado = null;

                resultado = Directory.GetFiles(ObterCaminhoXsltdeParceiros(loja, codigoHistoricoExecucaoProcesso));

                return resultado;
            }

            #region ##################################### Funcoes Auxiliares ###################################

            private static string MontarCaminhoDiretorioParceiro(string loja, string nomeParceiro, int codigoHistoricoExecucaoProcesso)
            {
                string resultado = string.Empty;
                string caminhoArquivosExportados = string.Empty;

                caminhoArquivosExportados = ObterCaminhoArquivosExportados(loja, codigoHistoricoExecucaoProcesso);
                resultado = Path.Combine(caminhoArquivosExportados, nomeParceiro);

                return resultado;
            }

            private static string MontarCaminhoArquivoParceiro(string caminhoPastaParceiro)
            {
                string resultado = string.Empty;

                resultado = Path.Combine(caminhoPastaParceiro, "catalog.xml");

                return resultado;
            }

            #endregion

            #endregion
        }
    }
}
