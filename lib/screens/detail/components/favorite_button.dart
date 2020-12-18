import 'package:dear_dairy/models/paper.dart';
import 'package:dear_dairy/provider/papers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
