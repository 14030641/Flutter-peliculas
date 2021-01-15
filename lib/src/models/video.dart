class Videos {
  int id;
  List<Video> results;

  Videos({
    this.id,
    this.results,
  });
}

class Video {
  String id;
  String key;
  String site;

  Video({
    this.id,
    this.key,
    this.site,
  });

  factory Video.fromJSON(Map<String, dynamic> movie) {
    return Video(id: movie["id"], key: movie["key"], site: movie["site"]);
  }
}
