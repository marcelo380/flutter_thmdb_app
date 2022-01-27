import 'package:dio/dio.dart';
import 'package:flutter_thmdb_app/src/api/api.dart';

class DioInterceptors extends InterceptorsWrapper {
  @override
  onError(DioError error, handler) async {
    //enviar para sentry etc.
    print("error : $error");
    print("error : ${error.message}");
    print("response : ${error.response}");
    return handler.next(error);
  }

  @override
  onRequest(RequestOptions options, handler) async {
    options.queryParameters.addAll({
      'api_key': apiKey,
      'language': language,
      'include_adult': includeAdult
    });
    return handler.next(options);
  }
}
