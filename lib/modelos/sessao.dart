// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Role { user, admin, moderator }

class Sessao {
  String token;
  String id;
  Role direitos;
  String instituicao;
  String nome;
  String senha;
  String email;
  bool lembrar;
  Sessao({
    this.id = '',
    this.token = '',
    this.direitos = Role.user,
    this.instituicao = '',
    this.nome = '',
    this.senha = '',
    this.email = '',
    this.lembrar = false,
  });

  Sessao copyWith({
    String? token,
    Role? direitos,
    String? instituicao,
    String? nome,
    String? email,
  }) {
    return Sessao(
      token: token ?? this.token,
      direitos: direitos ?? this.direitos,
      instituicao: instituicao ?? this.instituicao,
      nome: nome ?? this.nome,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'role': direitos.name,
      'email': email,
      'instituicao': instituicao,
      'name': nome,
      'lembrar': lembrar,
      'password': senha,
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
      senha: user['senha'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Sessao.fromJson(String source) =>
      Sessao.fromMap(json.decode(source) as Map<String, dynamic>);
}
