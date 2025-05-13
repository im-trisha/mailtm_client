part of '../../models.dart';

/// Represents an Attachment object as is, directly provided from mailtm API
@freezed
sealed class Attachment with _$Attachment {
  const Attachment._();

  /// Attachment constructor. `MUST NOT` be used manually
  /// Use [MailTm] and [AuthorizedUser]
  const factory Attachment({
    /// The attachment id.
    required String id,

    /// The attachment filename.
    @JsonKey(name: 'filename') @Default('') String name,

    /// The attachment contentType.
    @JsonKey(name: 'contentType') @Default('') String type,

    /// The attachment disposition.
    required String disposition,

    /// The attachment transferEncoding.
    @JsonKey(name: 'transferEncoding') @Default('') String encoding,

    /// The attachment related flag.
    required bool related,

    /// The attachment size.
    required int size,

    /// The attachment downloadUrl.
    required String downloadUrl,
  }) = _Attachment;

  /// Attachment jsonizer. Allows freezed to add a from/toJson
  factory Attachment.fromJson(Map<String, Object?> json) =>
      _$AttachmentFromJson(json);
}
