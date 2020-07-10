import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_cooking/core/provider/favorite_provider.dart';
import 'package:whats_cooking/ui/widgets/recipe_item.dart';

class FavoriteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favProv, child) {
        if (favProv.favoriteRecipes == null) {
          favProv.getFavoriteRecipes();
          return Material(child: Center(child: CircularProgressIndicator()));
        }
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black87),
              title: Text(
                'Favorite Recipe',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            body: favProv.favoriteRecipes.length == 0
                ? Center(child: Text('No favorites yet :('))
                : Container(
                    child: ListView.builder(
                      itemCount: favProv.favoriteRecipes.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RecipeItem(
                          recipe: favProv.favoriteRecipes[index],
                          isFavoriteScreen: true,
                        );
                      },
                    ),
                  ),
          ),
        );
      },
    );
  }
}
