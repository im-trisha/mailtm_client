part of '../../models.dart';

/// A class that represents an authenticated user
///
/// This class contains an user's account, its password and its access token
@unfreezed
class AuthenticatedUser with _$AuthenticatedUser {
  AuthenticatedUser._();

  /// Constructor for [AuthenticatedUser]. `MUST NOT` be used manually
  /// Use [MailTm] and [AuthorizedUser]
  factory AuthenticatedUser({
    required Account account,
    required String password,
    required String token,
  }) = _AuthenticatedUser;

  /// [AuthenticatedUser] jsonizer. Allows freezed to add a from/toJson
  factory AuthenticatedUser.fromJson(Map<String, Object?> json) =>
      _$AuthenticatedUserFromJson(json);

  /// Gets a message from its id
  Future<Message> messageFrom(String id) => client.getMessage(id, token);

  /// Marks a message as read from its id
  Future<bool> readMessage(String id) => client.readMessage(id, true, token);

  /// Marks a message as unread from its id
  Future<bool> unreadMessage(String id) => client.readMessage(id, false, token);

  /// Deletes a message from its id
  Future<bool> deleteMessage(String id) => client.deleteMessage(id, token);

  /// Gets a message's source
  Future<MessageSource> messageSource(String id) =>
      client.getMessageSource(id, token);

  /// Downloads an attachment
  Future<List<int>> downloadAttachment(String downloadUrl) =>
      client.downloadAttachment(downloadUrl, token);

  /// Updates this [AuthenticatedUser]'s account.
  Future<void> update() async =>
      account = await client.getAccount(account.id, token);

  /// Deletes the account.
  ///
  /// BE CAREFUL! This action is definitive.
  Future<bool> delete() {
    MailTm.addUser(account.id, null);
    return client.deleteAccount(account.id, token);
  }

  /// Gets a message at a given page.
  /// [HydraMessages.hydraMax] messages per page.
  Future<List<Message>> messagesAt(int page) async {
    final messages = await client.getMessages(page, token);
    return messages.messages;
  }

  /// Gets every message as a stream.
  Stream<List<Message>> allMessages() async* {
    var totalPages = 1, page = 1;

    do {
      final res = await client.getMessages(page, token);
      yield res.messages;
      totalPages = (res.totalItems / HydraMessages.hydraMax).ceil();
    } while (totalPages > page++);
  }

  /// A stream to listen to this account's messages.
  ///
  /// Uses [Mercure] under the hood.
  /// NOTE: It seems that, messages that were listened to using this
  /// stream, don't have a proper [attachment] property. So, to know (And get)
  /// Attachments, you should:
  /// check if msg.hasAttachment is true, and if so, use user.messageFrom(msg.id)
  /// and get the attachments from there
  Stream<Message> messages() {
    late StreamController<Message> controller;
    final mercure = Mercure(
      url: 'https://mercure.mail.tm/.well-known/mercure',
      topics: ["/accounts/${account.id}"],
      token: token,
    );
    bool isPaused = false;

    void tick() async {
      var subscription = mercure.listen((event) async {
        // TODO: The stream should technically buffer those? Is this the stream's work or dart's stream controller's work?
        if (controller.isClosed || isPaused) return;

        final encodedData = jsonDecode(event.data) as Map<String, Object?>;
        if (encodedData['@type'] == 'Account') {
          account = Account.fromJson(encodedData);
          return;
        }
        controller.add(Message.fromJson(encodedData));
      });

      Timer.periodic(Duration(seconds: 3), (timer) async {
        if (controller.isClosed) {
          timer.cancel();
          await subscription.cancel();
        }
      });
    }

    void listen() => isPaused = false;
    void pause() => isPaused = true;

    Future<void> cancel() async {
      isPaused = true;
      await controller.close();
    }

    controller = StreamController<Message>(
      onListen: listen,
      onPause: pause,
      onResume: listen,
      onCancel: cancel,
    );

    tick();
    return controller.stream;
  }
}
