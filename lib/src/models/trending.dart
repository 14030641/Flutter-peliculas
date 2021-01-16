class Trending {
  int page;
  int totalResults;
  int totalPages;
  List<Result> results;

  Trending({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });
}

class Result {
  String posterPath;
  int id;
  String backdropPath;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;
  String user;
  int idmovie;

  factory Result.fromJSON(Map<String, dynamic> map) {
    return Result(
        posterPath: map['poster_path'],
        id: map['id'],
        backdropPath: map['backdrop_path'],
        title: map['title'],
        voteAverage: map['vote_average'] is int
            ? (map['vote_average'] as int).toDouble()
            : map['vote_average'],
        overview: map['overview'],
        releaseDate: map['release_date']);
  }
  Result({
    this.posterPath,
    this.id,
    this.backdropPath,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  factory Result.fromJSONWithFavorite(Map<String, dynamic> movie) {
    Result result = Result(
        posterPath: movie["poster_path"],
        id: movie["id"],
        backdropPath: movie["backdrop_path"],
        title: movie["title"],
        voteAverage: movie["vote_average"] is int
            ? (movie["vote_average"] as int).toDouble()
            : movie["vote_average"],
        overview: movie["overview"],
        releaseDate: movie["release_date"]);
    result.user = movie["user"];
    result.idmovie = movie["idmovie"];
    return result;
  }

  Map<String, dynamic> toFullJSON() {
    return {
      "poster_path": posterPath,
      "idmovie": id,
      "backdrop_path": backdropPath,
      "title": title,
      "vote_average": voteAverage,
      "release_date": releaseDate,
      "overview": overview,
      "user": user,
    };
  }
}

enum OriginalLanguage { FR, EN, KO, JA }
