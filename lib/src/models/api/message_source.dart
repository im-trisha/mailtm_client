part of '../../models.dart';

/// Represents a [MessageSource] object as is, directly provided from mailtm API
@freezed
class MessageSource with _$MessageSource {
  /// [MessageSource] constructor. `MUST NOT` be used manually
  /// Use [MailTm] and [AuthorizedUser]
  const factory MessageSource({
    /// The id of the message.
    required String id,

    /// Message download url
    @Default('') String url,

    /// Message data
    required String data,
  }) = _MessageSource;

  /// [MessageSource] jsonizer. Allows freezed to add a from/toJson
  factory MessageSource.fromJson(Map<String, Object?> json) =>
      _$MessageSourceFromJson(json);
}
