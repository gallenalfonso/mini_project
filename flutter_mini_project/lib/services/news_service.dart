import 'package:dio/dio.dart';


  final Dio _dio = Dio();

  api(String url, {String? method, String? data}) async {
    final response = await _dio.request(
      url,
      data: data,
      options: Options(method: method),
    );
    return response;
  }

