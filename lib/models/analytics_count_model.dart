import 'dart:convert';

ActivtiesCount activtiesCountFromJson(String str) =>
    ActivtiesCount.fromJson(json.decode(str));

String activtiesCountToJson(ActivtiesCount data) => json.encode(data.toJson());

class ActivtiesCount {
  int? totalUsers;
  int? verifiedUsers;
  int? unverifiedUsers;
  int? approvedAccount;
  int? unapprovedAccount;
  int? generatorCount;
  int? compressorCount;
  int? formsCount;
  int? templatesCount;

  ActivtiesCount({
    this.totalUsers,
    this.verifiedUsers,
    this.unverifiedUsers,
    this.approvedAccount,
    this.unapprovedAccount,
    this.generatorCount,
    this.compressorCount,
    this.formsCount,
    this.templatesCount,
  });

  factory ActivtiesCount.fromJson(Map<String, dynamic> json) => ActivtiesCount(
        totalUsers: json["total_users"],
        verifiedUsers: json["verified_users"],
        unverifiedUsers: json["unverified_users"],
        approvedAccount: json["approved_account"],
        unapprovedAccount: json["unapproved_account"],
        generatorCount: json["generator_count"],
        compressorCount: json["compressor_count"],
        formsCount: json["form"],
        templatesCount: json["templates"],
      );

  Map<String, dynamic> toJson() => {
        "total_users": totalUsers,
        "verified_users": verifiedUsers,
        "unverified_users": unverifiedUsers,
        "approved_account": approvedAccount,
        "unapproved_account": unapprovedAccount,
        "generator_count": generatorCount,
        "compressor_count": compressorCount,
        "form": formsCount,
        "templates": templatesCount,
      };
}
