// RF007 — Card de produto usado na ListView da Home e na tela de Alertas
// Responsável: Enzo Botoloto - RA: 838500

import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../utils/app_routes.dart';

class ProdutoCard extends StatelessWidget {
  final Produto produto;

  const ProdutoCard({super.key, required this.produto});

  Color _corStatus() {
    return switch (produto.status) {
      StatusGarantia.ok => const Color(0xFF2E7D32),
      StatusGarantia.urgente => const Color(0xFFE65100),
      StatusGarantia.vencido => const Color(0xFFC62828),
    };
  }

  String _textoStatus() {
    if (produto.diasRestantes < 0) {
      return 'Vencida há ${produto.diasRestantes.abs()} dias';
    }
    if (produto.diasRestantes == 0) return 'Vence hoje!';
    return '${produto.diasRestantes} dias restantes';
  }

  @override
  Widget build(BuildContext context) {
    final cor = _corStatus();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: cor.withOpacity(0.4), width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.detalheProduto,
          arguments: produto.id,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 48,
                decoration: BoxDecoration(
                  color: cor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      produto.categoria,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: cor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _textoStatus(),
                      style: TextStyle(
                        color: cor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (produto.fotoNfPath != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Icon(Icons.receipt_long, size: 14, color: Colors.grey[500]),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
