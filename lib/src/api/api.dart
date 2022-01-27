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

  static Future fetchMovieList({String query, int page}) async {
    Response res;
    if (query == null || query.isEmpty) {
      res = await DioClient().con.get(Url.popularMovies);
    } else {
      res = await DioClient()
          .con
          .get(Url.search(query), queryParameters: {'query': query});
    }

    return res;
  }

  static Future fetchMovieInfo(int movieID) async =>
      await DioClient().con.get(Url.movie + "/$movieID");

  static Future fetchGenre() async => await DioClient().con.get(Url.genre);
}
