part of '../../models.dart';

/// Represents an Attachment object as is, directly provided from mailtm API
@freezed
@JsonSerializable()
sealed class Attachment with _$Attachment {
  /// Attachment constructor. `MUST NOT` be used manually
  /// Use [MailTm] and [AuthorizedUser]
  const Attachment({
    required this.id,

    this.name = '',

    this.type = '',

    required this.disposition,

    this.encoding = '',

    required this.related,

    required this.size,

    required this.downloadUrl,
  });

  /// The attachment id.
  @override
  final String id;

  /// The attachment filename.
  @override
  @JsonKey(name: 'filename')
  final String name;

  /// The attachment contentType.
  @override
  @JsonKey(name: 'contentType')
  final String type;

  /// The attachment disposition.
  @override
  final String disposition;

  /// The attachment transferEncoding.
  @override
  @JsonKey(name: 'transferEncoding')
  final String encoding;

  /// The attachment related flag.
  @override
  final bool related;

  /// The attachment size.
  @override
  final int size;

  /// The attachment downloadUrl.
  @override
  final String downloadUrl;

  /// [Attachment] fromJson.
  factory Attachment.fromJson(Map<String, Object?> json) =>
      _$AttachmentFromJson(json);

  /// [Attachment] toJson.
  Map<String, Object?> toJson() => _$AttachmentToJson(this);
}
