// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String?,
      url: json['url'] as String,
      phone: json['phone'] as String,
      date: json['date'] as DateTime,
      description: json['description'] as String,
      rent: json['rent'] as num,
      status: json['status'] as String,
      emoji: Category._emojiFromJson(json['emoji'] as String),
      todoSize: json['todoSize'] as int? ?? 0,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['phone'] = instance.phone;
  val['date'] = instance.date;
  val['description'] = instance.description;
  val['rent'] = instance.rent;
  val['status'] = instance.status;
  val['emoji'] = Category._emojiToJson(instance.emoji);
  val['todoSize'] = instance.todoSize;
  return val;
}
