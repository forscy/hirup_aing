import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hirup_aing/config/api/api_config.dart';

class DioClient {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _initializeDio();
  }

  Dio get dio => _dio;

  void _initializeDio() {
    // Base options
    _dio.options = BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    );

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add token to request if available
          final token = await _secureStorage.read(key: 'auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            // Token expired, try to refresh
            try {
              final refreshToken = await _secureStorage.read(
                key: 'refresh_token',
              );
              if (refreshToken != null) {
                final response = await _dio.post(
                  ApiConfig.refreshToken,
                  data: {'refreshToken': refreshToken},
                );

                if (response.statusCode == 200) {
                  final newToken = response.data['data']['token'];
                  await _secureStorage.write(
                    key: 'auth_token',
                    value: newToken,
                  );

                  // Retry original request with new token
                  final opts = Options(
                    method: error.requestOptions.method,
                    headers: {
                      ...error.requestOptions.headers,
                      'Authorization': 'Bearer $newToken',
                    },
                  );

                  final clonedRequest = await _dio.request(
                    error.requestOptions.path,
                    options: opts,
                    data: error.requestOptions.data,
                    queryParameters: error.requestOptions.queryParameters,
                  );

                  return handler.resolve(clonedRequest);
                }
              }
            } catch (e) {
              if (kDebugMode) {
                print('Error refreshing token: $e');
              }
            }
          }
          return handler.next(error);
        },
      ),
    );

    // Add logging interceptor in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }
}
