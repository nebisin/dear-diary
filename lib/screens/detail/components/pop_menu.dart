import 'package:dear_dairy/models/paper.dart';
import 'package:dear_dairy/screens/create/create_screen.dart';
import 'package:flutter/material.dart';

class PopMenu extends StatelessWidget {
  const PopMenu({
    Key key,
    @required this.item,
    @required this.showDeleteDialog,
  }) : super(key: key);

  final Paper item;
  final Function showDeleteDialog;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 'edit') {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateScreen(item)));
        } else {
          showDeleteDialog();
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
    );
  }
}
