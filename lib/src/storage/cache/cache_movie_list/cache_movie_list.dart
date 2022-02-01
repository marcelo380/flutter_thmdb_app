import 'package:flutter_thmdb_app/src/models/movie_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String keyMovieListSharedPrefs = 'movie_list';

class CacheMovieList {
  static Future insertMovieList(List<ResultMovie> movieList) async {
    List<String> objects = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> listSP = prefs.getStringList(keyMovieListSharedPrefs);

    if (listSP == null || listSP.isEmpty) {
      //ta em branco insere direto
      movieList.forEach((element) {
        objects.add(element.toJson());
      });
      await prefs.setStringList(keyMovieListSharedPrefs, objects);
    } else {
      List<ResultMovie> resultMovieQuery = [];

      //adiciona filmes na listagem para verificação
      listSP.forEach((element) {
        resultMovieQuery.add(ResultMovie.fromJson(element));
      });
      //

      for (var i = 0; i < movieList.length; i++) {
        //verifica se filme ja existe na lista
        bool _existMovie = resultMovieQuery
            .where((element) => element.id == movieList[i].id)
            .toList()
            .isNotEmpty;

        if (!_existMovie) {
          listSP.add(movieList[i].toJson());
        } else {
          //print("o filme ${movieList[i].title} ja foi cadastrado");
        }
      }
      objects.addAll(listSP);
      await prefs.setStringList(keyMovieListSharedPrefs, objects);
    }
  }

  static Future<List<ResultMovie>> readMovieList() async {
    List<String> objects = [];
    List<ResultMovie> resultMovieList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List list = prefs.getStringList(keyMovieListSharedPrefs);

    if (list == null) {
      return [];
    } else {
      list.forEach((element) {
        resultMovieList.add(ResultMovie.fromJson(element));
      });
      return resultMovieList;
    }
  }
}
