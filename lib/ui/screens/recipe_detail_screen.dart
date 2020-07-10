import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:whats_cooking/core/model/recipe.dart';
import 'package:whats_cooking/core/provider/favorite_provider.dart';
import 'package:whats_cooking/core/provider/search_provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen(this.arguments);
  final Map arguments;

  @override
  Widget build(BuildContext context) {
    if (arguments['isFromSearch'] == true) {
      return Consumer<SearchProvider>(
        builder: (_, searchProv, child) {
          if (searchProv.recipe == null) {
            searchProv.getSearchRecipeDetail(id: arguments['recipe'].id);
            return Material(child: Center(child: CircularProgressIndicator()));
          }

          return SafeArea(
            // to empty the propery when exit
            child: WillPopScope(
              onWillPop: () async {
                searchProv.emptyRecipe();
                return true;
              },
              child: Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
                    _buildHeader(context, searchProv.recipe),
                    _buildBody(searchProv.recipe),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _buildHeader(context, arguments['recipe']),
            _buildBody(arguments['recipe']),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildHeader(context, Recipe recipe) {
    return SliverAppBar(
      actions: <Widget>[
        InkWell(
          onTap: () {
            if (arguments['isFavoriteScreen']) {
              Provider.of<FavoriteProvider>(context, listen: false).deleteFavoriteRecipe(recipe: recipe);
              Navigator.pop(context);
              return;
            }
            Provider.of<FavoriteProvider>(context, listen: false).addFavoriteRecipe(recipe: recipe);
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: arguments['isFavoriteScreen'] ? Colors.red.withOpacity(0.8) : Colors.white12,
            ),
            child: arguments['isFavoriteScreen'] ? Icon(Icons.delete) : Icon(Icons.bookmark),
          ),
        )
      ],
      expandedHeight: 240,
      pinned: true,
      floating: true,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 40, bottom: 14),
        collapseMode: CollapseMode.pin,
        title: Text(
          recipe.title,
          style: GoogleFonts.montserrat(
              fontSize: 14,
              shadows: [
                Shadow(
                  blurRadius: 14,
                  color: Colors.black12,
                  offset: Offset(4, 4),
                )
              ],
              fontWeight: FontWeight.w600),
        ),
        background: Hero(
          tag: recipe.id,
          child: Image.network(
            recipe.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  SliverList _buildBody(Recipe recipe) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(right: 18, left: 18, top: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Summary',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Html(data: recipe.summary),
              Text(
                'Instructions',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Html(data: recipe.instructions),
            ],
          ),
        ),
      ]),
    );
  }
}
