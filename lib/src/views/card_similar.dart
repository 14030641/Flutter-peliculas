import 'package:flutter/material.dart';
import 'package:practica2/src/models/trending.dart';

class CardSimilar extends StatelessWidget {
  const CardSimilar({Key key, @required this.similar}) : super(key: key);

  final Result similar;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ClipRRect(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            width: 150,
            height: 200,
            child: FadeInImage(
              placeholder: AssetImage('assets/activity_indicator.gif'),
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${similar.posterPath}'),
            ),
          ),
        ],
      ),
    ));
  }
}
