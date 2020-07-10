import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeListSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildSkeleton(),
        _buildSkeleton(),
        _buildSkeleton(),
      ],
    );
  }

  Padding _buildSkeleton() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[400],
        highlightColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 10,
              width: 150,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Container(
              height: 10,
              width: 100,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
