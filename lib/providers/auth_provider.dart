// RF001, RF002, RF003 — Gerenciamento de estado de autenticação
// Responsável: Nicolas Oliveira - RA: 838094

import 'package:flutter/material.dart';
import '../models/usuario.dart';

class AuthProvider extends ChangeNotifier {
  Usuario? _usuarioLogado;

  // Banco de dados mockado — lista de usuários cadastrados
  final List<Usuario> _usuarios = [
    Usuario(
      id: '1',
      nome: 'Usuário Demo',
      email: 'demo@email.com',
      telefone: '(16) 99999-9999',
      senha: '123456',
    ),
  ];

  bool get isLogado => _usuarioLogado != null;
  Usuario? get usuarioLogado => _usuarioLogado;

  // RF001 — Login
  // Retorna null em caso de sucesso, ou uma mensagem de erro
  String? login(String email, String senha) {
    final usuario = _usuarios.firstWhere(
      (u) => u.email == email && u.senha == senha,
      orElse: () => Usuario(id: '', nome: '', email: '', telefone: '', senha: ''),
    );

    if (usuario.id.isEmpty) {
      return 'E-mail ou senha inválidos.';
    }

    _usuarioLogado = usuario;
    notifyListeners();
    return null;
  }

  // RF002 — Cadastro de usuário
  // Retorna null em caso de sucesso, ou uma mensagem de erro
  String? cadastrar({
    required String nome,
    required String email,
    required String telefone,
    required String senha,
  }) {
    final emailJaCadastrado = _usuarios.any((u) => u.email == email);
    if (emailJaCadastrado) {
      return 'Este e-mail já está cadastrado.';
    }

    final novoUsuario = Usuario(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: nome,
      email: email,
      telefone: telefone,
      senha: senha,
    );

    _usuarios.add(novoUsuario);
    _usuarioLogado = novoUsuario;
    notifyListeners();
    return null;
  }

  // RF003 — Esqueceu a senha (mockado)
  // Retorna true se o e-mail existe na base
  bool solicitarRecuperacaoSenha(String email) {
    return _usuarios.any((u) => u.email == email);
  }

  void logout() {
    _usuarioLogado = null;
    notifyListeners();
  }
}
