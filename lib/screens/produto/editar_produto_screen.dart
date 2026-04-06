// RF005 — Tela Editar Produto
// Responsável: Felipe

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../models/produto.dart';
import '../../providers/produto_provider.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_text_field.dart';

class EditarProdutoScreen extends StatefulWidget {
  const EditarProdutoScreen({super.key});

  @override
  State<EditarProdutoScreen> createState() => _EditarProdutoScreenState();
}

class _EditarProdutoScreenState extends State<EditarProdutoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  String _categoriaSelecionada = 'Eletrônico';
  DateTime _dataCompra = DateTime.now();
  DateTime _dataVencimento = DateTime.now().add(const Duration(days: 365));
  bool _inicializado = false;

  final List<String> _categorias = [
    'Eletrônico', 'Eletrodoméstico', 'Móvel', 'Veículo', 'Ferramenta', 'Outros',
  ];

  void _inicializarCampos(Produto produto) {
    if (_inicializado) return;
    _nomeController.text = produto.nome;
    _categoriaSelecionada = produto.categoria;
    _dataCompra = produto.dataCompra;
    _dataVencimento = produto.dataVencimentoGarantia;
    _inicializado = true;
  }

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

  void _salvar(String id) {
    if (!_formKey.currentState!.validate()) return;

    final produtoAtualizado = Produto(
      id: id,
      nome: _nomeController.text.trim(),
      categoria: _categoriaSelecionada,
      dataCompra: _dataCompra,
      dataVencimentoGarantia: _dataVencimento,
    );

    context.read<ProdutoProvider>().editar(produtoAtualizado);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produto atualizado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final produto = context.read<ProdutoProvider>().buscarPorId(id);
    final fmt = DateFormat('dd/MM/yyyy');

    if (produto == null) {
      return Scaffold(appBar: AppBar(), body: const Center(child: Text('Produto não encontrado.')));
    }

    _inicializarCampos(produto);

    return Scaffold(
      appBar: AppBar(title: const Text('Editar produto')),
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
              DropdownButtonFormField<String>(
                initialValue: _categoriaSelecionada,
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                items: _categorias.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _categoriaSelecionada = v!),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 28),
              FilledButton(
                onPressed: () => _salvar(id),
                style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Salvar alterações', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
