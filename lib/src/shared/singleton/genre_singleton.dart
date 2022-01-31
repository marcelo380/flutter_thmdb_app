import 'package:flutter_thmdb_app/src/api/api.dart';
import 'package:flutter_thmdb_app/src/models/genre_model.dart';
import 'package:flutter_thmdb_app/src/shared/consts.dart';
import 'package:flutter_thmdb_app/src/shared/utils/connectivity/connectivity.dart';

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

    if (await CheckConnectivity.hasConection()) {
      await Api.fetchGenre().then((value) async {
        genreModel = GenreModel.fromMap(value.data);

        GenreSingleton(gModel: genreModel);
      });
    } else {
      //para atualizar via request basta utilizar a forma que foi feito o cache de listagem de filmes
      //foi declaro como constantes so para demonstrar
      List<Genre> genres = [];
      generosOfline.forEach((element) {
        genres.add(Genre.fromMap(element));
      });
      genreModel = GenreModel(genres: genres);

      GenreSingleton(gModel: genreModel);
    }
  }

  clear() {
    GenreSingleton._instance = null;
  }
}
