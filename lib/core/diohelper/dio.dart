import 'package:dio/dio.dart';

import '../cacheHelper/cacheHelper.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(baseUrl: 'https://codingarabic.online/api', headers: {
      'Accept': 'application/json',
    }));
  }

  static Future<Response> postData({
    final String? endPoint,
    Map<String, dynamic>? data,
  }) async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer${CacheHelper.getData(key: 'token')}'
    };
    return await dio!.post(
      endPoint!,
      data: data,
    );
  }

  static Future<Response> getData({required String endPoint}) async {
    return await dio!.get(endPoint,
        options: Options(headers: {
          'Authorization':
              'Bearer${CacheHelper.getData(key: 'token')}'
        }));
  }
}
