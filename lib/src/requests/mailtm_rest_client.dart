part of '../requests.dart';

Dio _buildDioClient() {
  final client = Dio()
    ..options.contentType = 'application/ld+json'
    ..interceptors.add(_ErrorInterceptor())
    ..interceptors.add(_StatusAsResponse())
    ..interceptors.add(_BearerTokenInterceptor())
    ..options.validateStatus = (int? status) => (status ?? 400) < 500;

  client.interceptors.add(
    RetryInterceptor(dio: client, retryableExtraStatuses: {0}),
  );

  return client;
}

@RestApi(baseUrl: 'https://api.mail.tm')

/// The mailtm rest api client.
abstract class MailTmService {
  // ignore: unused_element
  factory MailTmService._(Dio dio, {String baseUrl}) = _MailTmService;

  /// Gets a domains list from its page
  @GET('/domains')
  Future<HydraDomains> getDomains(
    @Query('page') int page,
  );

  /// Gets domain from its id
  @GET('/domains/{id}')
  Future<Domain> getDomain(
    @Path() String id,
  );

  /// Get a JWT authentication token
  @POST('/token')
  Future<Token> getToken(
    @Field() String address,
    @Field() String password,
  );

  /// Creates an account
  @POST('/accounts')
  Future<Account> createAccount(
    @Field() String address,
    @Field() String password,
  );

  /// Gets an account from its id
  @GET('/accounts/{id}')
  Future<Account> getAccount(
    @Path() String id,
    @Header('Authorization') String token,
  );

  /// Deletes account from its id
  @DELETE('/accounts/{id}')
  @Headers({'StatusAsResponse': true})
  Future<bool> deleteAccount(
    @Path('id') String id,
    @Header('Authorization') String token,
  );

  /// Gets an account while being authenticated
  @GET('/me')
  Future<Account> me(
    @Header('Authorization') String token,
  );

  /// Gets a messages list from its page
  @GET('/messages')
  Future<HydraMessages> getMessages(
    @Query('page') int page,
    @Header('Authorization') String token,
  );

  /// Gets a message from its id
  @GET('/messages/{id}')
  Future<Message> getMessage(
    @Path() String id,
    @Header('Authorization') String token,
  );

  /// Downloads the attachment
  @GET('/{downloadUrl}')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> downloadAttachment(
    @Path() String downloadUrl,
    @Header('Authorization') String token,
  );

  /// Deletes a message from its id
  @DELETE('/messages/{id}')
  @Headers({'StatusAsResponse': true})
  Future<bool> deleteMessage(
    @Path() String id,
    @Header('Authorization') String token,
  );

  /// Marks a message as read
  @PATCH('/messages/{id}')
  @Headers({
    'StatusAsResponse': true,
    'Content-Type': 'application/merge-patch+json'
  })
  Future<bool> readMessage(
    @Path() String id,
    @Field() bool seen,
    @Header('Authorization') String token,
  );

  /// Gets a message's source
  @GET('/sources/{id}')
  Future<MessageSource> getMessageSource(
    @Path() String id,
    @Header('Authorization') String token,
  );
}
