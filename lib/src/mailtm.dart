import 'dart:async';

import 'utils.dart';
import 'models.dart';
import 'requests.dart';

/// An helper class that will handle every mailtm API request.
///
/// Prefer using this over raw requests using [MailTmService], which is completely unadvertised.
class MailTm {
  MailTm._();
  static final List<Domain> _domains = [];

  static var _auths = <String, AuthenticatedUser>{};

  /// Adds an user to the authenticated users map
  static void addUser(String id, AuthenticatedUser? user) {
    if (user == null) {
      _auths.remove(id);
    } else {
      _auths[id] = user;
    }
  }

  /// Gets a cached user.
  static AuthenticatedUser? getUser(String id) => _auths[id];

  /// Dumps cached users.
  static Map<String, AuthenticatedUser> dumpUsers() => _auths;

  /// Loads cached users.
  static void loadUsers(Map<String, Map<String, Object?>> users) =>
      _auths = users.map(
        (k, v) => MapEntry(k, AuthenticatedUser.fromJson(v)),
      );

  /// Caches and gets every domain that the API provides
  static FutureOr<List<Domain>> domains() async {
    if (_domains.isNotEmpty) return _domains;

    var totalPages = 1, page = 1;
    do {
      final res = await client.getDomains(page);
      _domains.addAll(res.domains);
      totalPages = (res.totalItems / HydraDomains.hydraMax).ceil();
    } while (totalPages > page++);

    return _domains;
  }

  /// Registers an account using a certain [username], [domain] and [password].
  ///
  /// The username+domain corresponds to [username]@[domain].
  /// If [domain] is not provided, the first one received from the mailtm API is used
  /// If [username] and [password] aren't provided, they are generated using a Random.secure generator
  /// And their length will be [randomCharsLength]
  static Future<AuthenticatedUser> register({
    String? username,
    String? password,
    Domain? domain,
    int randomCharsLength = 16,
  }) async {
    username = username == null || username.isEmpty
        ? randomString(randomCharsLength)
        : username;

    password = password == null || password.isEmpty
        ? randomString(randomCharsLength)
        : password;

    domain ??= (await domains()).first;

    final address = '$username@${domain.domain}'.toLowerCase();
    final account = await client.createAccount(address, password);
    final token = (await client.getToken(address, password)).token;

    final user = AuthenticatedUser(
      account: account,
      password: password,
      token: token,
    );

    addUser(user.account.id, user);

    return user;
  }

  /// Logins to an account using either [id] or [address] and [password]
  static Future<AuthenticatedUser?> login({
    String? id,
    String? address,
    String? password,
  }) async {
    assert(
      ((address != null && password != null) && id == null) ||
          ((address == null && password == null) && id != null),
      "Only one of id and address+password must be provided.",
    );

    if (id != null) return getUser(id);

    final token = (await client.getToken(address!.toLowerCase(), password!));
    final user = AuthenticatedUser(
      account: await client.getAccount(token.id, token.token),
      password: password,
      token: token.token,
    );

    addUser(user.account.id, user);

    return user;
  }
}
