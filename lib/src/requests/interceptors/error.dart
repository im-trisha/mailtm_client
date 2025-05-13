part of '../../requests.dart';

// TODO: Reject with custom error class????
class _ErrorInterceptor extends Interceptor {
  static const _errorMessages = {
    400: 'Invalid input',
    401: 'Invalid credentials.',
    404: 'Resource not found',
    422: 'Unprocessable Entity',
    429: 'Resource already exists',
  };

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final error = _errorMessages[response.statusCode];

    if (error == null) return handler.next(response);

    handler.reject(
      DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: error,
      ),
    );
  }
}
