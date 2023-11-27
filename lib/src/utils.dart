import 'dart:math';

/// All the usable characters for a random username/password
final _random = Random.secure();
const String _charset =
    '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

/// Generate a random string of [length] characters
String randomString(int length) {
  final codeUnits = List<int>.generate(
    length,
    (index) => _charset.codeUnitAt(_random.nextInt(_charset.length)),
  );
  return String.fromCharCodes(codeUnits);
}
