import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:whats_cooking/core/provider/recipe_provider.dart';
import 'package:whats_cooking/ui/widgets/recipe_item.dart';
import 'package:whats_cooking/ui/widgets/recipe_list_skeleton.dart';

class RecipeListScreen extends StatelessWidget {
  final RefreshController _controller = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, recipeProv, _) {
        if (recipeProv.randomRecipes == null) {
          recipeProv.getRandomRecipes();
          return RecipeListSkeleton();
        }
        // infinite scrolling
        return SmartRefresher(
          controller: _controller,
          onLoading: () {
            // when reach bottom load new data
            recipeProv.getRandomRecipes();
            _controller.loadComplete();
          },
          enablePullUp: true,
          enablePullDown: false,
          child: ListView.builder(
            itemCount: recipeProv.randomRecipes.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return RecipeItem(
                recipe: recipeProv.randomRecipes[index],
              );
            },
          ),
        );
      },
    );
  }
}
