// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return Recipe(
    json['id'] as int,
    json['title'] as String,
    json['summary'] as String,
    json['image'] as String,
    json['servings'] as int,
    json['instructions'] as String,
    (json['healthScore'] as num)?.toDouble(),
    json['readyInMinutes'] as int,
    json['aggregateLikes'] as int,
  );
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'image': instance.image,
      'instructions': instance.instructions,
      'healthScore': instance.healthScore,
      'servings': instance.servings,
      'readyInMinutes': instance.readyInMinutes,
      'aggregateLikes': instance.aggregateLikes,
    };
