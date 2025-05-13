part of '../../../models.dart';

/// Represents a [HydraDomains] object as is, directly provided from mailtm API
@freezed
@JsonSerializable()
class HydraDomains with _$HydraDomains {
  /// The max number of items in [domains]
  static const hydraMax = 30;

  /// [HydraDomains] constructor. `MUST NOT` be used manually
  /// Use [MailTm] and [AuthorizedUser]
  const HydraDomains({required this.domains, required this.totalItems});

  /// The domains in hydra:member
  @override
  @JsonKey(name: 'hydra:member')
  final List<Domain> domains;

  /// The total number of items.
  @override
  @JsonKey(name: 'hydra:totalItems')
  final int totalItems;

  /// [HydraDomains] fromJson
  factory HydraDomains.fromJson(Map<String, Object?> json) =>
      _$HydraDomainsFromJson(json);

  /// [HydraDomains] toJson
  Map<String, Object?> toJson() => _$HydraDomainsToJson(this);
}
