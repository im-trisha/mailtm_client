part of '../../../models.dart';

/// Represents a [HydraMessages] object as is, directly provided from mailtm API
@freezed
@JsonSerializable()
class HydraMessages with _$HydraMessages {
  /// The max number of items in [messages]
  static const hydraMax = 30;

  /// [HydraMessages] constructor. `MUST NOT` be used manually
  /// Use [MailTm] and [AuthorizedUser]
  const HydraMessages({required this.messages, required this.totalItems});

  /// The messages in hydra:member
  @override
  @JsonKey(name: 'hydra:member')
  final List<Message> messages;

  /// The total number of items.
  @override
  @JsonKey(name: 'hydra:totalItems')
  final int totalItems;

  /// [HydraMessages] fromJson
  factory HydraMessages.fromJson(Map<String, Object?> json) =>
      _$HydraMessagesFromJson(json);

  /// [HydraMessages] toJson
  Map<String, Object?> toJson() => _$HydraMessagesToJson(this);
}
