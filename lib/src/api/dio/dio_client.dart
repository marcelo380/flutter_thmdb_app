import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_thmdb_app/src/api/dio/dio_interceptors.dart';

class CustomDio {
  final Dio con;
  final String baseUrl;
  final int connectTimeout;
  final int receiveTimeout;

  /// v1 v2 v3...
  CustomDio({
    @required this.con,
    @required this.baseUrl,
    @required this.connectTimeout,
    @required this.receiveTimeout,
  }) {
    con.options = BaseOptions(baseUrl: '');
    con.interceptors.add(DioInterceptors());
  }
}
