// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartoonModel {
  final String name;
  final String cover;
  final String pdf;
  CartoonModel({
    required this.name,
    required this.cover,
    required this.pdf,
  });

  CartoonModel copyWith({
    String? name,
    String? cover,
    String? pdf,
  }) {
    return CartoonModel(
      name: name ?? this.name,
      cover: cover ?? this.cover,
      pdf: pdf ?? this.pdf,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cover': cover,
      'pdf': pdf,
    };
  }

  factory CartoonModel.fromMap(Map<String, dynamic> map) {
    return CartoonModel(
      name: map['name'] as String,
      cover: map['cover'] as String,
      pdf: map['pdf'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartoonModel.fromJson(String source) =>
      CartoonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CartoonModel(name: $name, cover: $cover, pdf: $pdf)';

  @override
  bool operator ==(covariant CartoonModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.cover == cover && other.pdf == pdf;
  }

  @override
  int get hashCode => name.hashCode ^ cover.hashCode ^ pdf.hashCode;
}
