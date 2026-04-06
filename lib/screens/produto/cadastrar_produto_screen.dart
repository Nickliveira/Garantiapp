// RF005 — Tela Cadastrar Produto
// Responsável: Nicolas Oliveira - RA: 838094

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../models/produto.dart';
import '../../providers/produto_provider.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_text_field.dart';

class CadastrarProdutoScreen extends StatefulWidget {
  const CadastrarProdutoScreen({super.key});

  @override
  State<CadastrarProdutoScreen> createState() => _CadastrarProdutoScreenState();
}

class _CadastrarProdutoScreenState extends State<CadastrarProdutoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  String _categoriaSelecionada = 'Eletrônico';
  DateTime _dataCompra = DateTime.now();
  DateTime _dataVencimento = DateTime.now().add(const Duration(days: 365));

  final List<String> _categorias = [
    'Eletrônico', 'Eletrodoméstico', 'Móvel', 'Veículo', 'Ferramenta', 'Outro',
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  Future<void> _selecionarData({required bool isCompra}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isCompra ? _dataCompra : _dataVencimento,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isCompra) {
          _dataCompra = picked;
        } else {
          _dataVencimento = picked;
        }
      });
    }
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    if (_dataVencimento.isBefore(_dataCompra)) {
      // RF006 — SnackBar de erro de data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A data de vencimento deve ser após a data de compra.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final produto = Produto(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: _nomeController.text.trim(),
      categoria: _categoriaSelecionada,
      dataCompra: _dataCompra,
      dataVencimentoGarantia: _dataVencimento,
    );

    context.read<ProdutoProvider>().adicionar(produto);

    // RF006 — SnackBar de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produto cadastrado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar produto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _nomeController,
                label: 'Nome do produto',
                validator: (v) => Validators.obrigatorio(v, campo: 'O nome'),
              ),
              const SizedBox(height: 16),

              // Dropdown de categoria
              DropdownButtonFormField<String>(
                value: _categoriaSelecionada,
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                items: _categorias.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _categoriaSelecionada = v!),
              ),
              const SizedBox(height: 16),

              // Seletor de data de compra
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
                title: const Text('Data de compra', style: TextStyle(fontSize: 14)),
                subtitle: Text(fmt.format(_dataCompra)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selecionarData(isCompra: true),
              ),
              const SizedBox(height: 12),

              // Seletor de data de vencimento
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
                title: const Text('Vencimento da garantia', style: TextStyle(fontSize: 14)),
                subtitle: Text(fmt.format(_dataVencimento)),
                trailing: const Icon(Icons.event),
                onTap: () => _selecionarData(isCompra: false),
              ),
              const SizedBox(height: 16),

              // Foto NF (mockado)
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Câmera será integrada na próxima versão.')),
                  );
                },
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Adicionar foto da NF'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 28),

              FilledButton(
                onPressed: _salvar,
                style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Salvar produto', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
