import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whats_cooking/core/model/recipe.dart';
import 'package:whats_cooking/core/model/recipe_auto_complete.dart';
import 'package:whats_cooking/core/service/firestore_helper.dart';
import 'package:whats_cooking/core/service/recipe_api.dart';

// Enum for search state
enum SearchState { loading, idle, searching, success }

class SearchProvider extends ChangeNotifier {
  SearchProvider(this._currentUser);

  FirebaseUser get currentUser => _currentUser;
  FirebaseUser _currentUser;

  FirestoreHelper _firestoreHelper = FirestoreHelper();

  final RecipeApi recipeApi = RecipeApi();

  List<RecipeAutoComplete> get searhHistoryList => _searhHistoryList;
  List<RecipeAutoComplete> _searhHistoryList;

  // property for autocomplete
  List<Recipe> get searchedRecipes => _searchedRecipes;
  List<Recipe> _searchedRecipes;

  // property for autocomplete query
  List<RecipeAutoComplete> get suggestionQueryRecipes => _suggestionQueryRecipes;
  List<RecipeAutoComplete> _suggestionQueryRecipes;

  Recipe get recipe => _recipe;
  Recipe _recipe;

  SearchState searchState = SearchState.idle;

  Future showRecipeSuggestion({String query}) async {
    searchState = SearchState.searching;
    _suggestionQueryRecipes = await recipeApi.getAutoComplete(query);
    notifyListeners();
  }

  Future getSearchRecipeDetail({@required int id}) async {
    _recipe = await recipeApi.getSingleRecipe(id: id);
    notifyListeners();
  }

  Future searchRecipe({String query}) async {
    // add in firestore history
    addSearchHistory(query);
    // show the loading
    searchState = SearchState.loading;
    notifyListeners();

    // show the suggestion
    _searchedRecipes = await recipeApi.searchRecipe(query);
    searchState = SearchState.success;
    notifyListeners();
  }

  void addSearchHistory(String query) async {
    _firestoreHelper.addSearchHistoryToFirestore(currentUser: _currentUser, query: query);
  }

  void getSearchHistory() async {
    _searhHistoryList = await _firestoreHelper.fetchSearchHistory(currentUser: _currentUser);
    notifyListeners();
  }

  // callback to clear on willPop search page
  void emptyRecipe() {
    _recipe = null;
  }

  void emptySearchHistory() {
    _searhHistoryList = null;
    notifyListeners();
  }

  // Future getUser() async {
  //   if (_currentUser == null) {
  //     _currentUser = await FirebaseAuth.instance.currentUser();
  //     notifyListeners();
  //   }
  // }
}
