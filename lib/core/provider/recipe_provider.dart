import 'package:flutter/foundation.dart';
import 'package:whats_cooking/core/model/recipe.dart';
import 'package:whats_cooking/core/service/recipe_api.dart';

enum ConnectionState { Error, Success }

class RecipeProvider extends ChangeNotifier {
  final RecipeApi recipeApi = RecipeApi();
  Recipe get recipe => _recipe;
  Recipe _recipe;

  List<Recipe> get randomRecipes => _randomRecipes;
  List<Recipe> _randomRecipes;

  Future getRandomRecipes() async {
    // if randomRecipes not null than it will add data for infinite scrolling
    if (_randomRecipes != null) {
      _randomRecipes.addAll(await recipeApi.getRandomRecipes());
      print('working ${_randomRecipes.length}');
    } else {
      _randomRecipes = await recipeApi.getRandomRecipes();
    }
    notifyListeners();
  }
}
