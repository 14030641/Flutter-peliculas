class Cast {
  int id;
  List<CastElement> cast;
  List<CastElement> crew;

  Cast({
    this.id,
    this.cast,
    this.crew,
  });
}

class CastElement {
  int id;
  int castId;
  String name;
  String profilePath;
  String character;
  String creditId;

  CastElement({
    this.id,
    this.name,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
  });

  factory CastElement.fromJSON(Map<String, dynamic> cast) {
    return CastElement(
        id: cast["id"],
        castId: cast["cast_id"],
        name: cast["name"],
        profilePath: cast["profile_path"],
        character: cast["character"],
        creditId: cast["credit_id"]);
  }
}
