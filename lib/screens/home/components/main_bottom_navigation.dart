import 'package:flutter/material.dart';

class MainBottomNavigation extends StatelessWidget {
  final int index;
  final Function setPage;

  MainBottomNavigation(this.index, this.setPage);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (i) {
        setPage(i);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
      ],
    );
  }
}
