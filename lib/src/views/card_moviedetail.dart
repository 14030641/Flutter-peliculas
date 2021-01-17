import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/models/cast.dart';
import 'package:practica2/src/models/movieComp.dart';
import 'package:practica2/src/models/trending.dart';
import 'package:practica2/src/models/video.dart';
import 'package:practica2/src/network/api_cast.dart';
import 'package:practica2/src/network/api_similar.dart';
import 'package:practica2/src/network/api_videos.dart';
import 'package:practica2/src/views/card_actor.dart';
import 'package:practica2/src/views/card_similar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieDetail extends StatelessWidget {
  final Result movie;
  ApiVideo apiVideo;
  ApiCast apiCast;
  ApiSimilar apiSimilar;
  MovieDetail({this.movie});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: prepareData(),
      builder: (BuildContext context, AsyncSnapshot<CompMovie> snapshot) {
        return ListView(
          children: <Widget>[
            preparePlayer(
                key: snapshot.data != null ? snapshot.data.video.key : ""),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text(movie.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white)),
                  SizedBox(height: 10),
                  Container(
                      child: Row(
                    children: [
                      Text(movie.voteAverage.toString(),
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.white)),
                      SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {},
                          starCount: 5,
                          rating: (movie.voteAverage * 5 / 10),
                          size: 20.0,
                          isReadOnly: true,
                          color: Configuration.colorItems,
                          borderColor: Configuration.colorItems,
                          spacing: 0.0),
                    ],
                  )),
                  SizedBox(height: 10),
                  Container(
                      child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Text(
                          "Reseña",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0),
                        ),
                      ),
                    ],
                  )),
                  SizedBox(height: 5),
                  Text(movie.overview,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white)),
                  Container(
                      child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Text(
                          "Actores principales",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0),
                        ),
                      ),
                    ],
                  )),
                  SizedBox(height: 5),
                  drawList(snapshot.data),
                  Container(
                      child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Peliculas Similares",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0),
                        ),
                      ),
                    ],
                  )),
                  SizedBox(height: 5),
                  drawSimilar(snapshot.data),
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

  Future<List<CastElement>> getCast() async {
    apiCast = ApiCast(movie: movie.id);

    List<CastElement> cast = await apiCast.cast();

    return cast;
  }

  Future<List<Result>> getSimilar() async {
    apiSimilar = ApiSimilar(movie: movie.id);
    List<Result> result = await apiSimilar.getSimilar();

    return result;
  }

  Future<CompMovie> prepareData() async {
    Video _video = await getTrailer();
    List<CastElement> _cast = await getCast();
    List<Result> _similar = await getSimilar();

    CompMovie result =
        CompMovie(video: _video, cast: _cast.cast(), similar: _similar);
    return result;
  }

  Widget drawList(CompMovie snap) {
    if (snap != null) {
      return _listCast(snap.cast.cast());
    } else
      return CircularProgressIndicator();
  }

  Widget _listCast(List<CastElement> data) {
    return Container(
      height: 170.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            CastElement character = data[index];
            return Character(character: character);
          },
          itemCount: data.length),
    );
  }

  Widget drawSimilar(CompMovie snap) {
    if (snap != null) {
      return _listSimilar(snap.similar);
    } else
      return CircularProgressIndicator();
  }

  Widget _listSimilar(List<Result> data) {
    return Container(
      height: 200.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Result _similar = data[index];
            return CardSimilar(similar: _similar);
          },
          itemCount: data.length),
    );
  }

  Widget preparePlayer({String key}) {
    if (key != "")
      return YoutubePlayer(
          controller: generateController(key: key),
          showVideoProgressIndicator: true);
    else
      return FadeInImage(
        placeholder: AssetImage("assets/activity_indicator"),
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
