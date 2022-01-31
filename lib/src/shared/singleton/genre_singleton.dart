import 'package:flutter_thmdb_app/src/api/api.dart';
import 'package:flutter_thmdb_app/src/models/genre_model.dart';


class GenreSingleton {
  static GenreSingleton _instance;

  factory GenreSingleton({GenreModel gModel}) {
    if (_instance == null) {
      _instance = GenreSingleton._internalConstructor(gModel);
    } else {
      if (gModel != null) _instance.genreModel = gModel;
    }

    return _instance;
  }

  GenreSingleton._internalConstructor(this.genreModel);
  GenreModel genreModel;

  Future init() async {
    GenreSingleton().clear();

    await Api.fetchGenre().then((value) async {
      GenreModel genreModel = GenreModel.fromMap(value.data);

      GenreSingleton(gModel: genreModel);
    });
  }

  clear() {
    GenreSingleton._instance = null;
  }
}