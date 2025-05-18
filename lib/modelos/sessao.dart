// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Role { user, admin, moderator }

class Sessao {
  String token;
  String id;
  Role direitos;
  String instituicao;
  String matricula;
  String nome;
  String senha;
  String email;
  bool lembrar;
  Sessao({
    this.id = '',
    this.token = '',
    this.matricula = '',
    this.direitos = Role.user,
    this.instituicao = '',
    this.nome = '',
    this.senha = '',
    this.email = '',
    this.lembrar = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'role': direitos.name,
      'email': email,
      'instituicao': instituicao,
      'name': nome,
      'lembrar': lembrar,
      'password': senha,
      'matricula':matricula
    };
  }

  factory Sessao.fromMap(Map<String, dynamic> map) {
    final user = map['user'];
    return Sessao(
      id: user['id'] ?? '',
      token: map['token'] ?? '',
      direitos: Role.values.firstWhere(
        (test) => test.name == user['role'],
        orElse: () => Role.user,
      ),
      instituicao: user['instituicao'] ?? '',
      nome: user['name'] ?? '',
      lembrar: user['lembrar'] ?? false,
      senha: user['password'] ?? '',
      matricula: user['matricula'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Sessao.fromJson(String source) =>
      Sessao.fromMap(json.decode(source) as Map<String, dynamic>);
}
