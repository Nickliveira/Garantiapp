// RF004 — Tela Sobre
// Responsável: Felipe Fragiorgis - RA: 840337

import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo e nome
            Center(
              child: Column(
                children: [
                  const Icon(Icons.verified_user, size: 72, color: Colors.blue),
                  const SizedBox(height: 8),
                  const Text(
                    'GarantiApp',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Versão 1.0.0',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            _secao('Objetivo do aplicativo'),
            const Text(
              'O GarantiApp permite que você cadastre produtos, acompanhe os prazos de garantia '
              'e armazene fotos das notas fiscais — tudo em um só lugar. Chega de perder garantia '
              'por não saber onde estava a NF!',
              style: TextStyle(fontSize: 14, height: 1.6),
            ),
            const SizedBox(height: 24),

            _secao('Equipe de desenvolvimento'),
            _membro('Nicolas Oliveira - RA: 838094', 'Líder técnico — Setup, Login, Produtos'),
            _membro('Felipe Fragiorgis - RA: 840337', 'Cadastro, Recuperação de senha, Edição'),
            _membro('Enzo Botoloto - RA: 838500', 'Listagem, Alertas, Navegação'),
            const SizedBox(height: 24),

            _secao('Informações acadêmicas'),
            _infoLinha('Disciplina', 'Programação Mobile II - AC622A'),
            _infoLinha('Instituição', 'Unaerp Ribeirão Preto'),
            _infoLinha('Professor', 'Rodrigo de O. Plotze & Samuel Z. Oliva'),
            _infoLinha('Ano', '2026'),
          ],
        ),
      ),
    );
  }

  Widget _secao(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        titulo,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _membro(String nome, String papel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nome, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(papel, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoLinha(String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13))),
          Text(valor, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
