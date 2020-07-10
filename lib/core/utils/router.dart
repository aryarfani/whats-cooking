import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_cooking/ui/screens/favorite_list_screen.dart';
import 'package:whats_cooking/ui/screens/home_screen.dart';
import 'package:whats_cooking/ui/screens/recipe_detail_screen.dart';
import 'package:whats_cooking/ui/screens/search_recipe_screen.dart';
import 'package:whats_cooking/ui/screens/signin_screen.dart';

class RouteName {
  static const String home = "home";
  static const String signIn = "signIn";
  static const String recipeDetail = "recipeDetail";
  static const String searchRecipe = "searchRecipe";
  static const String favoriteRecipe = "favoriteRecipe";
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouteName.signIn:
        return MaterialPageRoute(builder: (_) => SigninScreen());
      case RouteName.favoriteRecipe:
        return MaterialPageRoute(builder: (_) => FavoriteListScreen());
      case RouteName.recipeDetail:
        return MaterialPageRoute(builder: (_) => RecipeDetailScreen(settings.arguments));
      case RouteName.searchRecipe:
        return CupertinoPageRoute(builder: (_) => SearchRecipeScreen());
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
