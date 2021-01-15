import 'package:flutter/material.dart';
import 'package:practica2/src/models/trending.dart';
import 'package:practica2/src/models/video.dart';
import 'package:practica2/src/network/api_videos.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetail extends StatelessWidget {
  final Result movie;
  ApiVideo apiVideo;
  MovieDetail({this.movie});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTrailer(),
      builder: (BuildContext context, AsyncSnapshot<Video> snapshot) {
        return ListView(
          children: <Widget>[
            preparePlayer(key: snapshot.data != null ? snapshot.data.key : ""),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text(movie.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white)),
                  SizedBox(height: 30),
                  Text(movie.overview,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.white)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<Video> getTrailer() async {
    apiVideo = ApiVideo(movie: movie.id);

    Video video = await apiVideo.trailer();

    return video;
  }

  Widget preparePlayer({String key}) {
    if (key != "")
      return YoutubePlayer(
          controller: generateController(key: key),
          showVideoProgressIndicator: true);
    else
      return FadeInImage(
        placeholder: AssetImage("assets/image.jpg"),
        image: NetworkImage(
            "https://image.tmdb.org/t/p/w500/${movie.backdropPath}"),
      );
  }

  YoutubePlayerController generateController({String key}) {
    return YoutubePlayerController(
      initialVideoId: key,
      flags: YoutubePlayerFlags(
          autoPlay: false, mute: false, enableCaption: false),
    );
  }
}

/*Container(
      color: Colors.black.withOpacity(0.6),
      child: ListView(children: <Widget>[
        FadeInImage(
          placeholder: AssetImage("assets/activity_indicator.gif"),
          image: NetworkImage(
              "https://image.tmdb.org/t/p/w500/${movie.backdropPath}"),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(movie.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.white)),
              SizedBox(height: 30),
              Text(movie.overview,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.white)),
            ],
          ),
        ),
      ]),
    );*/
