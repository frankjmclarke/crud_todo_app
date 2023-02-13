import 'package:dart_emoji/dart_emoji.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class Category extends Equatable {
  const Category({
    required this.url,
    required this.phone,
    required this.date,
    required this.description,
    required this.rent,
    required this.status,
    required this.emoji,
    this.id,
    this.todoSize = 0,
  });

  //json_serializable
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  @JsonKey(includeIfNull: false)
  final String? id;

  //database fields
  final String url;
  final String phone;
  final DateTime date;
  final String description;
  final num rent;
  final String status;

  //json_serializable
  @JsonKey(fromJson: _emojiFromJson, toJson: _emojiToJson)
  final Emoji emoji;

  final int todoSize;

  //json_serializable
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  //equitable
  @override
  List<Object?> get props => [id, url,phone,date,description,rent,status, emoji, todoSize];

  static Emoji _emojiFromJson(String emojiCode) => EmojiParser().get(emojiCode);

  static String _emojiToJson(Emoji emoji) => emoji.full;
}
