part of '../../requests.dart';

class _StatusAsResponse extends Interceptor {
  final List<int> goodStatusCodes = const [200, 204];

  const _StatusAsResponse();

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.requestOptions.headers.containsKey('StatusAsResponse')) {
      response.data = goodStatusCodes.contains(response.statusCode);
    }

    handler.next(response);
  }
}
