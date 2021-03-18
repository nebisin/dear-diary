import 'package:dear_dairy/provider/papers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/cart_item.dart';
import 'components/hero_section.dart';

class AllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Papers>(context, listen: false).fetchPapers(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Papers>(
                  child: HeroSection(),
                  builder: (ctx, papers, child) => papers.items.length <= 0
                      ? child!
                      : ListView.builder(
                          itemBuilder: (ctx, i) => CartItem(papers.items[i], i, i == 0 ? null : papers.items[i - 1].date),
                          itemCount: papers.items.length,
                        ),
                ),
    );
  }
}
