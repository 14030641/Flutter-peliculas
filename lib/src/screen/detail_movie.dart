import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';

class DetailMovie extends StatelessWidget {
  const DetailMovie({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']),
        backgroundColor: Configuration.colorApp,
      ),
      body: Text(movie['overview']),
    );
  }
}
