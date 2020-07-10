// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchedRecipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchedRecipe _$SearchedRecipeFromJson(Map<String, dynamic> json) {
  return SearchedRecipe(
    json['id'] as int,
    json['title'] as String,
    json['image'] as String,
    json['readyInMinutes'] as int,
    json['servings'] as int,
  );
}

Map<String, dynamic> _$SearchedRecipeToJson(SearchedRecipe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'readyInMinutes': instance.readyInMinutes,
      'servings': instance.servings,
    };
