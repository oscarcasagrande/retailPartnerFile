using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace retailPartnerFile.Dominio
{
    public class ParceiroFtp
    {
        public ParceiroFtp() { }

        public string Host { get; set; }
        public string Usuario { get; set; }
        public string Senha { get; set; }
        public string CaminhoArquivoOrigem { get; set; }
        public string PastaDestino { get; set; }
        public string Nome { get; set; }
        public string Codigo { get; set; }
    }
}
