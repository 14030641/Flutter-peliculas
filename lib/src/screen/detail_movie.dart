import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/models/trending.dart';
import 'package:practica2/src/views/card_moviedetail.dart';

class DetailMovie extends StatefulWidget {
  final Result movie;
  DetailMovie({Result movie}) : this.movie = movie;

  @override
  _DetailMovieState createState() => _DetailMovieState(movie: movie);
}

class _DetailMovieState extends State<DetailMovie> {
  _DetailMovieState({this.movie});
  final Result movie;
  IconData icon = Icons.favorite_outline;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Configuration.colorMain,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            MaterialButton(
                child: Icon(icon, color: Colors.red[300]),
                onPressed: () => changeMoviePreference())
          ],
        ),
        body: Container(
            constraints: BoxConstraints.expand(),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 22),
                child: MovieDetail(movie: widget.movie),
              ),
            )));
  }

  changeMoviePreference() {
    movie.favorite = !movie.favorite;

    setState(() {
      icon = movie.favorite ? Icons.favorite : Icons.favorite_outline;
    });
  }
}
