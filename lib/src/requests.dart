import 'models.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:retrofit/retrofit.dart';

part 'requests.g.dart';

// Requests
part 'requests/mailtm_rest_client.dart';
part 'requests/interceptors/error.dart';
part 'requests/interceptors/bearerizer.dart';
part 'requests/interceptors/status_as_respose.dart';

/// The client that can be used
final client = MailTmService._(_buildDioClient());
