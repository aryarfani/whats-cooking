import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:whats_cooking/core/model/recipe.dart';
import 'package:whats_cooking/core/service/firestore_helper.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteProvider(this._currentUser);

  FirebaseUser get currentUser => _currentUser;
  FirebaseUser _currentUser;

  List<Recipe> get favoriteRecipes => _favoriteRecipes;
  List<Recipe> _favoriteRecipes;
  FirestoreHelper _firestoreHelper = FirestoreHelper();

  void addFavoriteRecipe({@required Recipe recipe}) async {
    if (_favoriteRecipes == null) {
      await getFavoriteRecipes();
    }

    // cek if same recipe has been added to favorite list
    var sameRecipe = _favoriteRecipes.firstWhere((el) => el.id == recipe.id, orElse: () => null);
    if (sameRecipe != null) {
      showToast(
        'The same recipe has been added to favorite',
        backgroundColor: Colors.green[400],
        textStyle: TextStyle(color: Colors.white),
      );
      return;
    }

    // add to favorite recipe
    await _firestoreHelper.addFavoriteRecipeToFirestore(recipe: recipe, currentUser: _currentUser);

    showToast(
      'Recipe added to favorite',
      backgroundColor: Colors.green[400],
      textStyle: TextStyle(color: Colors.white),
    );

    // update favorite list
    getFavoriteRecipes();
  }

  Future getFavoriteRecipes() async {
    _favoriteRecipes = await _firestoreHelper.fetchFavoriteRecipes(currentUser: _currentUser);
    notifyListeners();
  }

  void deleteFavoriteRecipe({Recipe recipe}) async {
    await _firestoreHelper.deleteFavoriteRecipeFromFirestore(recipe: recipe);

    showToast(
      'Favorite has been deleted',
      backgroundColor: Colors.green[400],
      textStyle: TextStyle(color: Colors.white),
    );

    // update favorite list
    getFavoriteRecipes();
  }
}
