import 'package:equatable/equatable.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class Category extends Equatable {
  const Category({
    this.id,
    required this.name,
    required this.emoji,
    this.todoSize = 0,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  @JsonKey(includeIfNull: false)
  final String? id;

  final String name;

  @JsonKey(fromJson: _emojiFromJson, toJson: _emojiToJson)
  final Emoji emoji;

  final int todoSize;

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [id, name, emoji, todoSize];
}

Emoji _emojiFromJson(String emojiCode) => EmojiParser().get(emojiCode);

String _emojiToJson(Emoji emoji) => emoji.full;
