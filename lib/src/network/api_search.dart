import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/models/trending.dart';

class ApiSearch {
  String inicio =
      "https://api.themoviedb.org/3/search/movie?api_key=${Configuration.key}&language=en-US&query=";
  String query;
  String fin = "&page=1&include_adult=false";
  Client http = Client();

  ApiSearch({this.query});
  Future<List<Result>> getSearch() async {
    final url = "$inicio$query$fin";
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
