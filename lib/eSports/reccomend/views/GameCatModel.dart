import 'dart:convert';

class GameCatModel {
  String description;
  String image_url;
  String title;

  GameCatModel({
    required this.description,
    required this.image_url,
    required this.title,
  });

  factory GameCatModel.fromMap(Map<String, dynamic> map) {
    return GameCatModel(
      title: map['title'] as String,
      image_url: map['image_url'] as String,
      description: map['description'] as String,
    );
  }
}
