import 'package:test/test.dart';

import 'package:mailtm_client/mailtm_client.dart';

void main() {
  late final List<Domain> domains;

  group('domains', () {
    test("Get domains", () async {
      domains = await MailTm.domains();
      expect(domains, isNotEmpty);
    });
  });

  group('user', () {
    late final AuthenticatedUser user;
    test('Create an user', () async {
      user = await MailTm.register();
    });

    test('login/id', () async {
      final fetched = await MailTm.login(id: user.account.id);
      expect(fetched, isNotNull);
      expect(fetched!.account.id, equals(user.account.id));
    });

    test('login/address+password', () async {
      final fetched = await MailTm.login(
        address: user.account.address,
        password: user.password,
      );
      expect(fetched, isNotNull);
      expect(fetched!.account.id, equals(user.account.id));
    });

    test('getUser/not-null', () async {
      final fetched = MailTm.getUser(user.account.id);
      expect(fetched, isNotNull);
      expect(fetched!.account.id, equals(user.account.id));
    });

    test('getUser/null', () async {
      final fetched = MailTm.getUser('Hi');
      expect(fetched, isNull);
    });

    test('user/messagesStream', () async {
      final messages = user.messages();
      final usedQuota = user.account.used;

      print('Send a message on ${user.account.address}.');
      final msg = await messages.first;

      expect(msg.seen, isFalse);
      expect(msg.intro.toLowerCase(), equals('test'));
      expect(msg.subject.toLowerCase(), equals('test'));
      await expectLater(user.messageSource(msg.id), completes);
      expect(await user.readMessage(msg.id), isTrue);

      final newMsg = await user.messageFrom(msg.id);

      expect(newMsg.seen, isTrue);
      if (newMsg.attachments.isNotEmpty) {
        final attachment = newMsg.attachments.first;
        final bytes = await user.downloadAttachment(attachment.downloadUrl);
        expect(bytes, isNotEmpty);
      }

      await user.update();
      expect(user.account.used, greaterThan(usedQuota));

      expect(await user.deleteMessage(msg.id), isTrue);
    }, timeout: Timeout.factor(3));

    test("Deleting account...", () async {
      expect(await user.delete(), isTrue);
    });
  });
}
