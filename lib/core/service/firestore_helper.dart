import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:whats_cooking/core/model/recipe.dart';
import 'package:whats_cooking/core/model/recipe_auto_complete.dart';

class FirestoreHelper {
  final _firestore = Firestore.instance;

  Future addSearchHistoryToFirestore({@required FirebaseUser currentUser, @required String query}) async {
    await _firestore.collection('history_search').add({
      'user_id': currentUser.uid,
      'title': query,
      'date': DateTime.now().millisecondsSinceEpoch,
      'id': DateTime.now().millisecond
    });
  }

  Future<List<RecipeAutoComplete>> fetchSearchHistory({@required FirebaseUser currentUser}) async {
    var data = await _firestore
        .collection('history_search')
        .where('user_id', isEqualTo: currentUser.uid)
        .orderBy('date')
        .getDocuments();
    return List<RecipeAutoComplete>.from(data.documents.map((document) => RecipeAutoComplete.fromJson(document.data)));
  }

  Future deleteFavoriteRecipeFromFirestore({@required Recipe recipe}) async {
    await _firestore.collection('favorite_recipes').where('id', isEqualTo: recipe.id).getDocuments().then((snapshot) {
      snapshot.documents.first.reference.delete();
    });
  }

  Future<List<Recipe>> fetchFavoriteRecipes({@required FirebaseUser currentUser}) async {
    var data =
        await _firestore.collection('favorite_recipes').where('user_id', isEqualTo: currentUser.uid).getDocuments();

    return List<Recipe>.from(data.documents.map((document) => Recipe.fromJson(document.data)));
  }

  Future addFavoriteRecipeToFirestore({@required Recipe recipe, @required FirebaseUser currentUser}) async {
    await _firestore.collection('favorite_recipes').add({
      'user_id': currentUser.uid,
      'id': recipe.id,
      'title': recipe.title,
      'image': recipe.image,
      'instructions': recipe.instructions,
      'summary': recipe.summary,
      'servings': recipe.servings,
      'readyInMinutes': recipe.readyInMinutes,
      'aggregateLikes': recipe.aggregateLikes,
      'date': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
