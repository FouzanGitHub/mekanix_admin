// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  bool? isEmailVerified;
  bool? isAdmin;
  bool? isOnline;
  bool? isAccountApproved;
  String? profile;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.isEmailVerified,
    this.isAdmin,
    this.isOnline,
    this.isAccountApproved,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isEmailVerified: json["is_email_verified"],
        isAdmin: json["is_admin"],
        isOnline: json["is_online"],
        isAccountApproved: json["is_account_approved"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_email_verified": isEmailVerified,
        "is_admin": isAdmin,
        "is_online": isOnline,
        "is_account_approved": isAccountApproved,
        "profile": profile,
      };
}
