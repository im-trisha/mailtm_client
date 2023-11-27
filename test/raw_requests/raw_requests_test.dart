import 'package:test/test.dart';

import 'package:mailtm_client/src/utils.dart';
import 'package:mailtm_client/src/models.dart';
import 'package:mailtm_client/src/requests.dart';

void main() {
  late final HydraDomains domains;

  group('domains', () {
    test("Get domain's first page", () async {
      domains = await client.getDomains(1);
      expect(domains.domains.isNotEmpty, isTrue);
    });

    test('Get domains by id', () async {
      for (final domain in domains.domains) {
        final newDomain = await client.getDomain(domain.id);
        expect(newDomain.id, equals(domain.id));
      }
    });
  });

  group('accounts/token', () {
    late final String address, password;
    late final Account account;
    late final Token token;

    test('Create an account', () async {
      final domain = domains.domains.first.domain;
      address = '${randomString(16)}@$domain'.toLowerCase();
      password = randomString(16);

      account = await client.createAccount(address, password);
      expect(account.address, equals(address));
    });

    test("Get an account's JWT token", () async {
      token = await client.getToken(address, password);

      expect(token.id, equals(account.id));
    });

    test("Get an account from its token", () async {
      final fromToken = await client.me(token.token);

      expect(fromToken.address, equals(account.address));
    });

    test("Get an account from its id+token", () async {
      final fromId = await client.getAccount(account.id, token.token);

      expect(fromId.address, equals(account.address));
    });

    test("Delete an account", () async {
      final deleted = await client.deleteAccount(account.id, token.token);

      expect(deleted, isTrue);
    });
  });
}
