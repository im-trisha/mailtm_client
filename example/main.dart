import 'package:mailtm_client/mailtm_client.dart';

void main() async {
  final user = await MailTm.register();
  print('Send a message to ${user.account.address}');

  /// user.messages() can also be listened to!
  final message = await user.messages().first;
  final messages = await user.allMessages().toList();
  print(message == messages.first);
  
  await user.delete();
}
