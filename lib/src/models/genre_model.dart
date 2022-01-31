
import 'dart:convert';

class GenreModel {
  GenreModel({
    this.genres,
  });

  List<Genre> genres;

  factory GenreModel.fromJson(String str) =>
      GenreModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GenreModel.fromMap(Map<String, dynamic> json) => GenreModel(
        genres: json["genres"] == null
            ? null
            : List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "genres": genres == null
            ? null
            : List<dynamic>.from(genres.map((x) => x.toMap())),
      };
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(String str) => Genre.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}