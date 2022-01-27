import 'package:dio/dio.dart';

class DioInterceptors extends InterceptorsWrapper {
  @override
  onError(DioError error, handler) async {
    //enviar para sentry etc.

    //pode ser usado para motrar para o usuario ou tratar as menssagens,
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
