import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/trending.dart';
import 'package:practica2/src/network/api_movies.dart';
import 'package:practica2/src/views/card_trending.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  String _user = "";
  ApiMovies apiMovies;
  DatabaseHelper _database;

  @override
  void initState() {
    super.initState();
    userName();
    apiMovies = ApiMovies();
    _database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        backgroundColor: Configuration.colorMain,
      ),
      body: Container(
        color: Configuration.colorMain,
        child: FutureBuilder(
          future: favoritesMovies(),
          builder: (BuildContext context, AsyncSnapshot<List<Result>> snap) {
            return drawList(snap);
          },
        ),
      ),
    );
  }

  Widget drawList(snap) {
    if (snap.data == null)
      return Center(
          child: Text("No has seleccionado a favoritos",
              style: TextStyle(color: Colors.white)));

    if (snap.hasError) {
      return Center(
        child: Text("Hubo un error", style: TextStyle(color: Colors.white)),
      );
    } else if (snap.connectionState == ConnectionState.done) {
      return _listTrending(snap.data);
    } else
      return Center(child: CircularProgressIndicator());
  }

  Widget _listTrending(List<Result> data) {
    return ListView.builder(
        itemBuilder: (context, index) {
          Result movie = data[index];
          movie.id = movie.idmovie;
          return CardTrending(
            trending: movie,
          );
        },
        itemCount: data.length);
  }

  Future<List<Result>> favoritesMovies() async {
    List<Result> result = await _database.getMovies(_user);

    return result;
  }

  Future<void> userName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => _user = prefs.getString("username"));
  }
}
