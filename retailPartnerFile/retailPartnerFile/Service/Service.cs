using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;

namespace retailPartnerFile.Service
{
    public static class Service
    {
        public static bool Importar(NameValueCollection configuracao, int codigoHistoricoExecucaoProcesso)
        {
            bool resultado = true;

            resultado = Dominio.Parceiro.Importacao.ImportarXmlBasePorLoja(configuracao, codigoHistoricoExecucaoProcesso);

            resultado = Dominio.Parceiro.Importacao.ImportarXmlImagemPorLoja(configuracao, codigoHistoricoExecucaoProcesso);

            return resultado;
        }

        public static bool Transformar(NameValueCollection configuracao, int codigoHistoricoExecucaoProcesso)
        {
            bool resultado = false;

            resultado = Dominio.Parceiro.Transformacao.TransformarXmlParceiroPorLoja(configuracao, codigoHistoricoExecucaoProcesso);

            return resultado;
        }

        public static bool Exportar(NameValueCollection configuracao, int codigoHistoricoExecucaoProcesso)
        {
            bool resultado = false;

            resultado = Dominio.Parceiro.Exportacao.ExportarXmlParceiroPorLoja(configuracao, codigoHistoricoExecucaoProcesso);

            resultado = Dominio.Parceiro.Exportacao.ExportarXmlClassificacao(codigoHistoricoExecucaoProcesso);

            return resultado;
        }
    }
}
