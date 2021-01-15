import 'dart:convert';

import 'package:http/http.dart';
import 'package:practica2/src/models/video.dart';

class ApiVideo {
  String inicio = "https://api.themoviedb.org/3/movie/";
  int movie;
  String fin =
      "/videos?api_key=66f7b29c77934465145a14bcce50a967&language=en-US";
  Client http = Client();

  ApiVideo({this.movie});

  Future<Video> trailer() async {
    final url = "$inicio$movie$fin";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["results"] as List;
      List<Video> movies = data.map((movie) => Video.fromJSON(movie)).toList();
      return movies.last;
    } else
      return null;
  }
}
