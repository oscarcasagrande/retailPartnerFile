using System;
using System.Collections.Generic;
using System.Text;

namespace retailPartnerFile
{
    public static class Execute
    {
        public static bool Importar(NameValueCollection configuracao, int codigoHistoricoExecucaoProcesso)
        {
            bool resultado = true;

            resultado = Domain.Parceiro.Importacao.ImportarXmlBasePorLoja(configuracao, codigoHistoricoExecucaoProcesso);

            resultado = Domain.Parceiro.Importacao.ImportarXmlImagemPorLoja(configuracao, codigoHistoricoExecucaoProcesso);

            return resultado;
        }

        public static bool Transformar(NameValueCollection configuracao, int codigoHistoricoExecucaoProcesso)
        {
            bool resultado = false;

            resultado = Domain.Parceiro.Transformacao.TransformarXmlParceiroPorLoja(configuracao, codigoHistoricoExecucaoProcesso);

            return resultado;
        }

        public static bool Exportar(NameValueCollection configuracao, int codigoHistoricoExecucaoProcesso)
        {
            bool resultado = false;

            resultado = Domain.Parceiro.Exportacao.ExportarXmlParceiroPorLoja(configuracao, codigoHistoricoExecucaoProcesso);

            resultado = Domain.Parceiro.Exportacao.ExportarXmlClassificacao(codigoHistoricoExecucaoProcesso);

            return resultado;
        }
    }
}