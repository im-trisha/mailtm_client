part of '../../models.dart';

/// Represents an Account object as is, directly provided from mailtm API
@freezed
sealed class Account with _$Account {
  /// Account constructor. `MUST NOT` be used manually
  /// Use [MailTm] and [AuthorizedUser]
  const factory Account({
    /// Account's id.
    required String id,

    /// Account's address.
    required String address,

    /// Account's quota (To store message data).
    required int quota,

    /// Account's quota used.
    required int used,

    /// Whether the account is active or not.
    required bool isDisabled,

    /// Whenever the account is deleted.
    required bool isDeleted,

    /// Account creation date
    required DateTime createdAt,

    /// Account update date
    required DateTime updatedAt,
  }) = _Account;

  /// Account jsonizer. Allows freezed to add a from/toJson
  factory Account.fromJson(Map<String, Object?> json) =>
      _$AccountFromJson(json);
}
