// Deprecated for now

import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text('Menu'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.menu_open),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: ()  {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text('Favorites'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/favorites-screen');
          },
        ),
        ListTile(
          leading: Icon(Icons.archive),
          title: Text('Archive'),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {},
        ),
      ],
    );
  }
}
