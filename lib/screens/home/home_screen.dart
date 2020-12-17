import 'package:dear_dairy/screens/all/all_screen.dart';
import 'package:dear_dairy/screens/favorites/favorites_screen.dart';
import 'package:flutter/material.dart';

import 'components/main_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;
  void setPage(index) {
    setState(() {
      page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dear Diary'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/create-screen');
            },
          )
        ],
      ),
      body: page == 0 ? AllScreen() : FavoritesScreen(),
      bottomNavigationBar: MainBottomNavigation(page, setPage),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/create-screen');
        },
        tooltip: 'New Sheet',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
