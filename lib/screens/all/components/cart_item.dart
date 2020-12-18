import 'package:dear_dairy/models/paper.dart';
import 'package:dear_dairy/provider/papers.dart';
import 'package:dear_dairy/screens/create/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'mood_icon.dart';

class CartItem extends StatelessWidget {
  final Paper item;
  final int index;
  final DateTime dateBefore;

  CartItem(this.item, this.index, [this.dateBefore]);

  @override
  Widget build(BuildContext context) {
    _deleteSelf() async {
      try {
        await Provider.of<Papers>(context, listen: false).deletePaper(item.id);
      } catch (e) {
        Widget snackBar = SnackBar(
          content: Text('Something went wrong! Please try again later.'),
        );
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dateBefore == null || dateBefore.day != item.date.day
            ? Opacity(
                opacity: 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: Text(
                    DateFormat('MMMM d').format(item.date),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.grey,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              )
            : Center(),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/detail-screen', arguments: item.id);
          },
          child: Container(
            margin: EdgeInsets.only(
              top: 10,
              bottom: 20,
              right: 20,
              left: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.23),
                  blurRadius: 15,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: item.coverImage != null
                    ? Hero(
                        tag: item.id,
                        child: FadeInImage(
                          placeholder:
                              AssetImage('assets/images/placeholder.jpg'),
                          image: FileImage(item.coverImage),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width / 3 * 2,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width / 3 * 2,
                        child: Hero(
                          tag: item.id,
                          child: Image.asset(
                            'assets/images/placeholder.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              ListTile(
                leading: MoodIcon(item.mood),
                title: Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(DateFormat.MMMMEEEEd().format(item.date)),
                trailing: IconButton(
                  icon: Icon(
                      item.isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    Provider.of<Papers>(context, listen: false).updatePaper(
                      id: item.id,
                      title: item.title,
                      body: item.body,
                      mood: item.mood,
                      date: item.date,
                      coverImage: item.coverImage,
                      isFavorite: !item.isFavorite,
                    );
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: _showDeleteDialog,
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateScreen(item)));
                      },
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }
}
