import 'package:flutter/material.dart';

class MoodWidget extends StatelessWidget {
  final String? mood;
  final Function setMood;

  MoodWidget(this.mood, this.setMood);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: mood == 'worst'
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green[100],
                )
              : null,
          child: IconButton(
            icon: Icon(Icons.mood_bad),
            onPressed: () {
              setMood('worst');
            },
            color: Theme.of(context).errorColor,
          ),
        ),
        Container(
          decoration: mood == 'bad'
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green[100],
                )
              : null,
          child: IconButton(
            icon: Icon(Icons.mood_bad),
            onPressed: () {
              setMood('bad');
            },
            color: Colors.yellow[900],
          ),
        ),
        Container(
          decoration: mood == 'normal'
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green[100],
                )
              : null,
          child: IconButton(
            icon: Icon(Icons.sentiment_satisfied),
            onPressed: () {
              setMood('normal');
            },
            color: Colors.grey[850],
          ),
        ),
        Container(
          decoration: mood == 'good'
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green[100],
                )
              : null,
          child: IconButton(
            icon: Icon(Icons.mood),
            onPressed: () {
              setMood('good');
            },
            color: Colors.blue,
          ),
        ),
        Container(
          decoration: mood == 'best'
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green[100],
                )
              : null,
          child: IconButton(
            icon: Icon(Icons.mood),
            onPressed: () {
              setMood('best');
            },
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
