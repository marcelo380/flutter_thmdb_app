import 'package:dio/dio.dart';
import 'package:flutter_thmdb_app/src/api/dio/dio_client.dart';
import 'package:flutter_thmdb_app/src/api/url.dart';

//configurações referente a api.
const String apiKey = 'e3db5bb0c72d2420dc98511d974049de';
const String language = 'pt-BR'; //ISO 639-1
const bool includeAdult = false;
const int connectTimeout = 15; //informar em segundos
const int receiveTimeout = 15; //informar em segundos

class Api {
  static CustomDio instanceDio;

  static CustomDio DioClient() {
    instanceDio ??= CustomDio(
      con: Dio(),
      baseUrl: Url.baseURL,
    );

    return instanceDio;
  }

  static Future fetchMovieInfo(int movieID) async =>
      await DioClient().con.get(Url.movie + "/$movieID");

  static Future fetchGenre() async => await DioClient().con.get(Url.genre);
  
  static Future fetchCredits(int movieID) async =>
      await DioClient().con.get(Url.getCreditsUrl(movieID));

  static Future fetchMovieList({String query, int page, int genre}) async {
    Response res;
    if ((query == null || query.isEmpty) && genre == null) {
      res = await DioClient()
          .con
          .get(Url.popularMovies, queryParameters: {'page': page});
    } else if (genre != null) {
      res = await DioClient()
          .con
          .get(Url.discoverMovie, queryParameters: {'with_genres': genre});
    } else {
      res = await DioClient().con.get(Url.search(query),
          queryParameters: {'query': query, 'page': page});
    }

    return res;
  }
}
