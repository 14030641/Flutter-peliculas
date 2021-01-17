import 'package:flutter/material.dart';
import 'package:practica2/src/models/trending.dart';
import 'package:practica2/src/screen/detail_movie.dart';

class CardTrending extends StatelessWidget {
  const CardTrending({Key key, @required this.trending}) : super(key: key);

  final Result trending;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 5.0),
                  blurRadius: 1.0)
            ]),
        child: ClipRRect(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: FadeInImage(
                  placeholder: AssetImage('assets/activity_indicator.gif'),
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${trending.backdropPath}'),
                ),
              ),
              Opacity(
                opacity: 0.6,
                child: Container(
                    padding: EdgeInsets.all(10),
                    height: 55,
                    width: double.infinity,
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                            trending.title.substring(
                                0,
                                trending.title.length > 30
                                    ? 20
                                    : trending.title.length),
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0)),
                        FlatButton(
                            child:
                                Icon(Icons.chevron_right, color: Colors.white),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailMovie(movie: trending)));
                            })
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
