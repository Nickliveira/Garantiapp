// Modelo de dados do Usuário
// Responsável: Enzo Botoloto - RA: 838500

class Usuario {
  final String id;
  String nome;
  String email;
  String telefone;
  String senha; // Em produção, nunca armazenar em plain text

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.senha,
  });
}
