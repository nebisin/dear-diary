import 'package:dear_dairy/models/paper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'detail_mood.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Paper item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 50, top: 30, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.23),
            blurRadius: 15,
            offset: Offset(10, 0),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DetailMood(item.mood),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                  Text(
                    DateFormat.MMMMEEEEd().format(item.date),
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
