import 'package:flutter/material.dart';

class MoodIcon extends StatelessWidget {
  final String? mood;

  MoodIcon(this.mood);

  @override
  Widget build(BuildContext context) {
    switch (mood) {
      case 'best':
        return Icon(
          Icons.mood,
          color: Theme.of(context).primaryColor,
          size: 50.0,
        );
      case 'good':
        return Icon(
          Icons.mood,
          color: Colors.blue,
          size: 50.0,
        );
      case 'normal':
        return Icon(
          Icons.sentiment_satisfied,
          color: Colors.grey[850],
          size: 50.0,
        );
      case 'bad':
        return Icon(
          Icons.mood_bad,
          color: Colors.yellow[900],
          size: 50.0,
        );
      case 'worst':
        return Icon(
          Icons.mood_bad,
          color: Theme.of(context).errorColor,
          size: 50.0,
        );
      default:
        return Icon(
          Icons.mood,
          color: Theme.of(context).primaryColor,
          size: 50.0,
        );
    }
  }
}
