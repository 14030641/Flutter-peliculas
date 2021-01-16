import 'dart:convert';

import "package:http/http.dart" show Client;
import 'package:practica2/src/assets/configuration.dart';
import "package:practica2/src/models/cast.dart";

class ApiCast {
  String inicio = "https://api.themoviedb.org/3/movie/";
  int movie;
  String fin = "/credits?api_key=${Configuration.key}&language=en-US";
  Client http = Client();

  ApiCast({this.movie});

  Future<List<CastElement>> cast() async {
    final url = "$inicio$movie$fin";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["cast"] as List;
      List<CastElement> cast =
          data.map((movie) => CastElement.fromJSON(movie)).toList();
      return cast;
    } else
      return null;
  }
}
