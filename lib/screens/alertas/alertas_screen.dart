// RF005 — Tela de Alertas de Vencimento
// Responsável: Enzo Botoloto - RA: 838500

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/produto.dart';
import '../../providers/produto_provider.dart';
import '../../widgets/produto_card.dart';

class AlertasScreen extends StatelessWidget {
  const AlertasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alertas de vencimento')),
      body: Consumer<ProdutoProvider>(
        builder: (context, provider, _) {
          final vencidos = provider.produtosEmAlerta
              .where((p) => p.status == StatusGarantia.vencido)
              .toList();
          final urgentes = provider.produtosEmAlerta
              .where((p) => p.status == StatusGarantia.urgente)
              .toList();

          if (vencidos.isEmpty && urgentes.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
                  SizedBox(height: 12),
                  Text('Nenhum alerta no momento.', style: TextStyle(color: Colors.grey)),
                  Text('Todas as garantias estão em dia!', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              if (vencidos.isNotEmpty) ...[
                _secaoHeader('Garantias vencidas', Colors.red),
                ...vencidos.map((p) => ProdutoCard(produto: p)),
              ],
              if (urgentes.isNotEmpty) ...[
                _secaoHeader('Vencem em até 30 dias', Colors.orange),
                ...urgentes.map((p) => ProdutoCard(produto: p)),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _secaoHeader(String titulo, Color cor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: cor, size: 18),
          const SizedBox(width: 6),
          Text(
            titulo,
            style: TextStyle(
              color: cor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
