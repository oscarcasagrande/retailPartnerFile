using Microsoft.Win32;
using retailPartnerFile.Helper;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;

namespace retailPartnerFile.Dominio
{
    public static partial class Parceiro
    {

        const string CAMINHOREGISTRO = @"SOFTWARE\Grupo\Ecommerce\EAI\Modulos\Parceiro";

        #region ##################################### Estruturas ###########################################

        internal struct Loja
        {
            public string Nome { get; set; }
            public string Plataforma { get; set; }
        }

        #endregion

        #region ##################################### Metodos Internos #####################################

        internal static List<Loja> MontarLojas(NameValueCollection configuracao)
        {
            List<Loja> lojas = new List<Loja>();

            foreach (string itemSection in configuracao.AllKeys)
            {
                Loja loja = new Loja() { Nome = itemSection, Plataforma = configuracao.Get(itemSection.ToString()) };

                lojas.Add(loja);
            }

            return lojas;
        }

        internal static bool ExisteXmlBase(string loja, int codigoHistoricoExecucaoProcesso)
        {
            bool resultado = false;

            resultado = Directory.GetFiles(ObterCaminhoArquivosImportados(loja, codigoHistoricoExecucaoProcesso), "*.xml", SearchOption.TopDirectoryOnly).Count() > 0 ? true : false;

            return resultado;
        }

        internal static bool ExisteXmlImagem(string loja, int codigoHistoricoExecucaoProcesso)
        {
            bool resultado = false;

            resultado = Directory.GetFiles(ObterCaminhoArquivosImportadosImagem(loja, codigoHistoricoExecucaoProcesso), "*.xml", SearchOption.TopDirectoryOnly).Count() > 0 ? true : false;

            return resultado;
        }

        #region ##################################### Obter Dados Registro #################################

