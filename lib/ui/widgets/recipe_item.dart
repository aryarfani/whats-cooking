import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whats_cooking/core/model/recipe.dart';
import 'package:whats_cooking/core/utils/router.dart';

class RecipeItem extends StatelessWidget {
  RecipeItem({@required this.recipe, this.isFromSearch = false, this.isFavoriteScreen = false});
  final Recipe recipe;

  // recipe list from search result doesnt have detail data
  // so it will fetch from api
  final bool isFromSearch;

  // if this is in FavoriteListScreen
  // will show delete icon and delete function instead of add
  final bool isFavoriteScreen;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteName.recipeDetail,
          arguments: {'recipe': recipe, 'isFromSearch': isFromSearch, 'isFavoriteScreen': isFavoriteScreen},
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 12, right: 12, bottom: 24, top: 8),
        // width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(minHeight: 180),
              margin: EdgeInsets.only(bottom: 8),
              child: Hero(
                tag: recipe.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: recipe.image == null
                      ? Image.asset('images/noimagefood.jpg', fit: BoxFit.cover)
                      : Image.network('https://spoonacular.com/recipeImages/${recipe.id}-480x360.jpg'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                recipe.title,
                style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Row(
                children: <Widget>[
                  Icon(Icons.favorite_border, color: Colors.black54),
                  SizedBox(width: 4),
                  Text(Random().nextInt(1000).toString(),
                      style: GoogleFonts.openSans(color: Colors.black54, fontSize: 13)),
                  SizedBox(width: 10),
                  Icon(Icons.access_time, color: Colors.black45),
                  SizedBox(width: 4),
                  Text(recipe.readyInMinutes.toString() + '`',
                      style: GoogleFonts.openSans(color: Colors.black54, fontSize: 13)),
                  SizedBox(width: 10),
                  Text('3 Portions', style: GoogleFonts.openSans(color: Colors.black54, fontSize: 13))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
