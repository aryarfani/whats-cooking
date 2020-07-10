import 'package:json_annotation/json_annotation.dart';

part 'recipe_auto_complete.g.dart';

@JsonSerializable()
class RecipeAutoComplete {
  final int id;
  final String title;

  RecipeAutoComplete(this.id, this.title);

  factory RecipeAutoComplete.fromJson(Map<String, dynamic> json) => _$RecipeAutoCompleteFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeAutoCompleteToJson(this);
}
