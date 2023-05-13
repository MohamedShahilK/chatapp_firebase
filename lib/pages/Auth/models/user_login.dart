// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserLoginModel {
  String? accessToken;
  String? displayName;
  String? email;
  String? photoUrl;

  UserLoginModel({
    this.accessToken,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  // static Future<UserLoginModel> fromLocalValues({
  //   required String accessToken,
  //   required String displayName,
  //   required String email,
  //   required String photoUrl,
  // }) {
  //   return UserLoginModel(
  //     accessToken: accessToken
  //   );
  // }

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      accessToken: json["access_token"],
      displayName: json["display_name"],
      email: json["email"],
      photoUrl: json["photoUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "display_name": displayName,
        "email": email,
        "photoUrl": photoUrl,
      };
}
