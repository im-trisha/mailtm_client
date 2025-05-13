part of '../../../models.dart';

/// Represents a [HydraMessages] object as is, directly provided from mailtm API
@freezed
sealed class HydraMessages with _$HydraMessages {
  /// The max number of items in [messages]
  static const hydraMax = 30;

  /// [HydraMessages] constructor. `MUST NOT` be used manually
  /// Use [MailTm] and [AuthorizedUser]
  const factory HydraMessages({
    /// The messages in hydra:member
    @JsonKey(name: 'hydra:member') required List<Message> messages,

    /// The total number of items.
    @JsonKey(name: 'hydra:totalItems') required int totalItems,
  }) = _HydraMessages;

  /// [HydraMessages] jsonizer. Allows freezed to add a from/toJson
  factory HydraMessages.fromJson(Map<String, Object?> json) =>
      _$HydraMessagesFromJson(json);
}
