import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_thmdb_app/src/api/api.dart';

class DioInterceptors extends InterceptorsWrapper {
  @override
  onError(DioError error, handler) async {
    //enviar para sentry etc.
    return handler.next(error);
  }

  @override
  onRequest(RequestOptions options, handler) async {
    options.queryParameters.addAll({
      'api_key': dotenv.env['api_key'],
      'language': language,
      'include_adult': includeAdult
    });
    return handler.next(options);
  }
}
