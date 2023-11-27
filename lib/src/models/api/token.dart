part of '../../models.dart';

/// Represents a [Token] object as is, directly provided from mailtm API
@freezed
class Token with _$Token {
  /// [Token] constructor. `MUST NOT` be used manually
  /// Use [MailTm] and [AuthorizedUser]
  const factory Token({
    /// The id of the account.
    required String id,

    /// JWT Token
    required String token,
  }) = _Token;

  /// [Token] jsonizer. Allows freezed to add a from/toJson
  factory Token.fromJson(Map<String, Object?> json) => _$TokenFromJson(json);
}
