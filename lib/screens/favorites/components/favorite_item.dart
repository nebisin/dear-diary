import 'package:dear_dairy/models/paper.dart';
import 'package:dear_dairy/screens/detail/components/detail_mood.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FavoriteItem extends StatelessWidget {
  final Paper item;
  final int index;

  FavoriteItem(this.item, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/detail-screen',
          arguments: item.id,
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 70, top: 20, bottom: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.23),
                blurRadius: 15,
                offset: Offset(-10, 0),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: DetailMood(item.mood),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title!,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                  Text(
                    DateFormat.MMMMEEEEd().format(item.date!),
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
