import 'package:flutter/material.dart';
import 'package:practica2/src/models/cast.dart';

class Character extends StatelessWidget {
  final CastElement character;
  Character({this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, top: 5, right: 20),
      child: Column(
        children: <Widget>[
          profileImage(),
          SizedBox(height: 15),
          Text(character.name,
              maxLines: 2,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.white)),
          SizedBox(height: 10),
          Text("${character.character}",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0)),
        ],
      ),
    );
  }

  Widget profileImage() {
    String profilePath =
        "https://image.tmdb.org/t/p/w92${character.profilePath}";
    return Container(
        width: 70.0,
        height: 70.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: character.profilePath != null
                  ? NetworkImage(profilePath)
                  : Image.network(
                      "https://villasmilindovillas.com/wp-content/uploads/2020/01/Profile.png",
                    ),
            )));
  }
}
