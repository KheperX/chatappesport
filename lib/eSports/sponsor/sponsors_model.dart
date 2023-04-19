// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SponsorsModel {
  String company;
  String phone;
  String image_url;
  String email;
  String description;
  SponsorsModel({
    required this.company,
    required this.phone,
    required this.image_url,
    required this.email,
    required this.description,
  });

  SponsorsModel copyWith({
    String? company,
    String? phone,
    String? image_url,
    String? email,
    String? description,
  }) {
    return SponsorsModel(
      company: company ?? this.company,
      phone: phone ?? this.phone,
      image_url: image_url ?? this.image_url,
      email: email ?? this.email,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'company': company,
      'phone': phone,
      'image_url': image_url,
      'email': email,
      'description': description,
    };
  }

  factory SponsorsModel.fromMap(Map<String, dynamic> map) {
    return SponsorsModel(
      company: map['company'] as String,
      phone: map['phone'] as String,
      image_url: map['image_url'] as String,
      email: map['email'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SponsorsModel.fromJson(String source) =>
      SponsorsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SponsorsModel(company: $company, phone: $phone, image_url: $image_url, email: $email, description: $description)';
  }

  @override
  bool operator ==(covariant SponsorsModel other) {
    if (identical(this, other)) return true;

    return other.company == company &&
        other.phone == phone &&
        other.image_url == image_url &&
        other.email == email &&
        other.description == description;
  }

  @override
  int get hashCode {
    return company.hashCode ^
        phone.hashCode ^
        image_url.hashCode ^
        email.hashCode ^
        description.hashCode;
  }
}
