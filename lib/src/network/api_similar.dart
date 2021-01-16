import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/models/trending.dart';

class ApiSimilar {
  String inicio = "https://api.themoviedb.org/3/movie/";
  int movie;
  String fin = "/similar?api_key=${Configuration.key}&language=en-US";
  Client http = Client();

  ApiSimilar({this.movie});
  Future<List<Result>> getSimilar() async {
    final url = "$inicio$movie$fin";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var movies = jsonDecode(response.body)['results'] as List;
      List<Result> listMovies =
          movies.map((movie) => Result.fromJSON(movie)).toList();
      return listMovies;
    } else {
      return null;
    }
  }
}
