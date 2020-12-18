import 'package:dear_dairy/provider/papers.dart';
import 'package:dear_dairy/screens/create/create_screen.dart';
import 'package:dear_dairy/screens/detail/detail_screen.dart';
import 'package:dear_dairy/screens/favorites/favorites_screen.dart';
import 'package:dear_dairy/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/custom_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Papers(),
      child: MaterialApp(
        title: 'Dear Diary',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Color(0xDD0C9869),
          scaffoldBackgroundColor: Color.fromRGBO(238, 243, 251, 1),
          appBarTheme: AppBarTheme(
            color: Color(0xDD0C9869),
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.white,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: Colors.green, backgroundColor: Colors.white),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            headline5: TextStyle(
              color: Color.fromRGBO(65, 71, 82, 1),
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            headline4: TextStyle(
              color: Color(0xDD0C9869),
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            subtitle2: TextStyle(
              color: Colors.white70,
            ),
          ),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          }),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {
          '/create-screen': (ctx) => CreateScreen(),
          '/detail-screen': (ctx) => DetailScreen(),
          '/favorites-screen': (ctx) => FavoritesScreen(),
        },
      ),
    );
  }
}
