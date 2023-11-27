part of '../../requests.dart';

class _BearerTokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.headers.containsKey('Authorization')) {
      final token = options.headers['Authorization'].toString();
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
