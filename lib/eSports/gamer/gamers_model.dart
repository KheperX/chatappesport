// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class GamersModel {
  //  //generate data class
  String id;
  String image_url;
  String name;
  String phone;
  String email;
  String game;
  String game_image;
  String experience;
  String description;
  String url;
  String followers;
  String following;
  String posts;
  String game2;
  String game2_image;
  GamersModel({
    required this.id,
    required this.image_url,
    required this.name,
    required this.phone,
    required this.email,
    required this.game,
    required this.game_image,
    required this.experience,
    required this.description,
    required this.url,
    required this.followers,
    required this.following,
    required this.posts,
    required this.game2,
    required this.game2_image,
  });

  GamersModel copyWith({
    String? id,
    String? image_url,
    String? name,
    String? phone,
    String? email,
    String? game,
    String? game_image,
    String? experience,
    String? description,
    String? url,
    String? followers,
    String? following,
    String? posts,
    String? game2,
    String? game2_image,
  }) {
    return GamersModel(
      id: id ?? this.id,
      image_url: image_url ?? this.image_url,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      game: game ?? this.game,
      game_image: game_image ?? this.game_image,
      experience: experience ?? this.experience,
      description: description ?? this.description,
      url: url ?? this.url,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      posts: posts ?? this.posts,
      game2: game2 ?? this.game2,
      game2_image: game2_image ?? this.game2_image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_url': image_url,
      'name': name,
      'phone': phone,
      'email': email,
      'game': game,
      'game_image': game_image,
      'experience': experience,
      'description': description,
      'url': url,
      'followers': followers,
      'following': following,
      'posts': posts,
      'game2': game2,
      'game2_image': game2_image,
    };
  }

  factory GamersModel.fromMap(Map<String, dynamic> map, String id) {
    return GamersModel(
      id: id,
      image_url: map['image_url'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      game: map['game'] as String,
      game_image: map['game_image'] as String,
      experience: map['experience'] as String,
      description: map['description'] as String,
      url: map['url'] as String,
      followers: map['followers'] as String,
      following: map['following'] as String,
      posts: map['posts'] as String,
      game2: map['game2'] as String,
      game2_image: map['game2_image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory GamersModel.fromJson(String source) => GamersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GamersModel(id: $id, image_url: $image_url, name: $name, phone: $phone, email: $email, game: $game, game_image: $game_image, experience: $experience, description: $description, url: $url, followers: $followers, following: $following, posts: $posts, game2: $game2, game2_image: $game2_image)';
  }

  @override
  bool operator ==(covariant GamersModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image_url == image_url &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.game == game &&
        other.game_image == game_image &&
        other.experience == experience &&
        other.description == description &&
        other.url == url &&
        other.followers == followers &&
        other.following == following &&
        other.posts == posts &&
        other.game2 == game2 &&
        other.game2_image == game2_image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image_url.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        game.hashCode ^
        game_image.hashCode ^
        experience.hashCode ^
        description.hashCode ^
        url.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        posts.hashCode ^
        game2.hashCode ^
        game2_image.hashCode;
  }
}
