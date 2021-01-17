import 'package:flutter/material.dart';
import 'package:practica2/src/screen/dashboard.dart';
import 'package:practica2/src/screen/detail_movie.dart';
import 'package:practica2/src/screen/favorites.dart';
import 'package:practica2/src/screen/login.dart';
import 'package:practica2/src/screen/profile.dart';
import 'package:practica2/src/screen/search.dart';
import 'package:practica2/src/screen/trending.dart';
import 'package:practica2/src/screen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Widget inicio = Container();

  @override
  void initState() {
    super.initState();

    _getToken();
  }

  Future _getToken() async {
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token");
    setState(() {
      inicio = token != null ? Dashboard() : Login();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (BuildContext context) => Login(),
        '/trending': (BuildContext context) => Trending(),
        '/search': (BuildContext context) => Search(),
        '/favorites': (BuildContext context) => Favorites(),
        '/profile': (BuildContext context) => Profile(),
        '/dashboard': (BuildContext context) => Dashboard(),
        '/detail': (BuildContext context) => DetailMovie()
      },
      home: Splashscreen(),
    );
  }
}
