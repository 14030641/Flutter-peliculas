import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/models/trending.dart';
import 'package:practica2/src/network/api_movies.dart';
import 'package:practica2/src/views/card_trending.dart';

class Trending extends StatefulWidget {
  const Trending({Key key}) : super(key: key);

  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  ApiMovies apiMovies;

  @override
  void initState() {
    super.initState();
    apiMovies = ApiMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Configuration.colorMain,
        title: Text('Trending Movies'),
      ),
      body: Container(
        color: Configuration.colorMain,
        child: FutureBuilder(
            future: apiMovies.getTrending(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Result>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                        'there was none good movie trending to show :c or an issue happend'));
              } else if (snapshot.connectionState == ConnectionState.done) {
                return _listTrending(snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget _listTrending(List<Result> movies) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Result trending = movies[index];
        return CardTrending(trending: trending);
      },
      itemCount: movies.length,
    );
  }
}
