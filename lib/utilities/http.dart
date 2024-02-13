import 'package:dio/dio.dart';
import 'package:maya_by_myai_robotics/utilities/constants.dart';

class Http {
  late Dio _dio;

  Http() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(minutes: 1),
    ));
    initializeInterceptors();
  }

  Future<Response> get(String path) async {
    Response response;
    try {
      response = await _dio.get(baseUrl + path);
      return response;
    } on DioException catch (e) {
      print(e.error);
      throw Exception(e.message);
    }
  }

  Future<Response> post(String path, data) async {
    try {
      print(data);
      final response = await _dio.post(
        baseUrl + path,
        data: data,
        options: Options(
            contentType: Headers.formUrlEncodedContentType), // Add this line
      );
      return response;
    } catch (e) {
      throw DioException(requestOptions: RequestOptions(path: path), error: e);
    }
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        print("Error: ${error.message}");
      },
      onRequest: (options, handler) {
        print("${options.method} ${options.path} - ${options.data}");
      },
      onResponse: (response, handler) {
        print("Response: ${response.data}");
      },
    ));
  }
}
