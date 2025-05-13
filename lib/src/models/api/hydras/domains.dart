part of '../../../models.dart';

/// Represents a [HydraDomains] object as is, directly provided from mailtm API
@freezed
sealed class HydraDomains with _$HydraDomains {
  /// The max number of items in [domains]
  static const hydraMax = 30;

  /// [HydraDomains] constructor. `MUST NOT` be used manually
  /// Use [MailTm] and [AuthorizedUser]
  const factory HydraDomains({
    /// The domains in hydra:member
    @JsonKey(name: 'hydra:member') required List<Domain> domains,

    /// The total number of items.
    @JsonKey(name: 'hydra:totalItems') required int totalItems,
  }) = _HydraDomains;

  /// [HydraDomains] jsonizer. Allows freezed to add a from/toJson
  factory HydraDomains.fromJson(Map<String, Object?> json) =>
      _$HydraDomainsFromJson(json);
}
