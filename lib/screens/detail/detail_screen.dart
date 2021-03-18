// import 'dart:io';

import 'package:dear_dairy/provider/papers.dart';
// import 'package:dear_dairy/services/advert_service.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';

import 'components/detail_card.dart';
import 'components/favorite_button.dart';
import 'components/pop_menu.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // final AdvertService _advertService = AdvertService();
  final InAppReview inAppReview = InAppReview.instance;

  @override
  void initState() {
    // _advertService.showIntersitial();
    super.initState();
    _requestReview();
  }

  Future<void> _requestReview() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String?;
    final item = Provider.of<Papers>(
      context,
      listen: false,
    ).findById(id);

    Widget snackBar;
    _deleteSelf() async {
      try {
        await Provider.of<Papers>(context, listen: false).deletePaper(item.id);
        Navigator.of(context).pop();
      } catch (e) {
        snackBar = SnackBar(
            content: Text('Something went wrong! Please try again later.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar as SnackBar);
      }
    }

    Future<void> _showDeleteDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'You are deleting the sheet',
              style: Theme.of(context).textTheme.headline5,
            ),
            content: Text('Are you sure to delete this sheet?'),
            actions: [
              TextButton(
                onPressed: () {
                  _deleteSelf();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.width / 3 * 2,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(item.title!),
              background: item.coverImage == null
                  ? Hero(
                      tag: item.id!,
                      child: Image.asset(
                        'assets/images/placeholder.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : Hero(
                      tag: item.id!,
                      child: Image.file(
                        item.coverImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
            ),
            actions: [
              PopMenu(
                item: item,
                showDeleteDialog: _showDeleteDialog,
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                DetailCard(item: item),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(20),
                  child: item.body != null
                      ? Text(
                          item.body!,
                          style: TextStyle(
                            height: 1.7,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.start,
                        )
                      : null,
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FavoriteButton(item: item),
    );
  }
}
