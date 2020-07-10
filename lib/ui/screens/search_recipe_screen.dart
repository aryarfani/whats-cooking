import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:whats_cooking/core/provider/search_provider.dart';
import 'package:whats_cooking/core/utils/debouncer.dart';
import 'package:whats_cooking/ui/widgets/recipe_item.dart';
import 'package:whats_cooking/ui/widgets/recipe_list_skeleton.dart';

class SearchRecipeScreen extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (_, searchProv, child) {
        return WillPopScope(
          onWillPop: () async {
            searchProv.searchState = SearchState.idle;
            searchProv.emptySearchHistory();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              title: Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.grey[300]),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search),
                    SizedBox(width: 4),
                    Flexible(
                      child: TextField(
                        controller: _textController,
                        style: GoogleFonts.openSans(),
                        onChanged: (text) {
                          // this will give debouce effect
                          _debouncer.run(() => searchProv.showRecipeSuggestion(query: text));
                        },
                        onSubmitted: (text) {
                          searchProv.searchRecipe(query: text);
                        },
                        decoration: InputDecoration(
                          hintText: 'Find your recipe',
                          hintStyle: GoogleFonts.openSans(fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: _buildSearchBody(context, searchProv),
          ),
        );
      },
    );
  }

  Widget _buildSearchBody(context, SearchProvider searchProv) {
    // Loading screen
    if (searchProv.searchState == SearchState.loading) {
      return RecipeListSkeleton();

      // after searching screen
    } else if (searchProv.searchState == SearchState.success) {
      if (searchProv.searchedRecipes.length == 0) {
        return Center(child: Container(child: Text('No Recipes Found')));
      }
      return ListView.builder(
        itemCount: searchProv.searchedRecipes.length,
        itemBuilder: (context, index) {
          return RecipeItem(
            recipe: searchProv.searchedRecipes[index],
            isFromSearch: true,
          );
        },
      );

      // when searching, suggestion list will show
    } else if (searchProv.searchState == SearchState.searching) {
      if (searchProv.suggestionQueryRecipes != null) {
        return ListView.builder(
          itemCount: searchProv.suggestionQueryRecipes.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Unfocus cursor from text
                FocusScope.of(context).unfocus();

                // give the textField text same as suggestion
                _textController.text = searchProv.suggestionQueryRecipes[index].title;
                searchProv.searchRecipe(query: searchProv.suggestionQueryRecipes[index].title);
              },
              child: ListTile(
                title: Text(searchProv.suggestionQueryRecipes[index].title),
              ),
            );
          },
        );
      }
    }
    // on first open searchScreen will show the history
    if (searchProv.searhHistoryList == null) {
      searchProv.getSearchHistory();
      return Container();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
        itemCount: searchProv.searhHistoryList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // give the textField text same as history clicked
              _textController.text = searchProv.searhHistoryList[index].title;
              searchProv.searchRecipe(query: searchProv.searhHistoryList[index].title);
            },
            child: ListTile(
              title: Text(searchProv.searhHistoryList[index].title),
            ),
          );
        },
      ),
    );
  }
}
