using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.IO;
using retailPartnerFile.Helper;
using System.Diagnostics;

namespace retailPartnerFile.Dominio
{
    public static partial class Parceiro
    {
        public static class Importacao
        {
            #region ##################################### Metodos Publicos #####################################

            public static bool ImportarXmlBasePorLoja(NameValueCollection configuracao, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;
                List<Loja> lojas = new List<Loja>();

                lojas = MontarLojas(configuracao);

                foreach (Loja loja in lojas)
                {
                    resultado = ImportarXmlBase(loja, codigoHistoricoExecucaoProcesso);
                }

                return resultado;
            }

            #endregion

            #region ##################################### Metodos Privados #####################################

            private static bool BaixarArquivo(string loja, SftpFile arquivo, SftpClient cliente, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;

                try
                {
                    FileStream fileStream = new FileStream(Path.Combine(ObterCaminhoArquivosImportados(loja, codigoHistoricoExecucaoProcesso), arquivo.Name), FileMode.Create, FileAccess.Write);

                    try
                    {
                        cliente.DownloadFile(arquivo.FullName, (Stream)fileStream);

                        resultado = true;

                        RegistrarTransferenciaDeArquivo(codigoHistoricoExecucaoProcesso, DateTime.Now, Direcao.Importado, Status.Sucesso, arquivo.FullName, fileStream.Name, string.Empty);
                    }
                    catch (Exception ex)
                    {
                        RegistrarTransferenciaDeArquivo(codigoHistoricoExecucaoProcesso, DateTime.Now, Direcao.Importado, Status.Erro, arquivo.FullName, fileStream.Name, string.Empty);

                        LogHelper.GravarDetalheErro(Processo.CatalogoParceiroImportacao, codigoHistoricoExecucaoProcesso, ex, string.Format("{0} {1}", string.Empty, Direcao.Importado));
                    }
                    finally
                    {
                        fileStream.Flush();
                        fileStream.Close();
                        fileStream.Dispose();
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(string.Format("Ocorreu um erro ao tentar realizar o download do arquivo {0}. da loja {1}. Detalhe {2}. Codigo execucao {3}", arquivo.Name, loja, ex.ToString(), codigoHistoricoExecucaoProcesso));
                }

                return resultado;
            }

            private static bool BaixarArquivoImagem(string loja, SftpFile arquivo, SftpClient cliente, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;

                try
                {
                    FileStream fileStream = new FileStream(Path.Combine(ObterCaminhoArquivosImportadosImagem(loja, codigoHistoricoExecucaoProcesso), arquivo.Name), FileMode.Create, FileAccess.Write);

                    try
                    {
                        cliente.DownloadFile(arquivo.FullName, (Stream)fileStream);

                        resultado = true;

                        RegistrarTransferenciaDeArquivo(codigoHistoricoExecucaoProcesso, DateTime.Now, Direcao.Importado, Status.Sucesso, arquivo.FullName, fileStream.Name, string.Empty);
                    }
                    catch (Exception ex)
                    {
                        RegistrarTransferenciaDeArquivo(codigoHistoricoExecucaoProcesso, DateTime.Now, Direcao.Importado, Status.Erro, arquivo.FullName, fileStream.Name, string.Empty);

                        LogHelper.GravarDetalheErro(Processo.CatalogoParceiroImportacao, codigoHistoricoExecucaoProcesso, ex, string.Format("{0} {1}", string.Empty, Direcao.Importado));
                    }
                    finally
                    {
                        fileStream.Flush();
                        fileStream.Close();
                        fileStream.Dispose();
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(string.Format("Ocorreu um erro ao tentar realizar o download do arquivo {0}. da loja {1}. Detalhe {2}. Codigo execucao {3}", arquivo.Name, loja, ex.ToString(), codigoHistoricoExecucaoProcesso));
                }

                return resultado;
            }


            private static bool ImportarXmlBase(Loja loja, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;
                string host = string.Empty;
                string usuario = string.Empty;
                string senha = string.Empty;
                string caminhoXmlBaseFtp = string.Empty;
                string caminhoXmlBaseLocal = string.Empty;
                FileInfo arquivoLocal = null;

                try
                {
                    host = ObterHostImportacao(loja.Nome, codigoHistoricoExecucaoProcesso);
                    usuario = ObterUsuarioImportacao(loja.Nome, codigoHistoricoExecucaoProcesso);
                    senha = ObterSenhaImportacao(loja.Nome, codigoHistoricoExecucaoProcesso);
                    caminhoXmlBaseFtp = ObterCaminhoArquivoXmlBase(loja.Nome, codigoHistoricoExecucaoProcesso);
                    caminhoXmlBaseLocal = ObterCaminhoArquivosImportados(loja.Nome, codigoHistoricoExecucaoProcesso);

                    using (SftpClient cliente = new SftpClient(host, usuario, senha))
                    {
                        cliente.Connect();
                        cliente.ChangeDirectory(caminhoXmlBaseFtp);


                        if (ExisteXmlBase(loja.Nome, codigoHistoricoExecucaoProcesso) == true)
                        {
                            arquivoLocal = ObterArquivoXmlBaseLocal(loja.Nome, codigoHistoricoExecucaoProcesso);
                        }

                        foreach (SftpFile arquivoFtp in cliente.ListDirectory(caminhoXmlBaseFtp))
                        {
                            if (arquivoFtp.Name.ToLower().Contains(".xml"))
                            {
                                if (arquivoLocal == null || arquivoFtp.LastWriteTime > arquivoLocal.LastWriteTime)
                                {
                                    MoverArquivosParaOlds(caminhoXmlBaseLocal, string.Empty, Processo.CatalogoParceiroImportacao, codigoHistoricoExecucaoProcesso);

                                    resultado = BaixarArquivo(loja.Nome, arquivoFtp, cliente, codigoHistoricoExecucaoProcesso);
                                }
                            }
                        }

                        cliente.Disconnect();
                    }
                }
                catch (Exception ex)
                {
                    try
                    {
                        LogHelper.WriteEventLog(string.Format("[CATÁLOGO PARCEIRO]: Codigo execucao {0} com erro: {1}", codigoHistoricoExecucaoProcesso, ex.ToString()), 600, EventLogEntryType.Error, "EAI Catálogo Parceiro (Importação)");
                    }
                    catch
                    {
                    }

                    try
                    {
                        EmailHelper.sendEmail("x@teste.com.br", string.Format("Erro EAI - {0} - Parceiro - Importação", System.Environment.MachineName), ex.ToString(), true, new List<KeyValuePair<string, string>>());
                    }
                    catch
                    {
                    }
                }

                return resultado;
            }

            #endregion

            public static bool ImportarXmlImagemPorLoja(NameValueCollection configuracao, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;
                List<Loja> lojas = new List<Loja>();

                lojas = MontarLojas(configuracao);

                foreach (Loja loja in lojas)
                {
                    resultado = ImportarXmlImagem(loja, codigoHistoricoExecucaoProcesso);
                }

                return resultado;
            }

            private static bool ImportarXmlImagem(Loja loja, int codigoHistoricoExecucaoProcesso)
            {
                bool resultado = false;
                string host = string.Empty;
                string usuario = string.Empty;
                string senha = string.Empty;
                string caminhoXmlImagemFtp = string.Empty;
                string caminhoXmlImagemLocal = string.Empty;
                FileInfo arquivoLocal = null;

                try
                {
                    host = ObterHostImportacaoImagem(loja.Nome, codigoHistoricoExecucaoProcesso);
                    usuario = ObterUsuarioImportacaoImagem(loja.Nome, codigoHistoricoExecucaoProcesso);
                    senha = ObterSenhaImportacaoImagem(loja.Nome, codigoHistoricoExecucaoProcesso);
                    caminhoXmlImagemFtp = ObterCaminhoArquivoXmlImagem(loja.Nome, codigoHistoricoExecucaoProcesso);
                    caminhoXmlImagemLocal = ObterCaminhoArquivosImportadosImagem(loja.Nome, codigoHistoricoExecucaoProcesso);

                    using (SftpClient cliente = new SftpClient(host, usuario, senha))
                    {
                        cliente.Connect();
                        cliente.ChangeDirectory(caminhoXmlImagemFtp);


                        if (ExisteXmlImagem(loja.Nome, codigoHistoricoExecucaoProcesso) == true)
                        {
                            arquivoLocal = ObterArquivoXmlImagemLocal(loja.Nome, codigoHistoricoExecucaoProcesso);
                        }

                        foreach (SftpFile arquivoFtp in cliente.ListDirectory(caminhoXmlImagemFtp))
                        {
                            if (arquivoFtp.Name.ToLower().Contains(".xml"))
                            {
                                if (arquivoLocal == null || arquivoFtp.LastWriteTime > arquivoLocal.LastWriteTime)
                                {
                                    MoverArquivosParaOlds(caminhoXmlImagemLocal, string.Empty, Processo.CatalogoParceiroImportacao, codigoHistoricoExecucaoProcesso);

                                    resultado = BaixarArquivoImagem(loja.Nome, arquivoFtp, cliente, codigoHistoricoExecucaoProcesso);
                                }
                            }
                        }

                        cliente.Disconnect();
                    }
                }
                catch (Exception ex)
                {
                    try
                    {
                        LogHelper.WriteEventLog(string.Format("[CATÁLOGO PARCEIRO]: Codigo execucao {0} com erro: {1}", codigoHistoricoExecucaoProcesso, ex.ToString()), 600, EventLogEntryType.Error, "EAI Catálogo Parceiro (Importação)");
                    }
                    catch
                    {
                    }

                    try
                    {
                        EmailHelper.sendEmail("x@teste.com.br", string.Format("Erro EAI - {0} - Parceiro - Importação", System.Environment.MachineName), ex.ToString(), true, new List<KeyValuePair<string, string>>());
                    }
                    catch
                    {
                    }
                }

                return resultado;
            }
        }
    }
}
