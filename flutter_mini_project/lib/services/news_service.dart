import 'package:dio/dio.dart';
import 'package:flutter_mini_project/models/top_news_models.dart';

final Dio _dio = Dio();

class ApiService {
  Future getApi(String url, {String? method, String? data}) async {
    try {
      final Response response = await _dio.request(
        url,
        data: data,
        options: Options(method: method),
      );
      
      return response;

    } on DioException catch (e) {
      print('Dio Error: $e');
      rethrow;
    }
  }
}

// api(String url, {String? method, String? data}) async {
//   final response = await _dio.request(
//     url,
//     data: data,
//     options: Options(method: method),
//   );
//   return response;
// }
