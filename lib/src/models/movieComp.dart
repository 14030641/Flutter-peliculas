import 'package:practica2/src/models/Cast.dart';
import 'package:practica2/src/models/trending.dart';
import 'package:practica2/src/models/video.dart';

class CompMovie {
  Video video;
  List<CastElement> cast;
  List<Result> similar;

  CompMovie({this.video, this.cast, this.similar});
}
