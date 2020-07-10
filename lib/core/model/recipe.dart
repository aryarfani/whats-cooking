import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  final int id;
  final String title;
  final String summary;
  final String image;
  final String instructions;
  final double healthScore;
  final int servings;
  final int readyInMinutes;
  final int aggregateLikes;

  Recipe(this.id, this.title, this.summary, this.image, this.servings, this.instructions, this.healthScore,
      this.readyInMinutes, this.aggregateLikes);

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
