import 'package:dear_dairy/provider/papers.dart';
import 'package:dear_dairy/screens/favorites/components/favorite_item.dart';
import 'package:dear_dairy/screens/favorites/components/favorite_item_left.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Papers>(
      builder: (ctx, papers, child) => ListView.builder(
        itemBuilder: (ctx, i) => i.isEven == true
            ? FavoriteItem(papers.favorites[i], i)
            : FavoriteItemLeft(papers.favorites[i], i),
        itemCount: papers.favorites.length,
      ),
    );
  }
}
