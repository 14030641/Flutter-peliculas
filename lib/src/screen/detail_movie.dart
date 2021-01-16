import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/trending.dart';
import 'package:practica2/src/views/card_moviedetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailMovie extends StatefulWidget {
  final Result movie;
  final bool db;
  DetailMovie({Result movie, bool db})
      : this.movie = movie,
        this.db = db;

  @override
  _DetailMovieState createState() => _DetailMovieState(movie: movie, db: db);
}

class _DetailMovieState extends State<DetailMovie> {
  String _user = "";
  _DetailMovieState({this.movie, this.db});
  final Result movie;
  final bool db;
  IconData icon = Icons.favorite_outline;
  DatabaseHelper _databaseHelper;
  @override
  void initState() {
    super.initState();
    userName();
    _databaseHelper = DatabaseHelper();
  }

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

  changeMoviePreference() async {
    if (movie.user == null) {
      movie.user = _user;
      await _databaseHelper.insertar(movie.toFullJSON(), "tbl_favorites");
    } else {
      movie.user = null;
      await _databaseHelper.eliminarMovie(movie.id, "tbl_favorites", _user);
    }
    setState(() {
      icon = movie.user != null ? Icons.favorite : Icons.favorite_outline;
    });
  }

  Future<void> userName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => _user = prefs.getString("username"));

    if (db) {
      Result result = await _databaseHelper.getMovie(movie.id, _user);
      if (result != null)
        setState(() {
          movie.user = result.user;
          icon = movie.user != null ? Icons.favorite : Icons.favorite_outline;
        });
    }
  }
}
