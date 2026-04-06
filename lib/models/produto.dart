// RF005 — Modelo de dados do Produto
// Responsável: Felipe Fragiorgis - RA: 840337 (criação), Nicolas Oliveira - RA: 838094 e Enzo Botoloto - RA: 838500 (uso)

class Produto {
  final String id;
  String nome;
  String categoria;
  DateTime dataCompra;
  DateTime dataVencimentoGarantia;
  String? fotoNfPath; // caminho da imagem da NF (mockado por ora)

  Produto({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.dataCompra,
    required this.dataVencimentoGarantia,
    this.fotoNfPath,
  });

  // Quantidade de dias restantes de garantia (negativo = vencido)
  int get diasRestantes {
    return dataVencimentoGarantia.difference(DateTime.now()).inDays;
  }

  // Status semântico para colorir os cards (RF007)
  StatusGarantia get status {
    if (diasRestantes < 0) return StatusGarantia.vencido;
    if (diasRestantes <= 30) return StatusGarantia.urgente;
    return StatusGarantia.ok;
  }
}

enum StatusGarantia { ok, urgente, vencido }
