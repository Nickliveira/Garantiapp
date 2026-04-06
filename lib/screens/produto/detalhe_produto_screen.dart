// RF005 — Tela Detalhe do Produto
// Responsável: Nicolas Oliveira - RA: 838094

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../models/produto.dart';
import '../../providers/produto_provider.dart';
import '../../utils/app_routes.dart';

class DetalheProdutoScreen extends StatelessWidget {
  const DetalheProdutoScreen({super.key});

  Color _corStatus(StatusGarantia status) {
    return switch (status) {
      StatusGarantia.ok => Colors.green,
      StatusGarantia.urgente => Colors.orange,
      StatusGarantia.vencido => Colors.red,
    };
  }

  String _labelStatus(Produto p) {
    if (p.diasRestantes < 0) return 'Garantia vencida há ${p.diasRestantes.abs()} dias';
    if (p.diasRestantes == 0) return 'Garantia vence hoje!';
    return '${p.diasRestantes} dias de garantia restantes';
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final produto = context.read<ProdutoProvider>().buscarPorId(id);
    final fmt = DateFormat('dd/MM/yyyy');

    if (produto == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Produto')),
        body: const Center(child: Text('Produto não encontrado.')),
      );
    }

    final cor = _corStatus(produto.status);

    return Scaffold(
      appBar: AppBar(
        title: Text(produto.nome),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Editar',
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.editarProduto,
              arguments: produto.id,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            tooltip: 'Excluir',
            onPressed: () => _confirmarExclusao(context, produto),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status de garantia em destaque
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cor.withOpacity(0.1),
                border: Border.all(color: cor.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    produto.status == StatusGarantia.ok
                        ? Icons.check_circle_outline
                        : Icons.warning_amber_outlined,
                    color: cor,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _labelStatus(produto),
                      style: TextStyle(color: cor, fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Dados do produto
            _infoRow('Categoria', produto.categoria),
            _infoRow('Data de compra', fmt.format(produto.dataCompra)),
            _infoRow('Vencimento da garantia', fmt.format(produto.dataVencimentoGarantia)),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 12),

            // Foto NF
            const Text('Nota Fiscal', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            const SizedBox(height: 8),
            produto.fotoNfPath != null
                ? const Text('NF disponível') // placeholder para imagem real
                : Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long_outlined, size: 36, color: Colors.grey),
                        SizedBox(height: 6),
                        Text('Nenhuma foto adicionada', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          ),
          Expanded(
            child: Text(valor, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  // RF005 + RF006 — Exclusão com AlertDialog de confirmação
  void _confirmarExclusao(BuildContext context, Produto produto) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir produto'),
        content: Text('Deseja excluir "${produto.nome}"? Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              context.read<ProdutoProvider>().remover(produto.id);
              Navigator.pop(context); // fecha dialog
              Navigator.pop(context); // volta para Home
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Produto excluído.')),
              );
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
