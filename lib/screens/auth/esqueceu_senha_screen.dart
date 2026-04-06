// RF003 — Tela Esqueceu a Senha
// Responsável: Felipe Fragiorgis - RA: 840337

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_text_field.dart';

class EsqueceuSenhaScreen extends StatefulWidget {
  const EsqueceuSenhaScreen({super.key});

  @override
  State<EsqueceuSenhaScreen> createState() => _EsqueceuSenhaScreenState();
}

class _EsqueceuSenhaScreenState extends State<EsqueceuSenhaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _solicitarRecuperacao() {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final encontrado = auth.solicitarRecuperacaoSenha(_emailController.text.trim());

    // RF006 — AlertDialog para ambos os casos
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(encontrado ? 'E-mail enviado' : 'E-mail não encontrado'),
        content: Text(
          encontrado
              ? 'Instruções de redefinição foram enviadas para ${_emailController.text.trim()}.'
              : 'Não encontramos uma conta com este e-mail. Verifique e tente novamente.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // fecha dialog
              if (encontrado) Navigator.pop(context); // volta para login
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar senha')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            
              const SizedBox(height: 28),
              CustomTextField(
                controller: _emailController,
                label: 'E-mail cadastrado',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validator: Validators.email,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _solicitarRecuperacao,
                style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Enviar instruções', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
