part of '../../models.dart';

/// Represents a [Domain] object as is, directly provided from mailtm API
@freezed
sealed class Domain with _$Domain {
  /// [Domain] constructor. `MUST NOT` be used manually
  /// Use [MailTm] and [AuthorizedUser]
  const factory Domain({
    /// Domain's id
    required String id,

    /// Domain as string (example: @mailtm.com)
    required String domain,

    /// If the domain is active
    required bool isActive,

    /// If the domain is private
    required bool isPrivate,

    /// When the domain was created
    required DateTime createdAt,

    /// When the domain was updated
    required DateTime updatedAt,
  }) = _Domain;

  /// [Domain] jsonizer. Allows freezed to add a from/toJson
  factory Domain.fromJson(Map<String, Object?> json) => _$DomainFromJson(json);
}
