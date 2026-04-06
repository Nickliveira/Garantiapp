// RF005, RF007 — Gerenciamento de estado dos produtos
// Responsável: Felipe Fragiorgis - RA: 840337 (criação), todos usam

import 'package:flutter/material.dart';
import '../models/produto.dart';

class ProdutoProvider extends ChangeNotifier {
  // Dados mockados para demonstração (RF007 permite dados estáticos)
  final List<Produto> _produtos = [
    Produto(
      id: '1',
      nome: 'Geladeira Brastemp',
      categoria: 'Eletrodoméstico',
      dataCompra: DateTime(2023, 6, 10),
      dataVencimentoGarantia: DateTime(2025, 6, 10),
      fotoNfPath: null,
    ),
    Produto(
      id: '2',
      nome: 'TV Samsung 55"',
      categoria: 'Eletrônico',
      dataCompra: DateTime(2024, 1, 15),
      dataVencimentoGarantia: DateTime(2025, 4, 5),
      fotoNfPath: null,
    ),
    Produto(
      id: '3',
      nome: 'Notebook Dell',
      categoria: 'Eletrônico',
      dataCompra: DateTime(2022, 11, 20),
      dataVencimentoGarantia: DateTime(2023, 11, 20),
      fotoNfPath: null,
    ),
    Produto(
      id: '4',
      nome: 'Ar-condicionado LG',
      categoria: 'Eletrodoméstico',
      dataCompra: DateTime(2024, 3, 1),
      dataVencimentoGarantia: DateTime(2027, 3, 1),
      fotoNfPath: null,
    ),
  ];

  List<Produto> get produtos => List.unmodifiable(_produtos);

  // RF005 — Alertas: produtos vencidos ou vencendo em até 30 dias
  List<Produto> get produtosEmAlerta {
    return _produtos
        .where((p) => p.status != StatusGarantia.ok)
        .toList()
      ..sort((a, b) => a.diasRestantes.compareTo(b.diasRestantes));
  }

  Produto? buscarPorId(String id) {
    try {
      return _produtos.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  // RF005 — Cadastrar produto
  void adicionar(Produto produto) {
    _produtos.add(produto);
    notifyListeners();
  }

  // RF005 — Editar produto
  void editar(Produto produtoAtualizado) {
    final index = _produtos.indexWhere((p) => p.id == produtoAtualizado.id);
    if (index != -1) {
      _produtos[index] = produtoAtualizado;
      notifyListeners();
    }
  }

  // RF005 — Excluir produto
  void remover(String id) {
    _produtos.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