        internal static string ObterCaminhoArquivoXmlClassificacao(int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChave = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChave = MontarChaveRegistro("caminhoArquivoXmlClassificacao", string.Empty);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChave).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChave, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterCaminhoArquivoXslClassificacao(int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChave = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChave = MontarChaveRegistro("caminhoArquicoXslClassificacao", string.Empty);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChave).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChave, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static int ObterTempoParaGerarAruivoClassificacao(int codigoHistoricoExecucaoProcesso)
        {
            int resultado = 24;
            string valorChave = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChave = MontarChaveRegistro("tempoGerarArquivoClassificacaoHoras", string.Empty);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = Convert.ToInt32(registroDeConfiguracao.GetValue(valorChave).ToString());
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChave, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterCaminhoArquivosImportados(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChave = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChave = MontarChaveRegistro("caminhoArquivosImportados", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChave).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChave, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterCaminhoArquivosExportados(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChave = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChave = MontarChaveRegistro("caminhoArquivosExportados", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChave).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChave, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterCaminhoArquivoXmlBase(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChave = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChave = MontarChaveRegistro("caminhoArquivoXmlBase", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChave).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChave, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterCaminhoXsltdeParceiros(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChave = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChave = MontarChaveRegistro("caminhoXsltDeParceiros", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChave).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChave, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterCaminhoArquivoXmlParceiro(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChave = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChave = MontarChaveRegistro("destinoXmlParceiro", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChave).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChave, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterHostExportacao(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChaveHost = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChaveHost = MontarChaveRegistro("hostExportacao", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChaveHost).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChaveHost, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterHostImportacao(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChaveHost = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChaveHost = MontarChaveRegistro("hostImportacao", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChaveHost).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChaveHost, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterUsuarioImportacao(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChaveUsuario = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChaveUsuario = MontarChaveRegistro("usuarioImportacao", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChaveUsuario).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChaveUsuario, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterUsuarioExportacao(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChaveUsuario = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChaveUsuario = MontarChaveRegistro("usuarioExportacao", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChaveUsuario).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChaveUsuario, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterSenhaImportacao(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChaveSenha = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChaveSenha = MontarChaveRegistro("senhaImportacao", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChaveSenha).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChaveSenha, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterSenhaExportacao(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChaveSenha = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChaveSenha = MontarChaveRegistro("senhaExportacao", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChaveSenha).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChaveSenha, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        #endregion

        internal static FileInfo ObterArquivoXmlBaseLocal(string loja, int codigoHistoricoExecucaoProcesso)
        {
            FileInfo resultado = null;

            FileInfo[] arquivos = new DirectoryInfo(ObterCaminhoArquivosImportados(loja, codigoHistoricoExecucaoProcesso)).GetFiles("*.xml", SearchOption.TopDirectoryOnly);

            if (arquivos.Count() > 0)
            {
                resultado = arquivos.OrderByDescending(arquivo => arquivo.LastWriteTime).FirstOrDefault();
            }

            return resultado;
        }

        internal static void MoverArquivosParaOlds(string caminho, string subpasta, Processo processo, int codigoHistoricoExecucaoProcesso)
        {
            try
            {
                string caminhoOrigem = string.Empty;
                string caminhoDestino = string.Empty;
                string nomeArquivo = string.Empty;
                string destino = string.Empty;
                string[] arquivos = null;

                caminhoOrigem = Path.Combine(caminho, subpasta);
                arquivos = Directory.GetFiles(caminhoOrigem, "*.xml", SearchOption.TopDirectoryOnly);
                caminhoDestino = Path.Combine(caminhoOrigem, "olds");

                VerificarDiretorio(caminhoDestino);

                foreach (string arquivo in arquivos)
                {
                    nomeArquivo = string.Format("{0}{1}{2}{3}{4}{5}.xml", DateTime.Now.Year, DateTime.Now.Month.ToString().PadLeft(2, '0'), DateTime.Now.Day.ToString().PadLeft(2, '0'), DateTime.Now.Hour.ToString().PadLeft(2, '0'), DateTime.Now.Minute.ToString().PadLeft(2, '0'), DateTime.Now.Second.ToString().PadLeft(2, '0'));
                    destino = string.Format("{0}/{1}", caminhoDestino, nomeArquivo);

                    try
                    {
                        File.Move(arquivo, destino);
                        var listaDeArquivos = CompressHelper.ObterListaDeArquivos(caminhoDestino, "*.xml", DateTime.Now.AddDays(-1), null);
                        CompressHelper.Comprimir(listaDeArquivos);
                        ExpurgoHelper.ExpurgarArquivos(caminhoDestino, "*.xml", DateTime.Now.AddDays(-1), null);
                        RegistrarTransferenciaDeArquivo(codigoHistoricoExecucaoProcesso, DateTime.Now, Direcao.Movido, Status.Sucesso, arquivo, destino, subpasta);
                    }
                    catch (Exception ex)
                    {
                        RegistrarTransferenciaDeArquivo(codigoHistoricoExecucaoProcesso, DateTime.Now, Direcao.Movido, Status.Erro, arquivo, destino, subpasta);

                        LogHelper.GravarDetalheErro(processo, codigoHistoricoExecucaoProcesso, ex, string.Format("{0} {1}", subpasta, Direcao.Movido));

                        throw new Exception(string.Format("Ocorreu um erro ao mover o arquivo {0} para pasta 'olds'. Detalhes {1}. Codigo execucao {2} \n", arquivo, ex.ToString(), codigoHistoricoExecucaoProcesso));
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Ocorreu um erro ao preprarar os arquivos para serem movidos para pasta 'olds'. Detalhes {0}. Codigo execucao {1} \n", ex.ToString(), codigoHistoricoExecucaoProcesso));
            }
        }

        internal static void CopiarArquivoParaLast(string loja, string nomeParceiro, string caminhoOrigem, Processo processo, int codigoHistoricoExecucaoProcesso)
        {
            string caminhoDestino = string.Empty;
            string caminhoArquivosExportados = string.Empty;
            FileInfo infoArquivo = null;

            caminhoArquivosExportados = ObterCaminhoArquivosExportados(loja, codigoHistoricoExecucaoProcesso);
            caminhoDestino = Path.Combine(caminhoArquivosExportados, nomeParceiro, "last");
            infoArquivo = new FileInfo(caminhoOrigem);

            VerificarDiretorio(caminhoDestino);

            try
            {
                File.Copy(caminhoOrigem, Path.Combine(caminhoDestino, "catalog.xml"), true);

                RegistrarTransferenciaDeArquivo(codigoHistoricoExecucaoProcesso, DateTime.Now, Direcao.Movido, Status.Sucesso, caminhoOrigem, caminhoDestino, nomeParceiro);
            }
            catch (Exception ex)
            {
                RegistrarTransferenciaDeArquivo(codigoHistoricoExecucaoProcesso, DateTime.Now, Direcao.Movido, Status.Erro, caminhoOrigem, caminhoDestino, nomeParceiro);

                throw new Exception(string.Format("Ocorreu um erro ao mover o XML do parceiro {0} da loja {1} para pasta 'Last'. Detalhe {2}. Codigo execucao {3} \n", nomeParceiro, loja, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

        }

        internal static bool RegistrarTransferenciaDeArquivo(int codigoHistoricoExecucaoProcesso, DateTime dataHoraTransferencia, Direcao direcao, Status status, string caminhoOrigem, string caminhoDestino, string parceiro)
        {
            bool resultado = false;

            string query = "INSERT INTO CONTROLE_INTEGRACAO.PARCEIRO_TRANSFERENCIA_ARQUIVO (CODIGO_HISTORICO_EXECUCAO, ID_PROTOCOLO, DATA_HORA, DIRECAO, STATUS, CAMINHO_ORIGEM, CAMINHO_DESTINO, PARCEIRO) VALUES (:CODIGO_HISTORICO_EXECUCAO, :ID_PROTOCOLO, to_date(:DATA_HORA, 'dd-mm-yyyy HH24:MI:SS'), :DIRECAO, :STATUS, :CAMINHO_ORIGEM, :CAMINHO_DESTINO, :PARCEIRO)";

            int IdProtocolo = ObterNumeroProtocolo(codigoHistoricoExecucaoProcesso);

            Dictionary<string, string> parametros = new Dictionary<string, string>();

            parametros.Add("CODIGO_HISTORICO_EXECUCAO", codigoHistoricoExecucaoProcesso.ToString());
            parametros.Add("ID_PROTOCOLO ", IdProtocolo.ToString());
            parametros.Add("DATA_HORA", dataHoraTransferencia.ToString());
            parametros.Add("DIRECAO", ((char)direcao.GetHashCode()).ToString());
            parametros.Add("STATUS", ((char)status.GetHashCode()).ToString());
            parametros.Add("CAMINHO_ORIGEM", caminhoOrigem);
            parametros.Add("CAMINHO_DESTINO", caminhoDestino);
            parametros.Add("PARCEIRO", parceiro);

            try
            {
                int execucao = DatabaseHelper.ExecutarNonQuery(query, parametros);
                resultado = execucao > -1 ? true : false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return resultado;
        }

        internal static string ObterCaminhoArquivosImportadosImagem(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChave = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChave = MontarChaveRegistro("caminhoArquivosImportadosImagem", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChave).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChave, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterCaminhoArquivoXmlImagem(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChave = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChave = MontarChaveRegistro("caminhoArquivoXmlImagem", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChave).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChave, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterSenhaImportacaoImagem(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChaveSenha = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChaveSenha = MontarChaveRegistro("senhaImportacaoImagem", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChaveSenha).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChaveSenha, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterHostImportacaoImagem(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChaveHost = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChaveHost = MontarChaveRegistro("hostImportacaoImagem", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChaveHost).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChaveHost, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static string ObterUsuarioImportacaoImagem(string loja, int codigoHistoricoExecucaoProcesso)
        {
            string resultado = string.Empty;
            string valorChaveUsuario = string.Empty;
            RegistryKey registroDeConfiguracao = null;

            valorChaveUsuario = MontarChaveRegistro("usuarioImportacaoImagem", loja);
            registroDeConfiguracao = Registry.LocalMachine.OpenSubKey(CAMINHOREGISTRO);

            try
            {
                resultado = registroDeConfiguracao.GetValue(valorChaveUsuario).ToString();
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Chave {0} não encontrada. Detalhe {1}. Codigo exececao {2} \n", valorChaveUsuario, ex.ToString(), codigoHistoricoExecucaoProcesso));
            }

            return resultado;
        }

        internal static FileInfo ObterArquivoXmlImagemLocal(string loja, int codigoHistoricoExecucaoProcesso)
        {
            FileInfo resultado = null;

            FileInfo[] arquivos = new DirectoryInfo(ObterCaminhoArquivosImportadosImagem(loja, codigoHistoricoExecucaoProcesso)).GetFiles("*.xml", SearchOption.TopDirectoryOnly);

            if (arquivos.Count() > 0)
            {
                resultado = arquivos.OrderByDescending(arquivo => arquivo.LastWriteTime).FirstOrDefault();
            }

            return resultado;
        }

        #endregion

        #region  ##################################### Metodos Privados #####################################

        #region ##################################### Protocolo #############################################

        private static int ObterNumeroProtocolo(int codigoHistoricoExecucaoProcesso)
        {
            int resultado = 0;

            const string query = "SELECT ID_PROTOCOLO FROM CONTROLE_INTEGRACAO.PROTOCOLO WHERE ID_PROCESSO = :ID_PROCESSO";

            Dictionary<string, string> parametros = new Dictionary<string, string>();
            parametros.Add("ID_PROCESSO", Convert.ToString((int)Processo.CatalogoParceiroExportacaoFtp));

            try
            {
                DataTable tabela = DatabaseHelper.ExecutarDataTable(query, parametros);

                if (tabela.Rows.Count == 0)
                {
                    CriarNumeroProtocolo(codigoHistoricoExecucaoProcesso);

                    tabela = DatabaseHelper.ExecutarDataTable(query);
                }

                resultado = Convert.ToInt32(tabela.Rows[0]["ID_PROTOCOLO"]);

                AtualizarNumeroProtocolo(codigoHistoricoExecucaoProcesso);
            }
            catch (Exception ex)
            {
                throw new Exception("[CATALOGO PARCEIRO EXPORTAÇÃO]: Não foi possível obter o número do protocolo. Detalhe do erro: " + ex);
            }

            return resultado;
        }

        private static void AtualizarNumeroProtocolo(int codigoHistoricoExecucaoProcesso)
        {
            const string query = "UPDATE CONTROLE_INTEGRACAO.PROTOCOLO " +
                                    "   SET ID_PROTOCOLO = ID_PROTOCOLO + 1 " +
                                    "   WHERE ID_PROCESSO = :ID_PROCESSO";

            Dictionary<string, string> parametros = new Dictionary<string, string>();
            parametros.Add("ID_PROCESSO", Convert.ToString((int)Processo.CatalogoParceiroExportacaoFtp));

            try
            {
                DatabaseHelper.ExecutarNonQuery(query, parametros);
            }
            catch (Exception ex)
            {
                throw new Exception("[CATALOGO PARCEIRO EXPORTAÇÃO]: Não foi possível atualizar o número do protocolo. Detalhe do erro: " + ex);
            }
        }

        private static void CriarNumeroProtocolo(int codigoHistoricoExecucaoProcesso)
        {
            const string query = "INSERT INTO CONTROLE_INTEGRACAO.PROTOCOLO " +
                                   "   ( ID_PROCESSO, ID_PROTOCOLO,  DATA_ATUALIZACAO) " +
                                   "VALUES " +
                                   "   (:ID_PROCESSO, 1, SYSDATE)";

            Dictionary<string, string> parametros = new Dictionary<string, string>();
            parametros.Add("ID_PROCESSO", Convert.ToString((int)Processo.CatalogoParceiroExportacaoFtp));

            try
            {
                DatabaseHelper.ExecutarNonQuery(query, parametros);
            }
            catch (Exception ex)
            {
                throw new Exception("[CATALOGO PARCEIRO EXPORTAÇÃO]: Não foi possível criar o número do protocolo. Detalhe do erro: " + ex);
            }
        }

        #endregion

        #region ##################################### Funcoes Auxiliares ####################################

        private static string MontarChaveRegistro(string chave, string loja)
        {
            string resultado = string.Empty;

            resultado = string.Format("{0}{1}", chave, loja);

            return resultado;
        }

        private static bool VerificarDiretorio(string caminhoDiretorio)
        {
            bool resultado = false;

            resultado = Directory.Exists(caminhoDiretorio);

            if (resultado == false)
            {
                CriarDiretorio(caminhoDiretorio);

                resultado = true;
            }

            return false;
        }

        private static void CriarDiretorio(string caminhoDiretorio)
        {
            Directory.CreateDirectory(caminhoDiretorio);
        }

        private static string ObterNomeParceiro(string caminho)
        {
            string resultado = string.Empty;

            if (caminho.Contains("."))
            {
                resultado = caminho.Substring(caminho.LastIndexOf(@"\") + 1, caminho.LastIndexOf(".") - caminho.LastIndexOf(@"\") - 1);
            }
            else
            {
                resultado = caminho.Substring(caminho.LastIndexOf(@"\") + 1);
            }

            return resultado;
        }

        #endregion

        #endregion
    }
}
