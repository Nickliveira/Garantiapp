// RF002 — Tela de Cadastro de Usuário
// Responsável: Felipe Fragiorgis - RA: 840337

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../../utils/app_routes.dart';
import '../../widgets/custom_text_field.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  bool _senhaVisivel = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  void _cadastrar() {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final erro = auth.cadastrar(
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim(),
      telefone: _telefoneController.text.trim(),
      senha: _senhaController.text,
    );

    if (erro != null) {
      // RF006 — SnackBar de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(erro), backgroundColor: Colors.red[700]),
      );
    } else {
      // RF006 — AlertDialog de sucesso
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Conta criada!'),
          content: const Text('Seu cadastro foi realizado com sucesso.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // fecha dialog
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              child: const Text('Continuar'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _nomeController,
                label: 'Nome completo',
                validator: (v) => Validators.obrigatorio(v, campo: 'O nome'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                label: 'E-mail',
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _telefoneController,
                label: 'Telefone',
                keyboardType: TextInputType.phone,
                validator: (v) => Validators.obrigatorio(v, campo: 'O telefone'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _senhaController,
                label: 'Senha',
                obscureText: !_senhaVisivel,
                suffixIcon: IconButton(
                  icon: Icon(_senhaVisivel ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _senhaVisivel = !_senhaVisivel),
                ),
                validator: Validators.senha,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _confirmarSenhaController,
                label: 'Confirmar senha',
                obscureText: true,
                textInputAction: TextInputAction.done,
                validator: (v) => Validators.confirmarSenha(v, _senhaController.text),
              ),
              const SizedBox(height: 28),
              FilledButton(
                onPressed: _cadastrar,
                style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Criar conta', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
