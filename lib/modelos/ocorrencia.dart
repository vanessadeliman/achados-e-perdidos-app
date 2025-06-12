// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:achados_e_perdidos/modelos/item.dart';

class Ocorrencia {
  final String id;
  final String usuarioId;
  final DateTime ocorrencia;
  final String local;
  final String situacao;
  final String status;
  final Item item;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Ocorrencia copyWith({
    String? id,
    String? usuarioId,
    DateTime? ocorrencia,
    String? local,
    String? situacao,
    String? status,
    Item? item,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Ocorrencia(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      ocorrencia: ocorrencia ?? this.ocorrencia,
      local: local ?? this.local,
      situacao: situacao ?? this.situacao,
      status: status ?? this.status,
      item: item ?? this.item,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Ocorrencia({
    this.id = '0',
    required this.usuarioId,
    required this.ocorrencia,
    required this.local,
    required this.situacao,
    required this.status,
    required this.item,
    this.createdAt,
    this.updatedAt,
  });

  factory Ocorrencia.fromJson(Map<String, dynamic> json) {
    return Ocorrencia(
      id: json['_id'],
      usuarioId: json['usuario_id'],
      ocorrencia: DateTime.parse(json['ocorrencia']),
      local: json['local'],
      situacao: json['situacao'],
      status: json['status'],
      item: Item.fromJson(json['item']),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'usuario_id': usuarioId,
      'ocorrencia': ocorrencia.toIso8601String(),
      'local': local,
      'situacao': situacao,
      'status': status,
      'item': item.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Ocorrencia(id: $id, usuarioId: $usuarioId, ocorrencia: $ocorrencia, local: $local, situacao: $situacao, status: $status, item: $item, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Ocorrencia other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.usuarioId == usuarioId &&
        other.ocorrencia == ocorrencia &&
        other.local == local &&
        other.situacao == situacao &&
        other.status == status &&
        other.item == item &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        usuarioId.hashCode ^
        ocorrencia.hashCode ^
        local.hashCode ^
        situacao.hashCode ^
        status.hashCode ^
        item.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
