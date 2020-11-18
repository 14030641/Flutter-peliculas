import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:practica2/src/models/trending.dart';

class ApiMovies {
  final String urlTrending =
      "https://api.themoviedb.org/3/movie/popular?api_key=<>&language=es-MX&page=1"; //insertar la llave reemplazando el "<>"
  Client http = Client();

  Future<List<Result>> getTrending() async {
    final response = await http.get(urlTrending);
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
