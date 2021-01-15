import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/models/trending.dart';
import 'package:practica2/src/views/card_moviedetail.dart';

class DetailMovie extends StatelessWidget {
  final Result movie;
  DetailMovie({this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
          backgroundColor: Configuration.colorApp,
        ),
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://image.tmdb.org/t/p/w500/${movie.backdropPath}"),
                    fit: BoxFit.cover)),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 22),
                child: MovieDetail(movie: movie),
              ),
            )));
  }
}
