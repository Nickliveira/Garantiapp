// Utilitários de validação reutilizáveis em todo o app
// RF001, RF002, RF003 dependem dessas funções

class Validators {
  static String? obrigatorio(String? value, {String campo = 'Este campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$campo é obrigatório.';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'O e-mail é obrigatório.';
    }
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Informe um e-mail válido.';
    }
    return null;
  }

  static String? senha(String? value) {
    if (value == null || value.isEmpty) {
      return 'A senha é obrigatória.';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }
    return null;
  }

  static String? confirmarSenha(String? value, String senha) {
    if (value == null || value.isEmpty) {
      return 'Confirme a senha.';
    }
    if (value != senha) {
      return 'As senhas não coincidem.';
    }
    return null;
  }
}
