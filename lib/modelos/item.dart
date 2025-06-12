// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

class Item {
  final String nome;
  final String descricao;
  final List<String> imagens;
  Item({required this.nome, required this.descricao, required this.imagens});

  Item copyWith({String? nome, String? descricao, List<String>? imagens}) {
    return Item(
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      imagens: imagens ?? this.imagens,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      nome: json['nome'],
      descricao: json['descricao'],
      imagens: List<String>.from(json['imagens'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'nome': nome, 'descricao': descricao, 'imagens': imagens};
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.nome == nome &&
        other.descricao == descricao &&
        listEquals(other.imagens, imagens);
  }

  @override
  int get hashCode => nome.hashCode ^ descricao.hashCode ^ imagens.hashCode;
}
