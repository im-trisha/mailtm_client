part of '../../models.dart';
// TODO: Is it good to set flagged and other bools to that default value?
// TODO: Could this be other than null? Maybe epoch?
// TODO: verifications?

/// Represents a [Message] object as is, directly provided from mailtm API
@freezed
sealed class Message with _$Message {
  /// [Message] constructor. `MUST NOT` be used manually
  /// Use [MailTm] and [AuthorizedUser]
  const factory Message({
    /// The unique identifier of the message (MailTm DB).
    required String id,

    /// The unique identifier of the account.
    required String accountId,

    /// The unique identifier of the message
    /// (Global, both the receiver service and MailTm will know this).
    required String msgid,

    /// The introduction of the message.
    @Default('') String intro,

    /// The sender of the message.
    required Map<String, String> from,

    /// The recipients of the message.
    required List<Map<String, String>> to,

    /// The carbon copy recipients of the message.
    @Default([]) List<String> cc,

    /// The blind carbon copy recipients of the message.
    @Default([]) List<String> bcc,

    /// The subject of the message.
    @Default('') String subject,

    /// Whether the message has been seen.
    required bool seen,

    /// Whether the message has been flagged.
    @Default(false) bool flagged,

    /// Whether the message has been deleted.
    required bool isDeleted,

    /// The verifications of the message.
    @Default({}) Map<String, dynamic> verifications,

    /// If the message has arrived
    @Default(false) bool retention,

    /// The date of the message retention.
    DateTime? retentionDate,

    /// The text of the message.
    @Default('') String text,

    /// The HTML of the message.
    @Default([]) List<String> html,

    /// Whether the message has attachments.
    required bool hasAttachments,

    /// List of the message.
    @Default([]) List<Attachment> attachments,

    /// The size of the message.
    required int size,

    /// The downloadUrl of the message.
    required String downloadUrl,

    /// The date of the message creation.
    required DateTime createdAt,

    /// When the message was seen
    required DateTime updatedAt,
  }) = _Message;

  /// [Message] jsonizer. Allows freezed to add a from/toJson
  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);
}
