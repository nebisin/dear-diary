import 'package:dear_dairy/models/paper.dart';
import 'package:dear_dairy/provider/papers.dart';
import 'package:dear_dairy/screens/create/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/detail_card.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
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
        Scaffold.of(context).showSnackBar(snackBar);
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
              FlatButton(
                onPressed: () {
                  _deleteSelf();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              ),
              FlatButton(
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
      appBar: AppBar(
        title: Text(item.title),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'edit') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateScreen(item)));
              } else {
                _showDeleteDialog();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 'edit',
                child: ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Edit',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  title: Text(
                    'Delete',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 3 * 2,
              color: Colors.grey[300],
              child: item.coverImage == null
                  ? null
                  : Image.file(
                      item.coverImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
            ),
            DetailCard(item: item),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(20),
              child: item.body != null
                  ? Text(
                      item.body,
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
      ),
      floatingActionButton: FavoriteButton(item: item),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Paper item;

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    setState(() {
      isFavorite = widget.item.isFavorite;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Provider.of<Papers>(context, listen: false).updatePaper(
          id: widget.item.id,
          title: widget.item.title,
          body: widget.item.body,
          mood: widget.item.mood,
          date: widget.item.date,
          coverImage: widget.item.coverImage,
          isFavorite: !isFavorite,
        );
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
    );
  }
}
