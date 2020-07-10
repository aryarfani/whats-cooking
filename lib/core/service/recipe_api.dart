import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:whats_cooking/core/model/recipe.dart';
import 'package:whats_cooking/core/model/recipe_auto_complete.dart';
import 'package:whats_cooking/core/utils/logging_interceptors.dart';

class RecipeApi {
  Dio get dio => _dio();

  Dio _dio() {
    final options = BaseOptions(
      baseUrl: 'https://api.spoonacular.com',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      contentType: "application/json;charset=utf-8",
    );

    var dio = Dio(options);

    // adding logging interceptor
    // to show all data flow
    dio.interceptors.add(LoggingInterceptors());

    return dio;
  }

  Future<Recipe> getSingleRecipe({@required int id}) async {
    try {
      var res = await dio.get('/recipes/$id/information?apiKey=8df17c4b166b41b2b55e73e07bd030b6');
      return Recipe.fromJson(res.data);
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Recipe>> getRandomRecipes() async {
    try {
      var res = await dio.get('/recipes/random?apiKey=8df17c4b166b41b2b55e73e07bd030b6&number=10');
      return List<Recipe>.from(res.data["recipes"].map((el) => Recipe.fromJson(el)));
    } on DioError catch (error) {
      print(error.message);
    }
    return null;
  }

  Future<List<Recipe>> searchRecipe(String query) async {
    try {
      var res = await dio.get('/recipes/search?apiKey=8df17c4b166b41b2b55e73e07bd030b6&query=$query');
      return List<Recipe>.from(res.data["results"].map((el) => Recipe.fromJson(el)));
    } on DioError catch (error) {
      print(error.message);
    }
    return null;
  }

  Future<List<RecipeAutoComplete>> getAutoComplete(String query) async {
    try {
      var res = await dio.get('/recipes/autocomplete?number=5&query=$query&apiKey=8df17c4b166b41b2b55e73e07bd030b6');
      return List<RecipeAutoComplete>.from(res.data.map((el) => RecipeAutoComplete.fromJson(el)));
    } on DioError catch (error) {
      print(error.message);
    }
    return null;
  }
}
