import 'package:json_annotation/json_annotation.dart';

part 'searchedRecipe.g.dart';

@JsonSerializable()
class SearchedRecipe {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;
  final int servings;

  SearchedRecipe(this.id, this.title, this.image, this.readyInMinutes, this.servings);

  factory SearchedRecipe.fromJson(Map<String, dynamic> json) => _$SearchedRecipeFromJson(json);

  Map<String, dynamic> toJson() => _$SearchedRecipeToJson(this);
}
